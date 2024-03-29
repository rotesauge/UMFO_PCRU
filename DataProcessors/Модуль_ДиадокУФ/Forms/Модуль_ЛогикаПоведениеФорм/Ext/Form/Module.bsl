﻿
#Область ПЕРМЕННЫЕ_ПЛАТФОРМЫ

&НаКлиенте
Перем Платформа Экспорт, Манифест Экспорт;

&НаКлиенте
Перем НомерИтерацииВызоваМодуля;

&НаСервере
Перем ОбработкаОбъект;

#КонецОбласти

#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ПЛАТФОРМЫ

&НаКлиенте
Функция МетодКлиента(ИмяМодуля= "", ИмяМетода, 
		Параметр0= NULL, Параметр1= NULL, Параметр2= NULL, Параметр3= NULL, Параметр4= NULL, 
		Параметр5= NULL, Параметр6= NULL, Параметр7= NULL, Параметр8= NULL, Параметр9= NULL)
	
	Возврат  Платформа.МетодКлиента(ИмяМодуля, ИмяМетода, 
	Параметр0, Параметр1, Параметр2, Параметр3, Параметр4, 
	Параметр5, Параметр6, Параметр7, Параметр8, Параметр9);
	
КонецФункции

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
Процедура Инициализировать(ИмяМодуля) Экспорт
	
	Если НомерИтерацииВызоваМодуля = Неопределено Тогда
		НомерИтерацииВызоваМодуля= 0;
	КонецЕсли;
	
	НомерИтерацииВызоваМодуля= НомерИтерацииВызоваМодуля + 1;
	
	Если Манифест = Неопределено Тогда
		Платформа.ЗаполнитьМанифест(ЭтаФорма, ИмяМодуля);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьПеременные() Экспорт
	
	// Разрывается циклическая ссылка, для того чтобы исключить утечку памяти.
	// Модуль может быть вызван повторно во вложенных методах,
	// поэтому очищаем переменные, ТОЛЬКО если это начальная итерация вызова модуля.
	
	НомерИтерацииВызоваМодуля= НомерИтерацииВызоваМодуля - 1;
	
	Если НомерИтерацииВызоваМодуля = 0 Тогда
		Платформа= 					  Неопределено;
		Объект.ПараметрыКлиентСервер= Неопределено;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область МАНИФЕСТ

&НаКлиенте
Функция ФункцииМодуля() Экспорт
	
	Результат = Новый Структура;
	
	Платформа.ДобавитьФункциюВМанифест(Результат, "ТаблицаЗначений_2_МассивСтруктур");
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

&НаСервереБезКонтекста
Функция ЗначениеРеквизитаОбъекта(СсылкаНаОбъект, ИмяРеквизита)
	
	Результат = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(СсылкаНаОбъект, ИмяРеквизита);
	
	Возврат Результат;
	
КонецФункции

&НаСервереБезКонтекста
Функция ТаблицаЗначений_2_МассивСтруктур(ТаблЗнач)
	Результат = Новый Массив;
	СтрокаКлючей = "";
	Для Каждого Колонка из ТаблЗнач.Колонки Цикл
		СтрокаКлючей = СтрокаКлючей +?(ПустаяСтрока(СтрокаКлючей),"",",")+ Колонка.Имя;
	КонецЦикла;                                                        
	Если ТипЗнч(ТаблЗнач) = Тип("ТаблицаЗначений") тогда
		
		Для Каждого Стр Из ТаблЗнач Цикл
			ЭлементСписка = Новый  Структура(СтрокаКлючей);
			ЗаполнитьЗначенияСвойств(ЭлементСписка,Стр);
			Результат.Добавить(ЭлементСписка);             
		КонецЦикла;
	КонецЕсли;
	Возврат Результат;
КонецФункции

