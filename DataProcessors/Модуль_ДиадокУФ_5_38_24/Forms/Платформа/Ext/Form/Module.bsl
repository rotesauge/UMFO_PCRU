﻿
#Область ПЕРЕМЕННЫЕ_ПЛАТФОРМЫ

&НаКлиенте
Перем ПараметрыКлиент Экспорт;

&НаКлиенте
Перем Манифест Экспорт;

&НаКлиенте
Перем КэшМодулей;

&НаКлиенте
Перем ОткрытыеФормы;

&НаКлиенте
Перем КэшНаВремяСеанса;

&НаСервере
Перем ОбработкаОбъект;

#КонецОбласти

#Область ПРОГРАММЫНЙ_ИНТЕРФЕЙС

&НаКлиенте
Функция МетодКлиента(Знач ИмяМодуля, ИмяМетода, 
		Параметр0= NULL, Параметр1= NULL, Параметр2= NULL, Параметр3= NULL, Параметр4= NULL, 
		Параметр5= NULL, Параметр6= NULL, Параметр7= NULL, Параметр8= NULL, Параметр9= NULL) Экспорт
	
	Если НЕ ЗначениеЗаполнено(ИмяМодуля) Тогда
		ИмяМодуля = "Платформа";
	КонецЕсли;
	
	Объект.ПараметрыКлиентСервер = ВладелецФормы.Объект.ПараметрыКлиентСервер;
		
	Результат = ВыполнитьМетод(ИмяМодуля, ИмяМетода
	, Параметр0, Параметр1, Параметр2, Параметр3, Параметр4
	, Параметр5, Параметр6, Параметр7, Параметр8, Параметр9
	);

	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция МетодСервераБезКонтекста(ИмяМодуля, ИмяМетода,
		Параметр0, Параметр1, Параметр2, Параметр3, Параметр4, 
		Параметр5, Параметр6, Параметр7, Параметр8, Параметр9) Экспорт		
		
		
	Объект.ПараметрыКлиентСервер = ВладелецФормы.Объект.ПараметрыКлиентСервер;
		
	Возврат МетодСервера(ИмяМодуля, ИмяМетода,
	Параметр0, Параметр1, Параметр2, Параметр3, Параметр4, 
	Параметр5, Параметр6, Параметр7, Параметр8, Параметр9);
	
КонецФункции

&НаКлиенте
Процедура ОповеститьФормы(ИмяСобытия = Неопределено, Параметр = Неопределено, Источник = Неопределено, Знач ИмяОповещяемойФормы = Неопределено) Экспорт
	
	Если ЗначениеЗаполнено(ИмяОповещяемойФормы) Тогда
		ИмяОповещяемойФормы = ПараметрыКлиент.ПутьКФормам + ИмяОповещяемойФормы;
	КонецЕсли;
	
	Для Каждого КлючИЗначение ИЗ ОткрытыеФормы Цикл
		
		ОткрытаяФорма	 = КлючИЗначение.Ключ;
		ИмяОткрытойФормы = КлючИЗначение.Значение;
		
		Если ЗначениеЗаполнено(ИмяОповещяемойФормы) И ИмяОткрытойФормы <> ИмяОповещяемойФормы Тогда
			Продолжить;
		КонецЕсли;
		
		Если ОткрытаяФорма = Источник Тогда
			Продолжить;
		КонецЕсли;
		
		Попытка
			ОткрытаяФорма.ОбработкаОповещения(ИмяСобытия, Параметр, Источник);
		Исключение КонецПопытки;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьФормуОбработки(ИмяНовойФормы, ПараметрыНовойФормы= Неопределено, ВладелецНовойФормы= Неопределено, УникальностьНовойФормы= Ложь) Экспорт
	
	Если ПараметрыНовойФормы = Неопределено Тогда
		ПараметрыНовойФормы= Новый Структура;
	КонецЕсли;
	
	Если НЕ ПараметрыНовойФормы.Свойство("ЗакрыватьПриЗакрытииВладельца") Тогда
		ПараметрыНовойФормы.Вставить("ЗакрыватьПриЗакрытииВладельца", Истина);
	КонецЕсли;
	
	ПараметрыНовойФормы.Вставить("ОбъектПараметрыКлиентСервер", ВладелецФормы.Объект.ПараметрыКлиентСервер);
	
	Если ВладелецНовойФормы = Неопределено Тогда
		ВладелецНовойФормы= ВладелецФормы;
	КонецЕсли;
	
	ПолучаемаяФорма= ПолучитьФорму(ПараметрыКлиент.ПутьКФормам+ИмяНовойФормы
	, ПараметрыНовойФормы
	, ВладелецНовойФормы
	, УникальностьНовойФормы);
	
	ПолучаемаяФорма.Объект.ПараметрыКлиентСервер = ВладелецФормы.Объект.ПараметрыКлиентСервер;
	
	Возврат ПолучаемаяФорма;
	
