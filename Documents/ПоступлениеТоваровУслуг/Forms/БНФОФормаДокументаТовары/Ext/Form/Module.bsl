﻿
&НаКлиенте
Процедура pcru_ex_КонтрагентПриИзмененииПосле(Элемент)
	ПриИзмененииРеквизитов();
КонецПроцедуры

&НаКлиенте
Процедура pcru_ex_ДоговорКонтрагентаПриИзмененииПосле(Элемент)
	ПриИзмененииРеквизитов();
КонецПроцедуры


&НаСервере
Процедура ПриИзмененииРеквизитов()
	Если ЗначениеЗаполнено(ЭтотОбъект.Объект.Контрагент) и ЗначениеЗаполнено(ЭтотОбъект.Объект.ДоговорКонтрагента) Тогда
		ЭтотОбъект.Объект.СчетУчетаРасчетовСКонтрагентом  = pcru_УМФО.ПолучитьСчетПоАналитике("60311",ЭтотОбъект.Объект.Контрагент,ЭтотОбъект.Объект.ДоговорКонтрагента);
		Если не ЗначениеЗаполнено(ЭтотОбъект.Объект.СчетУчетаРасчетовСКонтрагентом) Тогда
			ЭтотОбъект.Объект.СчетУчетаРасчетовСКонтрагентом =  pcru_УМФО.Открыть60311(ЭтотОбъект.Объект.Контрагент,ЭтотОбъект.Объект.ДоговорКонтрагента,"000000059");
		КонецЕсли; 
		ЭтотОбъект.Объект.СчетУчетаРасчетовПоАвансам  = pcru_УМФО.ПолучитьСчетПоАналитике("60312",ЭтотОбъект.Объект.Контрагент,ЭтотОбъект.Объект.ДоговорКонтрагента);
		ЭтотОбъект.Объект.СпособЗачетаАвансов = Перечисления.СпособыЗачетаАвансов.Автоматически;
		ЭтотОбъект.Объект.БНФОПризнакДоверительногоУправления = Перечисления.БНФОПризнакиДоверительногоУправления.СобственныеОперации;
	КонецЕсли; 
	ПоступлениеТоваровУслугФормы.УстановитьПорядокУчетаРасчетов(ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура pcru_ex_ТоварыНоменклатураПриИзмененииПосле(Элемент)
	Элемент.Родитель.ТекущиеДанные.СчетУчета = ПолучитьСчетМатериалы();
	Элемент.Родитель.ТекущиеДанные.СчетУчетаНДС = ПолучитьСчетМатериалыНДС();
КонецПроцедуры

&НаСервере
Функция  ПолучитьСчетМатериалы()
	Возврат Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("6100881000000000000100000");
КонецФункции


&НаСервере
Функция  ПолучитьСчетМатериалыНДС()
	Возврат Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("6031081000000000000100000");
КонецФункции




&НаКлиенте
Процедура pcru_ex_ЭтоОсновноеСредствоВместо(Команда)
	Если ЭтаФорма.Элементы.Товары.ТекущиеДанные <> Неопределено Тогда
		ЭтаФорма.Элементы.Товары.ТекущиеДанные.СчетУчета  = pcru_УМФО.ПолучитьСчетОС(ЭтаФорма.Элементы.Товары.ТекущиеДанные.Номенклатура);
	КонецЕсли; 	
КонецПроцедуры

&НаСервере
Функция  ПолучитьСчетОС(Номенклатура)
	Попытка
		//Запрос = Новый Запрос;
		//Запрос.Текст = "ВЫБРАТЬ
		//               |	ОсновныеСредства.Ссылка КАК Ссылка
		//               |ИЗ
		//               |	Справочник.ОсновныеСредства КАК ОсновныеСредства
		//               |		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ПринятиеКУчетуОС.ОС КАК ПринятиеКУчетуОСОС
		//               |		ПО ПринятиеКУчетуОСОС.ОсновноеСредство = ОсновныеСредства.Ссылка
		//               |ГДЕ
		//               |	ОсновныеСредства.НаименованиеПолное = &НаименованиеПолное
		//               |	И ПринятиеКУчетуОСОС.Ссылка ЕСТЬ NULL";
		//Запрос.УстановитьПараметр("НаименованиеПолное",Номенклатура.НаименованиеПолное);
		//Выборка = Запрос.Выполнить().Выбрать();
		//Если Выборка.Следующий() Тогда
		//	ОССсылка =  Выборка.Ссылка;
		//Иначе
		ОС = Справочники.ОсновныеСредства.СоздатьЭлемент();
		ОС.Наименование =  Номенклатура.Наименование;
		ОС.НаименованиеПолное = Номенклатура.НаименованиеПолное; 
		ОС.ГруппаОС = Перечисления.ГруппыОС.ДругиеВидыОсновныхСредств;
		ОС.БНФОГруппаФинансовогоУчета = Справочники.БНФОГруппыФинансовогоУчетаАктивов.НайтиПоКоду("00060401");
		ОС.Записать();
		ОССсылка = ОС.Ссылка;
		//		КонецЕсли;	 
		НОБ = Номенклатура.ПолучитьОбъект();
		НОБ.БНФОГруппаФинансовогоУчета = Справочники.БНФОГруппыФинансовогоУчетаАктивов.НайтиПоНаименованию("Основные средства (кроме земля)");
		НОБ.Записать();
		Счет60415 = pcru_УМФО.ПолучитьСчетПоАналитике("60415",ОССсылка);
		Если ЗначениеЗаполнено(Счет60415) Тогда
			Возврат Счет60415;
		Иначе	
			pcru_УМФО.Открыть60401(ОССсылка);
			Возврат pcru_УМФО.ПолучитьСчетПоАналитике("60415",ОССсылка);
		КонецЕсли; 
	Исключение
		Ошибка=ОписаниеОшибки();
		Возврат Неопределено;
	КонецПопытки; 	
КонецФункции

&НаКлиенте
Процедура pcru_ex_PCRU_ЗапроситьВложенныйИзДиадокПосле(Команда) 
	ПараметрыОтбора = Новый Структура;
	ПараметрыОтбора.Вставить("Ссылка", ЭтаФорма.Объект.Ссылка);	
	Оповестить("ЗапросПрикрепленногоДокумента",ПараметрыОтбора);
КонецПроцедуры