&НаКлиенте
Процедура СоздатьНовыйСчетФактуру(МодульВызова, Контрагент, Организация, Document, МассивСсылокРНК) Экспорт
	
	Если Объект.ПараметрыКлиентСервер.МаркерКонфигурации = "УТ11" Тогда
		Если Document.Direction = "Inbound" Тогда
			СоздатьНовыйСчетФактуруПолученныйУТ11(МодульВызова, Контрагент, Организация, Document, МассивСсылокРНК);
		Иначе
			//...
		КонецЕсли;
		
	ИначеЕсли Объект.ПараметрыКлиентСервер.МаркерКонфигурации = "БП30" Тогда
		
		Если Document.Direction = "Inbound" Тогда
			СоздатьНовыйСчетФактуруПолученныйБП30(МодульВызова, Контрагент, Организация, Document, МассивСсылокРНК);
		Иначе
			СоздатьНовыйСчетФактуруВыданныйБП30(МодульВызова, Контрагент, Организация, Document, МассивСсылокРНК);
		КонецЕсли;
		
	ИначеЕсли Объект.ПараметрыКлиентСервер.МаркерКонфигурации = "БГУ20" Тогда
		
		Если Document.Direction = "Inbound" Тогда
			СоздатьНовыйСчетФактуруПолученныйБГУ20(МодульВызова, Контрагент, Организация, Document, МассивСсылокРНК);
		Иначе
			СоздатьНовыйСчетФактуруВыданныйБГУ20(МодульВызова, Контрагент, Организация, Document, МассивСсылокРНК);
		КонецЕсли;
		
	ИначеЕсли Объект.ПараметрыКлиентСервер.МаркерКонфигурации = "УНФ16" Тогда
		
		Если Document.Direction = "Inbound" Тогда
			СоздатьНовыйСчетФактуруПолученныйУНФ16(МодульВызова, Контрагент, Организация, Document, МассивСсылокРНК);	
		Иначе
			СоздатьНовыйСчетФактуруВыданныйУНФ16(МодульВызова, Контрагент, Организация, Document, МассивСсылокРНК);	
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

// Определяет вид полученного счет-фактуры по документу-основанию.
// 
// Параметры:
//  ДокументОснование - ДокументСсылка - документ, на основании которого вводится счет-фактура
// 
// Возвращаемое значение:
//  Строка - имя вида документа. Принимает значения "СчетФактураПолученный", "СчетФактураПолученныйАванс" или "СчетФактураПолученныйНалоговыйАгент"
//
&НаСервере
Функция ТипПолученногоСчетаФактурыПоДокументуОснованию(ДокументОснование)
	
	Результат = "СчетФактураПолученный";
	
	Если Истина
		И МетодСервера(, "ЕстьРеквизитИлиСвойствоОбъекта", ДокументОснование, "НалогообложениеНДС")
		И МетодСервера(, "ЕстьМетаданныеКонфигурации_ДД", "Документы.СчетФактураПолученныйНалоговыйАгент")
		И ЗначениеРеквизитаОбъекта(ДокументОснование, "НалогообложениеНДС") = ПредопределенноеЗначение("Перечисление.ТипыНалогообложенияНДС.ОблагаетсяНДСУПокупателя")
		Тогда 
		Результат = "СчетФактураПолученныйНалоговыйАгент";
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Проверяет существование реквизита метаданных.
//
// Параметры:
//  ОбъектМетаданных				 - ОбъектМетаданных	 - метаданные произвольного объекта.
//  ИмяРеквизита					 - Строка			 - имя проверяемого реквизита.
//  ПроверятьСтандартныеРеквизиты	 - Булево			 - Истина, если при проверке следует учитывать стандартные реквизиты (Код, Наименование и т.д.)
// 
// Возвращаемое значение:
//  Булево - Истина, если реквизит с заданным именем существует.
//
&НаСервереБезКонтекста
Функция ЕстьРеквизитМетаданных(ОбъектМетаданных, ИмяРеквизита, ПроверятьСтандартныеРеквизиты = Ложь)
	
	Если ОбъектМетаданных = Неопределено Тогда 
		Возврат Ложь;
	КонецЕсли;
	
	ЕстьРеквизит = ОбъектМетаданных.Реквизиты.Найти(ИмяРеквизита) <> Неопределено;
	
	Если Не ЕстьРеквизит И ПроверятьСтандартныеРеквизиты Тогда 
		
		КоллекцияРеквизитов = ОбъектМетаданных.СтандартныеРеквизиты;
		
		Для Каждого СтандартныйРеквизит Из КоллекцияРеквизитов Цикл 
			
			Если ВРег(СтандартныйРеквизит.Имя) = ВРег(ИмяРеквизита) Тогда 
				ЕстьРеквизит = Истина;
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;
	
	Возврат ЕстьРеквизит;
	
