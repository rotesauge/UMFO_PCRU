﻿
#Область ПЕРМЕННЫЕ_ПЛАТФОРМЫ

&НаКлиенте
Перем Платформа Экспорт;

&НаСервере
Перем ОбработкаОбъект;

#КонецОбласти

#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ПЛАТФОРМЫ

&НаКлиенте
Функция МетодКлиента(ИмяМодуля= "", ИмяМетода, 
		Параметр0= NULL, Параметр1= NULL, Параметр2= NULL, Параметр3= NULL, Параметр4= NULL,
		Параметр5= NULL, Параметр6= NULL, Параметр7= NULL, Параметр8= NULL, Параметр9= NULL) Экспорт
	
	Возврат  Платформа.МетодКлиента(ИмяМодуля, ИмяМетода, 
	Параметр0, Параметр1, Параметр2, Параметр3, Параметр4,
	Параметр5, Параметр6, Параметр7, Параметр8, Параметр9);
	
КонецФункции

&НаКлиенте
Функция МетодСервераБезКонтекста(ИмяМодуля= "", ИмяМетода,
		Параметр0= NULL, Параметр1= NULL, Параметр2= NULL, Параметр3= NULL, Параметр4= NULL, 
		Параметр5= NULL, Параметр6= NULL, Параметр7= NULL, Параметр8= NULL, Параметр9= NULL) Экспорт
	
	Возврат Платформа.МетодСервераБезКонтекста(ИмяМодуля, ИмяМетода,
	Параметр0, Параметр1, Параметр2, Параметр3, Параметр4,
	Параметр5, Параметр6, Параметр7, Параметр8, Параметр9);
	
КонецФункции

&НаСервере
Функция МетодСервера(Знач ИмяМодуля= "", Знач ИмяМетода,
		Параметр0= NULL, Параметр1= NULL, Параметр2= NULL, Параметр3= NULL, Параметр4= NULL, 
		Параметр5= NULL, Параметр6= NULL, Параметр7= NULL, Параметр8= NULL, Параметр9= NULL) Экспорт
	
	Возврат ОбработкаОбъект().МетодСервера(ИмяМодуля, ИмяМетода, 
	Параметр0, Параметр1, Параметр2, Параметр3, Параметр4,
	Параметр5, Параметр6, Параметр7, Параметр8, Параметр9);
	
КонецФункции

&НаСервере
Функция ОбработкаОбъект() Экспорт
	
	Если ОбработкаОбъект = Неопределено Тогда
		
		СтруктураОбработки= ПолучитьИзВременногоХранилища(Объект.ПараметрыКлиентСервер.ВременноеХранилище.АдресОбработкаОбъект);
		
		Если СтруктураОбработки <> Неопределено Тогда
			ОбработкаОбъект= СтруктураОбработки.ОбработкаОбъект;
		КонецЕсли;
		
		Если ОбработкаОбъект = Неопределено Тогда
			
			ОбработкаОбъект= РеквизитФормыВЗначение("Объект");
			
			Попытка
				ПоместитьВоВременноеХранилище(Новый Структура("ОбработкаОбъект", ОбработкаОбъект), Объект.ПараметрыКлиентСервер.ВременноеХранилище.АдресОбработкаОбъект);
			Исключение КонецПопытки;
		
		Иначе
			ОбработкаОбъект.ПараметрыКлиентСервер= Объект.ПараметрыКлиентСервер;
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат ОбработкаОбъект;
	
КонецФункции

&НаКлиенте
Функция ОсновнаяФорма(ТекущийВладелецФормы)
	
	Если ТекущийВладелецФормы = Неопределено Тогда
		Возврат Неопределено
	ИначеЕсли Прав(ТекущийВладелецФормы.ИмяФормы, 14) = "Форма_Основная" Тогда
		Возврат ТекущийВладелецФормы;
	Иначе
		Возврат ОсновнаяФорма(ТекущийВладелецФормы.ВладелецФормы);
	КонецЕсли;
	
КонецФункции


&НаСервере
Процедура ПлатформаПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Свойство("ОбъектПараметрыКлиентСервер", Объект.ПараметрыКлиентСервер);
	
КонецПроцедуры

