﻿
&НаСервере
Процедура pcru_ex_ПриСозданииНаСервереВместо(Отказ, СтандартнаяОбработка)
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ЭтоПлательщик = Параметры.ЭтоПлательщик;
	
	ОрганизацияИП = ?(ЭтоПлательщик,
		(Перечисления.ЮридическоеФизическоеЛицо.ФизическоеЛицо =
		ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Параметры.Объект.Организация, "ЮридическоеФизическоеЛицо")),
		Ложь);
	
	ПереводМеждуСчетами         = Параметры.Объект.ВидОперации = Перечисления.ВидыОперацийСписаниеДенежныхСредств.ПереводНаДругойСчет;
	ПеречислениеФизическомуЛицу = УчетДенежныхСредствКлиентСервер.РасчетыСФизическимиЛицами(Параметры.Объект.ВидОперации);
	ПеречислениеНаЛичныйСчет    = ПеречислениеФизическомуЛицу И НЕ ЗначениеЗаполнено(Параметры.Объект.Банк);
	
	АвтоЗначенияРеквизитов = УчетДенежныхСредствБП.СформироватьАвтоЗначенияРеквизитовПлательщикаПолучателя(
		Параметры.Объект.Организация,
		Параметры.Объект.СчетОрганизации,
		?(ПереводМеждуСчетами, Параметры.Объект.Организация,
			?(ПеречислениеФизическомуЛицу И НЕ ПеречислениеНаЛичныйСчет, Параметры.Объект.Банк, Параметры.Объект.Контрагент)),
		Параметры.Объект.СчетКонтрагента,
		Истина,
		Параметры.Объект.Дата);
	
	Если ЭтоПлательщик Тогда
		ВсегдаУказыватьКПП     = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Параметры.Объект.СчетОрганизации, "ВсегдаУказыватьКПП");
		ТекстНаименования      = Параметры.Объект.ТекстПлательщика;
		УказаниеКППОбязательно = Параметры.Объект.ПеречислениеВБюджет ИЛИ НЕ ОрганизацияИП И ВсегдаУказыватьКПП;
		
		ИНН = Параметры.Объект.ИННПлательщика;
		КПП = Параметры.Объект.КПППлательщика;
		
		ИННОбъекта = АвтоЗначенияРеквизитов.ИННПлательщика;
		Если УказаниеКППОбязательно Тогда
			Если НЕ ПустаяСтрока(КПП) Тогда
				КППОбъекта = КПП;
			ИначеЕсли НЕ ПустаяСтрока(АвтоЗначенияРеквизитов.КПППлательщика) Тогда
				КППОбъекта = АвтоЗначенияРеквизитов.КПППлательщика;
			ИначеЕсли ЭтоПлательщик И ОрганизацияИП Тогда
				КППОбъекта = ПлатежиВБюджетКлиентСервер.НезаполненноеЗначение();
			КонецЕсли;
		КонецЕсли;
	Иначе
		Если ПереводМеждуСчетами Тогда
			ПолучательФизЛицо = ОрганизацияИП;
		ИначеЕсли ПеречислениеФизическомуЛицу Тогда
			Если ПеречислениеНаЛичныйСчет Тогда
				ПолучательФизЛицо = Истина;
			ИначеЕсли ЗначениеЗаполнено(Параметры.Объект.Банк) Тогда
				СтранаРегистрацииПолучателя = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Параметры.Объект.Банк, "СтранаРегистрации");
				ПолучательНерезидент        = СтранаРегистрацииПолучателя <> Справочники.СтраныМира.Россия;
			КонецЕсли;
		Иначе
			Если Параметры.Объект.ВидОперации = Перечисления.ВидыОперацийСписаниеДенежныхСредств.ПеречислениеДивидендов
				И ТипЗнч(Параметры.Объект.Контрагент) = Тип("СправочникСсылка.ФизическиеЛица") Тогда
				ПолучательФизЛицо = Истина;
				СтранаРегистрацииПолучателя = Справочники.СтраныМира.Россия;
			Иначе
				ПолучательФизЛицо = Перечисления.ЮридическоеФизическоеЛицо.ФизическоеЛицо =
					ОбщегоНазначения.ЗначениеРеквизитаОбъекта(
						?(ПеречислениеФизическомуЛицу, Параметры.Объект.Банк, Параметры.Объект.Контрагент), "ЮридическоеФизическоеЛицо");
						
				СтранаРегистрацииПолучателя = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Параметры.Объект.Контрагент, "СтранаРегистрации");
			КонецЕсли;
			
			ПолучательНерезидент = СтранаРегистрацииПолучателя <> Справочники.СтраныМира.Россия;
		КонецЕсли;
		
		ТекстНаименования      = Параметры.Объект.ТекстПолучателя;
		УказаниеКППОбязательно = НЕ ПолучательФизЛицо И НЕ ПолучательНерезидент
			И (Параметры.Объект.ПеречислениеВБюджет
			ИЛИ ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Параметры.Объект.СчетКонтрагента, "ВсегдаУказыватьКПП"));
		
		ИНН = Параметры.Объект.ИННПолучателя;
		КПП = Параметры.Объект.КПППолучателя;
		
		ИННОбъекта = АвтоЗначенияРеквизитов.ИННПолучателя;
		Если УказаниеКППОбязательно И НЕ ПустаяСтрока(КПП) Тогда
			КППОбъекта = КПП;
		Иначе
			КППОбъекта = АвтоЗначенияРеквизитов.КПППолучателя
		КонецЕсли;
	КонецЕсли;
	
	Если НЕ ЭтоПлательщик Тогда
		Элементы.ИНН.Заголовок = НСтр("ru = 'ИНН получателя'");
		Элементы.КПП.Заголовок = НСтр("ru = 'КПП получателя'");
		Элементы.ТекстНаименования.Заголовок = НСтр("ru = 'Наименование получателя'");
	КонецЕсли;
	
	ПлательщикаПолучателя = ?(ЭтоПлательщик, НСтр("ru = 'плательщика'"), НСтр("ru = 'получателя'"));
	
	ТекстИННВладельца = НСтр("ru = '%1 - ИНН, указанный для %2'");
	ТекстИННВладельца = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		ТекстИННВладельца, ИННОбъекта, ПлательщикаПолучателя);
	Элементы.ИНН.СписокВыбора.Добавить(ИННОбъекта, ТекстИННвладельца);
	
	ТекстКППвладельца = НСтр("ru = '%1 - КПП, указанный для %2 (основной)'");
	
	ТекстКППвладельца = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		ТекстКППвладельца, КППОбъекта, ПлательщикаПолучателя);
	Элементы.КПП.СписокВыбора.Добавить(КППОбъекта, ТекстКППвладельца);
	
	Если ЭтоПлательщик Тогда
		ЗаполнитьСписокКПП(СписокКПП, Параметры.Объект.Организация);
		Если СписокКПП.Количество() > 1 Тогда
			Для каждого ЭлементКПП Из СписокКПП Цикл
				//Если Элементы.КПП.СписокВыбора.НайтиПоЗначению(ЭлементКПП.Значение) <> Неопределено Тогда
				//	Продолжить;
				//КонецЕсли;
				
				ТекстШаблона = НСтр("ru = '%1 - КПП в налоговом органе ""%2""'");
				КПППредставление = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					ТекстШаблона, ЭлементКПП.Значение, ЭлементКПП.Представление);
				Элементы.КПП.СписокВыбора.Добавить(ЭлементКПП.Значение, КПППредставление);
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;
	
	УстановитьДоступность();
	
	Заголовок = ?(ЭтоПлательщик, НСтр("ru = 'Реквизиты плательщика'"), НСтр("ru = 'Реквизиты получателя'"));
КонецПроцедуры