КонецФункции

&НаСервереБезКонтекста
Функция РеквизитыОснованияСчетаФактуры(СсылкаИлиМассив)
	
	Если Не ЗначениеЗаполнено(СсылкаИлиМассив) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Если ТипЗнч(СсылкаИлиМассив) = Тип("Массив") Тогда
		ДокументОснование = СсылкаИлиМассив[0];
	Иначе 
		ДокументОснование = СсылкаИлиМассив;
	КонецЕсли;
	
	Результат = Новый Структура;
	Результат.Вставить("Организация");
	Результат.Вставить("Контрагент");
	Результат.Вставить("ИННКонтрагента");
	Результат.Вставить("КППКонтрагента");
	Результат.Вставить("Партнер");
	Результат.Вставить("Склад");
	Результат.Вставить("Подразделение");
	Результат.Вставить("Договор");
	Результат.Вставить("НаправлениеДеятельности");
	
	ОбъектМетаданных = ДокументОснование.Метаданные();
	
	ТребуемыеРеквизиты = Новый Структура;
	
	Если ЕстьРеквизитМетаданных(ОбъектМетаданных, "Контрагент") Тогда
		
		ТребуемыеРеквизиты.Вставить("Контрагент");
		
		Если ЕстьРеквизитМетаданных(ОбъектМетаданных, "ИННКонтрагента") Тогда
			ТребуемыеРеквизиты.Вставить("ИННКонтрагента");
		Иначе
			ТребуемыеРеквизиты.Вставить("ИННКонтрагента", "Контрагент.ИНН");
		КонецЕсли;
		
		Если ЕстьРеквизитМетаданных(ОбъектМетаданных, "КППКонтрагента") Тогда
			ТребуемыеРеквизиты.Вставить("КППКонтрагента");
		Иначе
			ТребуемыеРеквизиты.Вставить("КППКонтрагента", "Контрагент.КПП");
		КонецЕсли;
		
	КонецЕсли;
	
	Если ЕстьРеквизитМетаданных(ОбъектМетаданных, "Организация") Тогда
		ТребуемыеРеквизиты.Вставить("Организация");
	КонецЕсли;
	
	Если ЕстьРеквизитМетаданных(ОбъектМетаданных, "Партнер") Тогда
		ТребуемыеРеквизиты.Вставить("Партнер");
	КонецЕсли;
	
	Если ЕстьРеквизитМетаданных(ОбъектМетаданных, "Склад") Тогда
		ТребуемыеРеквизиты.Вставить("Склад");
	КонецЕсли;
	
	Если ЕстьРеквизитМетаданных(ОбъектМетаданных, "Договор") Тогда
		ТребуемыеРеквизиты.Вставить("Договор");
	КонецЕсли;
	
	Если ЕстьРеквизитМетаданных(ОбъектМетаданных, "Подразделение") Тогда
		ТребуемыеРеквизиты.Вставить("Подразделение");
	КонецЕсли;
	
	Если ЕстьРеквизитМетаданных(ОбъектМетаданных, "НаправлениеДеятельности") Тогда
		ТребуемыеРеквизиты.Вставить("НаправлениеДеятельности");
	КонецЕсли;
	
	ЗначенияРеквизитов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ДокументОснование, ТребуемыеРеквизиты);
	
	ЗаполнитьЗначенияСвойств(Результат, ЗначенияРеквизитов);
	
	Возврат Результат;
	