&НаКлиенте
Процедура ПлатформаПриОткрытии(Отказ)
	
	ОсновнаяФорма= ОсновнаяФорма(ВладелецФормы);
	
	Если ОсновнаяФорма <> Неопределено Тогда
		Платформа= ОсновнаяФорма.Платформа;
	КонецЕсли;
		
	Платформа.ПриОткрытииФормыОбработки(ЭтаФорма, Отказ);
	
КонецПроцедуры

&НаКлиенте
Процедура ПлатформаПриЗакрытии()
	
	Платформа.ПриЗакрытииФормыОбработки(ЭтаФорма);
	
КонецПроцедуры

#КонецОбласти

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ПлатформаПриСозданииНаСервере(Отказ, СтандартнаяОбработка);
	
	СписокВПФ.ЗагрузитьЗначения(Параметры.МассивВнешнихПечатныхФорм);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ПлатформаПриОткрытии(Отказ);

КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	ПлатформаПриЗакрытии();
	
КонецПроцедуры


&НаКлиенте
Процедура СписокВПФПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Отказ = Истина;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Отбор", Новый Структура);
	ПараметрыФормы.Отбор.Вставить("ПометкаУдаления", Ложь);
	ПараметрыФормы.Отбор.Вставить("Вид", ПредопределенноеЗначение("Перечисление.ВидыДополнительныхОтчетовИОбработок.ПечатнаяФорма"));
	
	МетодКлиента(,"ОткрытьФормуОбъектаИБМодально",, "Справочник.ДополнительныеОтчетыИОбработки.ФормаВыбора", ПараметрыФормы, ЭтаФорма, "ОбработчикВыбораВПФ");
	
КонецПроцедуры

&НаКлиенте
Процедура СписокВПФПередНачаломИзменения(Элемент, Отказ)
	
	Отказ = Истина;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Отбор", Новый Структура);
	ПараметрыФормы.Отбор.Вставить("ПометкаУдаления", Ложь);
	ПараметрыФормы.Отбор.Вставить("Вид", ПредопределенноеЗначение("Перечисление.ВидыДополнительныхОтчетовИОбработок.ПечатнаяФорма"));
	
	МетодКлиента(,"ОткрытьФормуОбъектаИБМодально",, "Справочник.ДополнительныеОтчетыИОбработки.ФормаВыбора", ПараметрыФормы, ЭтаФорма, "ОбработчикВыбораВПФ", Элемент.ТекущаяСтрока);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикВыбораВПФ(ВПФ, ТекущаяСтрока) Экспорт
	
	Если ВПФ <> Неопределено Тогда
		
		НайденныйЭлемент = СписокВПФ.НайтиПоЗначению(ВПФ);
		
		Если НайденныйЭлемент <> Неопределено Тогда
			
			Элементы.СписокВПФ.ТекущаяСтрока = НайденныйЭлемент.ПолучитьИдентификатор();
		
		ИначеЕсли ТекущаяСтрока <> Неопределено Тогда
			
			СписокВПФ.НайтиПоИдентификатору(ТекущаяСтрока).Значение = ВПФ;
			
		Иначе
			
			СписокВПФ.Добавить(ВПФ);
			
			Элементы.СписокВПФ.ТекущаяСтрока = СписокВПФ.Получить(СписокВПФ.Количество()-1).ПолучитьИдентификатор();
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОК(Команда)
	
	Отказ = Ложь;
	
	Для Каждого ТекСтрока Из СписокВПФ Цикл
		
		Если МетодСервера("Модуль_РаботаСВнешнимиПечатнымиФормами", "ВнешняяПечатнаяФормаЯвляетсяМодулемДиадок", ТекСтрока.Значение) Тогда
			
			СообщениеПользователю		= Новый СообщениеПользователю;
			СообщениеПользователю.Текст	= "Выбранную обработку нельзя использовать в качестве доп. печатной формы: "+ ТекСтрока.Значение;
			СообщениеПользователю.Сообщить();
			
			Отказ = Истина;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Если НЕ Отказ Тогда
		Закрыть(СписокВПФ.ВыгрузитьЗначения());
	КонецЕсли;
	
КонецПроцедуры