КонецФункции

&НаКлиенте
Процедура ОткрытьФормуОбработки(ИмяНовойФормы, ПараметрыНовойФормы= Неопределено, ВладелецНовойФормы= Неопределено,
								ИмяОбработчика= "", ПараметрыОбработчика= Неопределено, ВладелецОбработчика= Неопределено, УникальностьНовойФормы= Ложь, РежимОткрытияОкнаНовойФормы= Неопределено) Экспорт
	
	Перем ОписаниеОбработчика;
	
	Если ВладелецНовойФормы = Неопределено Тогда
		ВладелецНовойФормы= ВладелецФормы;
	КонецЕсли;
	
	Если НЕ ПустаяСтрока(ИмяОбработчика) Тогда
		ОписаниеОбработчика= Новый ОписаниеОповещения(ИмяОбработчика,
		?(ТипЗнч(ВладелецОбработчика) = Тип("Строка"), ПолучитьМодуль(ВладелецОбработчика), ?(ВладелецОбработчика = Неопределено, ВладелецНовойФормы, ВладелецОбработчика)),
		ПараметрыОбработчика);
	КонецЕсли;
	
	Если ПараметрыНовойФормы = Неопределено Тогда
		ПараметрыНовойФормы = Новый Структура;
	КонецЕсли;
	
	ПараметрыНовойФормы.Вставить("ОбъектПараметрыКлиентСервер", ВладелецФормы.Объект.ПараметрыКлиентСервер);

	Если НЕ ПараметрыНовойФормы.Свойство("ЗакрыватьПриЗакрытииВладельца") Тогда
		ПараметрыНовойФормы.Вставить("ЗакрыватьПриЗакрытииВладельца", Истина);
	КонецЕсли;
	
	ОткрытьФорму(ПараметрыКлиент.ПутьКФормам + ИмяНовойФормы, ПараметрыНовойФормы, ВладелецНовойФормы,,,,ОписаниеОбработчика, РежимОткрытияОкнаНовойФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуОбработкиМодально(ИмяНовойФормы, ПараметрыНовойФормы= Неопределено, ВладелецНовойФормы= Неопределено,
										ИмяОбработчика= "", ПараметрыОбработчика= Неопределено, ВладелецОбработчика= Неопределено, УникальностьНовойФормы= Ложь) Экспорт
										
  	//ОткрытьФормуОбработки(ИмяНовойФормы, ПараметрыНовойФормы, ВладелецНовойФормы, ИмяОбработчика, ПараметрыОбработчика, ВладелецОбработчика, УникальностьНовойФормы, ПредопределенноеЗначение("РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс"));
	ОткрытьФормуОбработки(ИмяНовойФормы, ПараметрыНовойФормы, ВладелецНовойФормы, ИмяОбработчика, ПараметрыОбработчика, ВладелецОбработчика, УникальностьНовойФормы, ПредопределенноеЗначение("РежимОткрытияОкнаФормы.БлокироватьОкноВладельца"));
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуОбъектаИБ(Ссылка= Неопределено, ИмяНовойФормы="", ПараметрыНовойФормы= Неопределено, ВладелецНовойФормы= Неопределено,
													  ИмяОбработчика= "", ПараметрыОбработчика= Неопределено, ВладелецОбработчика= Неопределено, РежимОткрытияОкнаНовойФормы= Неопределено) Экспорт
	
	Перем ОписаниеОбработчика;
	
	Если НЕ ПустаяСтрока(ИмяОбработчика) Тогда
		ОписаниеОбработчика= Новый ОписаниеОповещения(ИмяОбработчика,
		?(ТипЗнч(ВладелецОбработчика) = Тип("Строка"), ПолучитьМодуль(ВладелецОбработчика), ?(ВладелецОбработчика = Неопределено, ВладелецНовойФормы, ВладелецОбработчика)),
		ПараметрыОбработчика);
	КонецЕсли;
	
	Если ПараметрыНовойФормы = Неопределено Тогда
		ПараметрыНовойФормы= Новый Структура;
	КонецЕсли;
	
	Если ПустаяСтрока(ИмяНовойФормы) Тогда
		ИмяНовойФормы= МетодКлиента("Модуль_Клиент", "ПолучитьОписаниеФормы", Ссылка);
	КонецЕсли;
		
	Если НЕ ПараметрыНовойФормы.Свойство("Ключ") И ЗначениеЗаполнено(Ссылка) Тогда
		ПараметрыНовойФормы.Вставить("Ключ", Ссылка);
	КонецЕсли;
	
	ОткрытьФорму(ИмяНовойФормы, ПараметрыНовойФормы, ВладелецНовойФормы,,,,ОписаниеОбработчика, РежимОткрытияОкнаНовойФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуОбъектаИБМодально(Ссылка= Неопределено, ИмяНовойФормы="", ПараметрыНовойФормы= Неопределено, ВладелецНовойФормы= Неопределено,
													  		  ИмяОбработчика= "", ПараметрыОбработчика= Неопределено, ВладелецОбработчика= Неопределено) Экспорт
	
	//ОткрытьФормуОбъектаИБ(Ссылка, ИмяНовойФормы, ПараметрыНовойФормы, ВладелецНовойФормы, ИмяОбработчика, ПараметрыОбработчика, ВладелецОбработчика, ПредопределенноеЗначение("РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс"));
	ОткрытьФормуОбъектаИБ(Ссылка, ИмяНовойФормы, ПараметрыНовойФормы, ВладелецНовойФормы, ИмяОбработчика, ПараметрыОбработчика, ВладелецОбработчика, ПредопределенноеЗначение("РежимОткрытияОкнаФормы.БлокироватьОкноВладельца"));
	
КонецПроцедуры

&НаСервере
Процедура ВыгрузитьШаблонПодключаемогоМодуля(ПолноеИмяФайла) Экспорт
	
	ОсновнаяОбработка = ОбработкаОбъект();
	Макет = ОсновнаяОбработка.ПолучитьМакет("ШаблонПодключаемогоМодуля");
	
	Попытка
		
		Макет.Записать(ПолноеИмяФайла);
		
	Исключение
		
		Ошибка = ИнформацияОбОшибке();
		
		КомментарийЖР = НСтр("ru = 'Не удалось выгрузить шаблон подключаемого модуля:
                             |%1'");
		
		КомментарийЖР = СтрШаблон(КомментарийЖР
							, ПодробноеПредставлениеОшибки(Ошибка));
		
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР()
			, УровеньЖурналаРегистрации.Ошибка
			, 
			, 
			, КомментарийЖР);
		
		ВызватьИсключение;
		
	КонецПопытки;
	
КонецПроцедуры

&НаКлиенте
Процедура СинхронизироватьПараметрыКлиентСервера(НовыеПараметры) Экспорт
	
	// Структура ПараметрыКлиентСервер может быть рассинхронизирована в результате возникновения исключения.
	
	ВладелецФормы.Объект.ПараметрыКлиентСервер	 = НовыеПараметры;
	ЭтаФорма.Объект.ПараметрыКлиентСервер		 = НовыеПараметры;
	
	Для Каждого КлючИЗначение ИЗ ОткрытыеФормы Цикл
		ОткрытаяФорма = КлючИЗначение.Ключ;
		ОткрытаяФорма.Объект.ПараметрыКлиентСервер = НовыеПараметры;
	КонецЦикла;
	
	Для Каждого КлючИЗначение Из КэшМодулей Цикл
		Модуль = КлючИЗначение.Значение;
		Модуль.Объект.ПараметрыКлиентСервер = НовыеПараметры;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область МАНИФЕСТ

&НаКлиенте
Функция ФункцииМодуля()
	
	СтруктураМетодов= Новый Структура;
	
	//ДобавитьФункциюВМанифест(СтруктураМетодов, "ПримерФункции",);
	//ДобавитьФункциюВМанифест(СтруктураМетодов, "ПримерФункции", , "НаВремяСеанса");
	ДобавитьФункциюВМанифест(СтруктураМетодов, "ПолучитьФормуОбработки");
	
	Возврат СтруктураМетодов;
	
КонецФункции

#КонецОбласти

#Область ОБРАБОТЧИКИ_СОБЫТИЙ_ФОРМ_МОДУЛЯ

&НаКлиенте
Процедура ПриОткрытииФормыОбработки(ФормаОбработки, Отказ= Ложь) Экспорт
	
	ФормаОбработки.Объект.ПараметрыКлиентСервер = ВладелецФормы.Объект.ПараметрыКлиентСервер;
	
	ОткрытыеФормы.Вставить(ФормаОбработки, ФормаОбработки.ИмяФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытииФормыОбработки(ФормаОбработки, ЗакрытиеОсновнойФормы = Ложь, ЗавершениеРаботы = Ложь) Экспорт
	
	Если ЗакрытиеОсновнойФормы Тогда
		
		Если Не ЗавершениеРаботы Тогда
			МетодСервера(,"ЗавершениеРаботыМодуля");
		КонецЕсли;
		
		Если Объект.ПараметрыКлиентСервер <> Неопределено Тогда
			Объект.ПараметрыКлиентСервер.Очистить();
		КонецЕсли;
		
		Если КэшМодулей <> Неопределено Тогда
			КэшМодулей.Очистить();
		КонецЕсли;
		
		Если КэшНаВремяСеанса <> Неопределено Тогда
			КэшНаВремяСеанса.Очистить();
		КонецЕсли;
		
		Если ПараметрыКлиент <> Неопределено Тогда
			ПараметрыКлиент.Очистить();
		КонецЕсли;
		
	КонецЕсли;
	
	ФормаОбработки.Платформа = Неопределено;
	
	ОткрытыеФормы.Удалить(ФормаОбработки);
	
КонецПроцедуры

#КонецОбласти

#Область СЛУЖЕБНЫЕ_ПРОЦЕДУРЫ_И_ФУНКЦИИ

&НаСервере
Функция МетодСервера(Знач ИмяМодуля= "", Знач ИмяМетода,
		Параметр0= NULL, Параметр1= NULL, Параметр2= NULL, Параметр3= NULL, Параметр4= NULL, 
		Параметр5= NULL, Параметр6= NULL, Параметр7= NULL, Параметр8= NULL, Параметр9= NULL)
	
	Возврат ОбработкаОбъект().МетодСервера(ИмяМодуля, ИмяМетода, 
	Параметр0, Параметр1, Параметр2, Параметр3, Параметр4, 
	Параметр5, Параметр6, Параметр7, Параметр8, Параметр9);
	
КонецФункции

&НаСервере
Функция ОбработкаОбъект()
	
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
Процедура ИнициализироватьПлатформу() Экспорт
	
	Если ОткрытыеФормы = Неопределено Тогда
		ОткрытыеФормы = Новый Соответствие;
	КонецЕсли;
	
	Если ПараметрыКлиент = Неопределено Тогда
		ПараметрыКлиент = Новый Структура;
	КонецЕсли;
	
	ЗаполнитьМанифест(ЭтаФорма, "Платформа");
	
	ОткрытыеФормы.Вставить(ВладелецФормы, ВладелецФормы.ИмяФормы);
	
	Объект.ПараметрыКлиентСервер = ВладелецФормы.Объект.ПараметрыКлиентСервер;
	
	ПараметрыКлиент.Вставить("ИерархияОрганизацийDiadoc"	, Новый Соответствие);
	
	ПараметрыКлиент.Вставить("КонтекстРаботаССерверомДиадок"); 
	ПараметрыКлиент.Вставить("КонтекстДиадока"				, Новый Массив);
	
	ПараметрыКлиент.Вставить("СинонимКонфигурации", Объект.ПараметрыКлиентСервер.СинонимКонфигурации);
	
	Для Каждого КлючИЗначение ИЗ Объект.ПараметрыКлиентСервер.ПараметрыКлиент Цикл
		ПараметрыКлиент.Вставить(КлючИЗначение.Ключ, КлючИЗначение.Значение);
	КонецЦикла;
	
	ПараметрыКлиент.Вставить("ИспользуетсяРегистрацияКомпоненты", Ложь);
	
	Объект.ПараметрыКлиентСервер.Удалить("ПараметрыКлиент");
	
КонецПроцедуры

&НаКлиенте
Функция ВыполнитьМетод(ИмяМодуля, ИмяМетода
	, Параметр0, Параметр1, Параметр2, Параметр3, Параметр4
	, Параметр5, Параметр6, Параметр7, Параметр8, Параметр9)
	
	Результат			 = Неопределено;
	ВариантКэширования	 = Неопределено;
	
	Модуль = ПолучитьМодуль(ИмяМодуля);
	МанифестМодуля = Модуль.Манифест;
	
	МассивПараметров= МассивПараметров(
	Параметр0, Параметр1, Параметр2, Параметр3, Параметр4,
	Параметр5, Параметр6, Параметр7, Параметр8, Параметр9);
	
	ПараметрыСтрокой= ПараметрыСтрокой(МассивПараметров);
	
	Если МанифестМодуля.Функции.Свойство(ИмяМетода, ВариантКэширования) Тогда
		
		РезультатПолучен	 = Ложь;
		КэшироватьРезультат	 = НРег(ВариантКэширования) = НРег("НаВремяСеанса");
		
		Если КэшироватьРезультат Тогда
			Результат = РезультатФункцииИзКэш(ИмяМодуля, ИмяМетода, МассивПараметров, РезультатПолучен);
		КонецЕсли;
		
		Если НЕ РезультатПолучен Тогда
			
			Результат = Вычислить("Модуль." + ИмяМетода + "("+ПараметрыСтрокой+")");
			
			Если КэшироватьРезультат Тогда
				ЗаписатьРезультатФункцииВКэш(ИмяМодуля, ИмяМетода, МассивПараметров, Результат);
			КонецЕсли;
			
		КонецЕсли;
		
	Иначе
		Выполнить("Модуль."+ИмяМетода+"("+ПараметрыСтрокой+")");
	КонецЕсли;
	
	Если Модуль <> ЭтаФорма Тогда
		Модуль.ОчиститьПеременные();
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
// Возвращает из кэш предыдущий результат функции, по сигнатуре (с учетом параметров).
//
// Параметры:
//  ИмяМодуля		 - Строка	 - имя модуля, в котором расположена функция;
//  ИмяФункции		 - Строка	 - имя функции, для которой нужно получить предыдущий результат;
//  МассивПараметров - Массив	 - массив параметров, с которыми выполняется функция;
//  РезультатПолучен - Булево	 - Истина, если результат удалось получить;
// 
// Возвращаемое значение:
//   - Произвольный - результат функции из кэш
//
Функция РезультатФункцииИзКэш(ИмяМодуля, ИмяФункции, МассивПараметров, РезультатПолучен = Ложь)
	
	Результат = Неопределено;
	
	КэшФункций			 = КэшФункцийДляПовторногоИспользования();
	СигнатураФункции	 = СигнатураФункцииДляПовторногоИспользования(ИмяМодуля, ИмяФункции, МассивПараметров, КэшФункций);
	СтруктураРезультата	 = КэшФункций.ХранилищеРезультатов[СигнатураФункции];
	
	Если СтруктураРезультата <> Неопределено Тогда
		Результат = СтруктураРезультата.Результат;
		РезультатПолучен = Истина;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
// Записывает результат функции в кэш, ключем будет сигнатура функции (с учетом параметров).
//
// Параметры:
//  ИмяМодуля		 - Строка		 - имя модуля, в котором расположена функция;
//  ИмяФункции		 - Строка		 - имя функции, результат которой нужно записать в кэш;
//  МассивПараметров - Массив		 - массив параметров, с которыми выполняется функция;
//  Результат		 - Произвольный	 - результат функции, который нужно записать в кэш;
// 
Процедура ЗаписатьРезультатФункцииВКэш(ИмяМодуля, ИмяФункции, МассивПараметров, Результат)
	
	КэшФункций		 = КэшФункцийДляПовторногоИспользования();
	СигнатураФункции = СигнатураФункцииДляПовторногоИспользования(ИмяМодуля, ИмяФункции, МассивПараметров, КэшФункций);
	
	СтруктураРезультата = Новый Структура;
	СтруктураРезультата.Вставить("Результат", Результат);
	
	КэшФункций.ХранилищеРезультатов.Вставить(СигнатураФункции, СтруктураРезультата);
	
КонецПроцедуры

&НаКлиенте
// Удаляет результат функции из кэш, по сигнатуре (с учетом параметров).
//
// Параметры:
//  ИмяМодуля		 - Строка		 - имя модуля, в котором расположена функция;
//  ИмяФункции		 - Строка		 - имя функции, для которой нужно удалить результат из кэш;
//  МассивПараметров - Массив		 - массив параметров, с которыми выполняется функция;
// 
Процедура УдалитьРезультатФункцииИзКэш(ИмяМодуля, ИмяФункции, МассивПараметров)
	
	КэшФункций		 = КэшФункцийДляПовторногоИспользования();
	СигнатураФункции = СигнатураФункцииДляПовторногоИспользования(ИмяМодуля, ИмяФункции, МассивПараметров, КэшФункций);
	
	КэшФункций.ХранилищеРезультатов.Удалить(СигнатураФункции);
	
КонецПроцедуры

&НаКлиенте
Процедура ПовторноеИспользованиеСброситьЗначение(Знач ИмяМодуля= "", ИмяМетода,
	Параметр0= NULL, Параметр1= NULL, Параметр2= NULL, Параметр3= NULL, Параметр4= NULL, 
	Параметр5= NULL, Параметр6= NULL, Параметр7= NULL, Параметр8= NULL, Параметр9= NULL) Экспорт
	
	Если НЕ ЗначениеЗаполнено(ИмяМодуля) Тогда
		ИмяМодуля = "Платформа";
	КонецЕсли;
	
	МассивПараметров= МассивПараметров(
	Параметр0, Параметр1, Параметр2, Параметр3, Параметр4, 
	Параметр5, Параметр6, Параметр7, Параметр8, Параметр9);
	
	УдалитьРезультатФункцииИзКэш(ИмяМодуля, ИмяМетода, МассивПараметров);
	
КонецПроцедуры

&НаКлиенте
Функция КэшФункцийДляПовторногоИспользования()
	
	Результат = КэшНаВремяСеанса;
	
	Если Результат = Неопределено Тогда
		
		Результат = Новый Структура;
		Результат.Вставить("ИтераторКлючей"				, 0);
		Результат.Вставить("ХранилищеРезультатов"		, Новый Соответствие);
		Результат.Вставить("КлючиДляЗначенийПараметров"	, Новый Соответствие);
		
		КэшНаВремяСеанса = Результат;
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция СигнатураФункцииДляПовторногоИспользования(ИмяМодуля, ИмяФункции, МассивПараметров, КэшФункций)
	
	Результат		 = "";
	КлючиПараметров	 = "";
	Разделитель		 = "";
	
	Для Индекс = 0 По МассивПараметров.ВГраница() Цикл
		
		// Сначала задаем уникальный числовой ключ
		// для каждого варианта значения параметров.
		// Затем собираем из этих ключей уникальную строку,
		// которая будет составлять сигнатуру метода.
		
		ЗначениеПараметра = МассивПараметров[Индекс];
		
		Если ЗначениеПараметра = Неопределено Тогда
			
			КлючЗначения = "0";
			
		Иначе
			
			КлючЗначения = КэшФункций.КлючиДляЗначенийПараметров[ЗначениеПараметра];
			
			Если КлючЗначения = Неопределено Тогда
				
				// Присваиваем ключ для нового значения,
				// с помощью инкрементации итератора ключей.
				НовыйКлюч	 = КэшФункций.ИтераторКлючей + 1;
				КлючЗначения = Формат(НовыйКлюч, "ЧГ=0");
				
				КэшФункций.ИтераторКлючей = НовыйКлюч;
				КэшФункций.КлючиДляЗначенийПараметров.Вставить(ЗначениеПараметра, КлючЗначения);
				
			КонецЕсли;
			
		КонецЕсли;
		
		КлючиПараметров	 = КлючиПараметров + Разделитель + КлючЗначения;
		Разделитель		 = ", ";
		
	КонецЦикла;
	
	Результат = ИмяМодуля + "." + ИмяФункции + "(" + КлючиПараметров + ")";
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция ПолучитьМодуль(ИмяМодуля) Экспорт
	
	Если НРег(ИмяМодуля)= "платформа" Тогда
		Возврат ЭтаФорма;
	КонецЕсли;
	
	Если КэшМодулей = Неопределено Тогда
		КэшМодулей = Новый Соответствие;
	КонецЕсли;
	
	Результат = КэшМодулей[ИмяМодуля];
		
	Если Результат = Неопределено Тогда
		
		ПутьКФорме = ПараметрыКлиент.ПутьКФормам + ИмяМодуля;
		
		Результат = ПолучитьФорму(ПутьКФорме,,,Истина);
		
		КэшМодулей.Вставить(ИмяМодуля, Результат);
		
	КонецЕсли;
	
	// Инициализация модуля
	Результат.Платформа= ЭтаФорма;
	Результат.Объект.ПараметрыКлиентСервер = ВладелецФормы.Объект.ПараметрыКлиентСервер;
	Результат.Инициализировать(ИмяМодуля);
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция ПараметрыСтрокой(МассивПараметров)
	
	Результат	 = "";
	Разделитель	 = "";
	
	Для Индекс = 0 По МассивПараметров.ВГраница() Цикл
		
		Если МассивПараметров[Индекс] = NULL Тогда
			Результат= Результат + Разделитель;
		Иначе
			Результат= Результат + Разделитель + "Параметр" + Индекс;
		КонецЕсли;
		
		Разделитель= ", ";
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция МассивПараметров(
		Параметр0, Параметр1, Параметр2, Параметр3, Параметр4, 
		Параметр5, Параметр6, Параметр7, Параметр8, Параметр9)
	
	МассивПараметров= Новый Массив(10);
	МассивПараметров[0]= Параметр0; МассивПараметров[1]= Параметр1; МассивПараметров[2]= Параметр2; МассивПараметров[3]= Параметр3; МассивПараметров[4]= Параметр4;
	МассивПараметров[5]= Параметр5; МассивПараметров[6]= Параметр6; МассивПараметров[7]= Параметр7; МассивПараметров[8]= Параметр8; МассивПараметров[9]= Параметр9;
	
	ОбратныйИндекс= 9;
	Пока ОбратныйИндекс > -1 Цикл
		Если МассивПараметров[ОбратныйИндекс] = NULL Тогда
			МассивПараметров.Удалить(ОбратныйИндекс);
		Иначе
			Прервать;
		КонецЕсли;
		ОбратныйИндекс= ОбратныйИндекс-1;
	КонецЦикла;
	
	Возврат МассивПараметров;
	
КонецФункции

&НаКлиенте
Процедура ЗаполнитьМанифест(Модуль, ИмяМодуля) Экспорт
	
	Если Модуль = ЭтаФорма Тогда
		
		ФункцииМодуля = ФункцииМодуля();
		НовыйМанифест = Новый Структура;
		НовыйМанифест.Вставить("Функции", ФункцииМодуля);
		
		Манифест = НовыйМанифест;
		
	Иначе
		
		ФункцииМодуля = Модуль.ФункцииМодуля();
		НовыйМанифест = Новый Структура;
		НовыйМанифест.Вставить("Функции", ФункцииМодуля);
		
		Модуль.Манифест = НовыйМанифест;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ДобавитьФункциюВМанифест(СтруктураМетодов, ИмяМетода, УДАЛИТЬ_ПараметрыСтрокой = "", ВариантКэширования = Неопределено, УДАЛИТЬ_Переопределение= Ложь) Экспорт
	
	СтруктураМетодов.Вставить(ИмяМетода, ВариантКэширования);
	
КонецФункции

&НаСервереБезКонтекста
Функция ИмяСобытияЖР()
	
	Результат = НСтр("ru = 'Диадок'");
	Возврат Результат;
	
КонецФункции

#КонецОбласти