КонецФункции

&НаСервереБезКонтекста
Функция НовыеПараметрыЗаполненияСчетаФактуры(Дата, Номер, ДокументыОснования = Неопределено)
	
	Результат = Новый Структура;
	Результат.Вставить("ДокументОснование", ДокументыОснования);
	Результат.Вставить("НомерСФ", Дата);
	Результат.Вставить("ДатаСоставления", Номер);
	Результат.Вставить("Дата", ТекущаяДатаСеанса());
	Результат.Вставить("ПолученВЭлектронномВиде", Истина);
	Результат.Вставить("Исправление", Ложь);
	Результат.Вставить("Корректировочный", Ложь);
	Результат.Вставить("Организация");
	Результат.Вставить("Контрагент");
	Результат.Вставить("ИННКонтрагента");
	Результат.Вставить("КППКонтрагента");
	Результат.Вставить("Партнер");
	Результат.Вставить("Склад");
	Результат.Вставить("Подразделение");
	Результат.Вставить("Договор");
	Результат.Вставить("НаправлениеДеятельности");
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура СоздатьНовыйСчетФактуруПолученныйУТ11(МодульВызова, Контрагент, Организация, Document, МассивСсылокРНК)
	
	ДокументОснование = МассивСсылокРНК[0];
	
	РеквизитыОснования = РеквизитыОснованияСчетаФактуры(ДокументОснование);
	
	ДанныеЗаполнения = НовыеПараметрыЗаполненияСчетаФактуры(Document.DocumentNumber, Document.DocumentDate, МассивСсылокРНК);
	
	Если ЗначениеЗаполнено(РеквизитыОснования) Тогда
		ЗаполнитьЗначенияСвойств(ДанныеЗаполнения, РеквизитыОснования);
	КонецЕсли;
	
	ПараметрыФормыСФ = Новый Структура;
	ПараметрыФормыСФ.Вставить("ЗначенияЗаполнения", ДанныеЗаполнения);
	
	ТипСФ		 = ТипПолученногоСчетаФактурыПоДокументуОснованию(ДокументОснование);
	ИмяФормыСФ	 = СтрЗаменить("Документ.[ТипСФ].ФормаОбъекта", "[ТипСФ]", ТипСФ);
	НоваяФорма	 = ПолучитьФорму(ИмяФормыСФ
					, ПараметрыФормыСФ
					, ЭтаФорма);
	
	КоличествоОснований= МассивСсылокРНК.Количество();
	Если КоличествоОснований > 1 Тогда
		
		Для ИндексЦикла= 1 ПО КоличествоОснований - 1 Цикл // Начинаем со второго документа, т.к. первый уже добавлен.
			НоваяФорма.Объект.ДокументыОснования.Добавить().ДокументОснование= МассивСсылокРНК[ИндексЦикла];
		КонецЦикла;
		
		Если НоваяФорма.Элементы.Найти("СтраницаДокументыОснования") <> Неопределено Тогда
			
			НоваяФорма.Элементы.СтраницыДокументыОснования.ТекущаяСтраница = НоваяФорма.Элементы.СтраницаДокументыОснования;
			
			НоваяФорма.ТекстДокументыОснования = "";
			Разделитель= "";
			
			Для Каждого СтрокаТаблицы Из НоваяФорма.Объект.ДокументыОснования Цикл
				НоваяФорма.ТекстДокументыОснования = НоваяФорма.ТекстДокументыОснования + Разделитель + СтрокаТаблицы.ДокументОснование;
				Разделитель= ", ";
			КонецЦикла;
			
		Иначе
			
			ПредставлениеДокументов = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru='Всего документов: %1'"),
			КоличествоОснований);
		
			НоваяФорма.ДокументыОснованияПредставление= Новый ФорматированнаяСтрока(
			ПредставлениеДокументов, , ЦветаСтиляЦветГиперссылкиУТ11(), , "ИзменитьДокументыОснования");
			
		КонецЕсли;
		
	КонецЕсли;
	
	НоваяФорма.Объект.Номер = Document.DocumentNumber; 
	НоваяФорма.Объект.ДатаСоставления = Document.DocumentDate;
	НоваяФорма.Объект.ПолученВЭлектронномВиде = Истина;
	
	НоваяФорма.РежимОткрытияОкна = РежимОткрытияОкнаФормы.БлокироватьОкноВладельца;
	НоваяФорма.ОписаниеОповещенияОЗакрытии= Новый ОписаниеОповещения("ОбработчикЗакрытиеФормыСФ", МодульВызова, НоваяФорма.Объект);
	
	НоваяФорма.Открыть(); 
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЦветаСтиляЦветГиперссылкиУТ11()
	
	Возврат Вычислить("ЦветаСтиля.ЦветГиперссылки");
	
КонецФункции

&НаКлиенте
Процедура СоздатьНовыйСчетФактуруПолученныйБП30(МодульВызова, Контрагент, Организация, Document, МассивСсылокРНК)
	
	НоваяФорма= ПолучитьФорму("Документ.СчетФактураПолученный.ФормаОбъекта", Новый Структура("Основание", МассивСсылокРНК[0]), ЭтаФорма);
	
	КоличествоОснований= МассивСсылокРНК.Количество();
	Если КоличествоОснований > 1 Тогда
		
		Для ИндексЦикла= 1 ПО КоличествоОснований - 1 Цикл // Начинаем со второго документа, т.к. первый уже добавлен.
			НоваяФорма.Объект.ДокументыОснования.Добавить().ДокументОснование= МассивСсылокРНК[ИндексЦикла];
		КонецЦикла;
		
		ЗаполнитьЗначенияСвойств(Объект, ПолучитьПараметрыСчетаФактурыПолученныйБП30(НоваяФорма.Объект));
		
		Если НоваяФорма.Элементы.Найти("ГруппаДокументОснования") <> Неопределено Тогда
			НоваяФорма.Элементы.ГруппаДокументОснования.Видимость= 	 Ложь;
			НоваяФорма.Элементы.НадписьДокументыОснования.Видимость= Истина;
		Иначе
			НоваяФорма.Элементы.СтраницыОснования.ТекущаяСтраница= НоваяФорма.Элементы.СтраницаОснований;
		КонецЕсли;
		
		ФормСтрока      = "Л = ru_RU; ЧДЦ=0";
		ПарПредмета     = "документ,документа,документов,м,,,,0";
		ПрописьЧисла    = ЧислоПрописью(КоличествоОснований, ФормСтрока, ПарПредмета);
		ИндексПредмета  = Найти(ПрописьЧисла, "док");
		ТекстДокументы  = Строка(КоличествоОснований) + " " + Сред(ПрописьЧисла, ИндексПредмета, СтрДлина(ПрописьЧисла)- ИндексПредмета - 3);
		ТекстНадписи    = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = '%1 (%2 и еще %3)'"), 
			ТекстДокументы, 
			Строка(НоваяФорма.Объект.ДокументыОснования[0].ДокументОснование), 
			КоличествоОснований - 1);
		
		НоваяФорма.НадписьДокументыОснования = ТекстНадписи;
		
	КонецЕсли;
	
	НоваяФорма.Объект.НомерВходящегоДокумента= Document.DocumentNumber; 
	НоваяФорма.Объект.ДатаВходящегоДокумента=  Document.DocumentDate;
	НоваяФорма.Объект.КодСпособаПолучения= 	   2;
	
	НоваяФорма.РежимОткрытияОкна= РежимОткрытияОкнаФормы.БлокироватьОкноВладельца;
	НоваяФорма.ОписаниеОповещенияОЗакрытии= Новый ОписаниеОповещения("ОбработчикЗакрытиеФормыСФ", МодульВызова, НоваяФорма.Объект);
	
	НоваяФорма.Открыть(); 
	
КонецПроцедуры

&НаСервере
Функция ПолучитьПараметрыСчетаФактурыПолученныйБП30(Знач НоваяФормаОбъект)
	
	ДокументОбъект = ДанныеФормыВЗначение(НоваяФормаОбъект, Тип("ДокументОбъект.СчетФактураПолученный"));
	
	ПараметрыСчетаФактуры= Новый Структура("СуммаДокумента, СуммаДокументаКомиссия, СуммаНДСДокумента, СуммаНДСДокументаКомиссия");
	
	ЗаполнитьЗначенияСвойств(ПараметрыСчетаФактуры, Вычислить("УчетНДСПереопределяемый.ПараметрыСчетаФактуры(ДокументОбъект)"));
	
	Возврат ПараметрыСчетаФактуры;
	
КонецФункции

&НаКлиенте
Процедура СоздатьНовыйСчетФактуруВыданныйБП30(МодульВызова, Контрагент, Организация, Document, МассивСсылокРНК)
	
	НоваяФорма= ПолучитьФорму("Документ.СчетФактураВыданный.ФормаОбъекта", Новый Структура("Основание", МассивСсылокРНК[0]), ЭтаФорма);
	
	КоличествоОснований= МассивСсылокРНК.Количество();
	Если КоличествоОснований > 1 Тогда
		
		Для ИндексЦикла= 1 ПО КоличествоОснований - 1 Цикл // Начинаем со второго документа, т.к. первый уже добавлен.
			НоваяФорма.Объект.ДокументыОснования.Добавить().ДокументОснование= МассивСсылокРНК[ИндексЦикла];
		КонецЦикла;
		
		НовыеДанныеФормыОбъект= ОпределениеПараметровСчетаФактурыНаРеализациюБП30(НоваяФорма.Объект);
		
		НоваяФорма.Объект.СуммаДокумента 		= НовыеДанныеФормыОбъект.СуммаДокумента;
		НоваяФорма.Объект.СуммаНДСДокумента 	= НовыеДанныеФормыОбъект.СуммаНДСДокумента;
		
		НоваяФорма.Элементы.СтраницыОснования.ТекущаяСтраница 	= НоваяФорма.Элементы.СтраницаОснований;
		
		ФормСтрока 		= "Л = ru_RU; ЧДЦ=0";
		ПарПредмета		= "документ,документа,документов,м,,,,0";
		ПрописьЧисла 	= ЧислоПрописью(КоличествоОснований, ФормСтрока, ПарПредмета);
		ИндексПредмета 	= Найти(ПрописьЧисла, "док");
		ТекстДокументы 	= Строка(КоличествоОснований) + " " + Сред(ПрописьЧисла, ИндексПредмета, СтрДлина(ПрописьЧисла)- ИндексПредмета - 3);
		ТекстНадписи 	= СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = '%1 (%2 и еще %3)'"), ТекстДокументы, Строка(НоваяФорма.Объект.ДокументыОснования[0].ДокументОснование), КоличествоОснований-1);	
		
		НоваяФорма.НадписьДокументыОснования	= ТекстНадписи;
		
	КонецЕсли;
	
	НоваяФорма.Объект.Номер= Document.DocumentNumber;
	НоваяФорма.Объект.Дата=  Document.DocumentDate;
	
	НоваяФорма.Объект.Выставлен= Истина;
	НоваяФорма.Объект.КодСпособаВыставления= 2;
	НоваяФорма.Объект.ДатаВыставления= Document.DocumentDate;
	
	НоваяФорма.РежимОткрытияОкна= РежимОткрытияОкнаФормы.БлокироватьОкноВладельца;
	НоваяФорма.ОписаниеОповещенияОЗакрытии= Новый ОписаниеОповещения("ОбработчикЗакрытиеФормыСФ", МодульВызова, НоваяФорма.Объект);
	
	НоваяФорма.Открыть(); 
	
КонецПроцедуры

&НаСервере
Функция ОпределениеПараметровСчетаФактурыНаРеализациюБП30(Знач НоваяФормаОбъект)
	
	ДокументОбъект = ДанныеФормыВЗначение(НоваяФормаОбъект, Тип("ДокументОбъект.СчетФактураВыданный"));
	ДокументОбъект.ОпределениеПараметровСчетаФактурыНаРеализацию();
	ЗначениеВДанныеФормы(ДокументОбъект, НоваяФормаОбъект);
	
	Возврат НоваяФормаОбъект;
	
КонецФункции

&НаКлиенте
Процедура СоздатьНовыйСчетФактуруВыданныйБГУ20(МодульВызова, Контрагент, Организация, Document, МассивСсылокРНК)
	
	НоваяФорма= ПолучитьФорму("Документ.СчетФактураВыданный.ФормаОбъекта", Новый Структура("Основание", МассивСсылокРНК[0]), ЭтаФорма);
	
	НоваяФорма.Объект.Номер= 			Document.DocumentNumber; 
	НоваяФорма.Объект.Дата=  			Document.DocumentDate;
	
	НоваяФорма.ВыставленНеВыставлен=	1;
	НоваяФорма.Объект.Выставлен= 		Истина;
	НоваяФорма.Объект.ДатаВыставления=  Document.DocumentDate;
	
	НоваяФорма.Объект.КодСпособаВыставления= 2;
	
	НоваяФорма.РежимОткрытияОкна= РежимОткрытияОкнаФормы.БлокироватьОкноВладельца;
	НоваяФорма.ОписаниеОповещенияОЗакрытии= Новый ОписаниеОповещения("ОбработчикЗакрытиеФормыСФ", МодульВызова, НоваяФорма.Объект);
	
	НоваяФорма.Открыть(); 
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьНовыйСчетФактуруПолученныйБГУ20(МодульВызова, Контрагент, Организация, Document, МассивСсылокРНК)
	
	НоваяФорма= ПолучитьФорму("Документ.СчетФактураПолученный.ФормаОбъекта", Новый Структура("Основание", МассивСсылокРНК[0]), ЭтаФорма);
	
	ВГраница= МассивСсылокРНК.ВГраница();
	Если ВГраница > 0 Тогда
		
		Для ИндексЦикла= 1 ПО ВГраница Цикл // Начинаем со второго документа, т.к. первый уже добавлен.
			НоваяФорма.Объект.ДокументыОснования.Добавить().ДокументОснование= МассивСсылокРНК[ВГраница];
		КонецЦикла;
		
		НоваяФорма.ОбновитьСоставНФАКлиент_Выбор(КодВозвратаДиалога.Да, НоваяФорма.Объект);
		
	КонецЕсли;
	
	НоваяФорма.Объект.НомерПервичногоДокумента= Document.DocumentNumber;
	НоваяФорма.Объект.ДатаПервичногоДокумента= 	Document.DocumentDate;
	
	НоваяФорма.Объект.КодСпособаВыставления= 2;
	НоваяФорма.Объект.КодВидаОперации= "01";
	
	НоваяФорма.РежимОткрытияОкна= РежимОткрытияОкнаФормы.БлокироватьОкноВладельца;
	НоваяФорма.ОписаниеОповещенияОЗакрытии= Новый ОписаниеОповещения("ОбработчикЗакрытиеФормыСФ", МодульВызова, НоваяФорма.Объект);
	
	НоваяФорма.Открыть(); 
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьНовыйСчетФактуруВыданныйУНФ16(МодульВызова, Контрагент, Организация, Document, МассивСсылокРНК)
	
	НоваяФорма= ПолучитьФорму("Документ.СчетФактура.ФормаОбъекта", Новый Структура("Основание", МассивСсылокРНК[0]), ЭтаФорма);
	
	КоличествоОснований= МассивСсылокРНК.Количество();
	Если КоличествоОснований > 1 Тогда
			
		Для ИндексЦикла= 1 ПО КоличествоОснований - 1 Цикл // Начинаем со второго документа, т.к. первый уже добавлен.
						
			СсылкаРНК= МассивСсылокРНК[ИндексЦикла];
			
			НоваяСтрокаТЧ= НоваяФорма.Объект.ДокументыОснования.Добавить();
			НоваяСтрокаТЧ.ДокументОснование= СсылкаРНК;
			
			Если ТипЗнч(СсылкаРНК) = Тип("ДокументСсылка.КорректировкаРеализации") Тогда
				Попытка
					РеквизитыКорректировочногоСчетФактуры= ПолучитьПараметрыЗаполненияКорректировочногоСчетаФактурыУНФ16(СсылкаРНК);
				Исключение
					РеквизитыКорректировочногоСчетФактуры= Неопределено;
				КонецПопытки;
				
				Если НЕ РеквизитыКорректировочногоСчетФактуры = Неопределено Тогда
					ЗаполнитьЗначенияСвойств(НоваяСтрокаТЧ, РеквизитыКорректировочногоСчетФактуры, "НомерИсходногоДокумента, ДатаИсходногоДокумента, УчитыватьИсправлениеИсходногоДокумента, НомерИсправленияИсходногоДокумента, ДатаИсправленияИсходногоДокумента");
				КонецЕсли;
							
			КонецЕсли;
			
		КонецЦикла;
			
	КонецЕсли;
	
	НоваяФорма.Объект.Номер= Document.DocumentNumber;
	НоваяФорма.Объект.Дата=  Document.DocumentDate;
	
	НоваяФорма.Объект.ДатаВыставления= Document.DocumentDate;
	
	НоваяФорма.РежимОткрытияОкна= РежимОткрытияОкнаФормы.БлокироватьОкноВладельца;
	НоваяФорма.ОписаниеОповещенияОЗакрытии= Новый ОписаниеОповещения("ОбработчикЗакрытиеФормыСФ", МодульВызова, НоваяФорма.Объект);
	
	НоваяФорма.Открыть();
	
КонецПроцедуры

&НаСервере
Функция ПолучитьПараметрыЗаполненияКорректировочногоСчетаФактурыУНФ16(СсылкаРНК)
	Возврат Документы.СчетФактура.ПолучитьПараметрыЗаполненияКорректировочногоСчетаФактуры(СсылкаРНК);	
КонецФункции

&НаКлиенте
Процедура СоздатьНовыйСчетФактуруПолученныйУНФ16(МодульВызова, Контрагент, Организация, Document, МассивСсылокРНК)
	
	НоваяФорма= ПолучитьФорму("Документ.СчетФактураПолученный.ФормаОбъекта", Новый Структура("Основание", МассивСсылокРНК[0]), ЭтаФорма);
	
	НоваяФорма.Объект.НомерВходящегоДокумента= Document.DocumentNumber; 
	НоваяФорма.Объект.ДатаВходящегоДокумента=  Document.DocumentDate;
		
	НоваяФорма.РежимОткрытияОкна= РежимОткрытияОкнаФормы.БлокироватьОкноВладельца;
	НоваяФорма.ОписаниеОповещенияОЗакрытии= Новый ОписаниеОповещения("ОбработчикЗакрытиеФормыСФ", МодульВызова, НоваяФорма.Объект);
	
	НоваяФорма.Открыть(); 
	
КонецПроцедуры
