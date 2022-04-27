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

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ПлатформаПриСозданииНаСервере(Отказ, СтандартнаяОбработка);
	
	АдресНоменклатураДляСопоставления = Параметры.АдресНоменклатураДляСопоставления;
	НоменклатураДляСопоставленияТаблица = ПолучитьИзВременногоХранилища(АдресНоменклатураДляСопоставления);
	ЗаполнитьНоменклатуруДляСопоставленияНаСервере(НоменклатураДляСопоставленияТаблица, Отказ);
	ПолучитьНоменклатуруНаСервере();
	УстановитьСвойстваПолейФормы(НоменклатураДляСопоставленияТаблица);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ПлатформаПриОткрытии(Отказ);

КонецПроцедуры

#КонецОбласти

#Область ОберткиДляВызоваУниверсальныхМетодов

Процедура ЗаписатьРезультатыСопоставленияНоменклатуры(ТаблицаСопоставления)
	
	МетодСервера("Модуль_ИнтеграцияУниверсальный", "ЗаписатьРезультатыСопоставленияНоменклатуры", ТаблицаСопоставления);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьНоменклатуруДляСопоставленияНаСервере(НоменклатураДляСопоставленияТаблица, Отказ)
	
	СписокПоставщиков = НоменклатураДляСопоставленияТаблица.Скопировать();
	СписокПоставщиков.Свернуть("Контрагент");
	СписокПоставщиков.Сортировать("Контрагент");
	
	НоменклатураДляСопоставленияДеревоЗначений = РеквизитФормыВЗначение("НоменклатураДляСопоставленияДерево");
	ЕстьСтрокиВ_Дереве = Ложь;
	
	Для Каждого ТекСтрокаПоставщик Из СписокПоставщиков Цикл
		
		Если ЗначениеЗаполнено(ТекСтрокаПоставщик.Контрагент) Тогда
			
			СтрокаПоставщик = НоменклатураДляСопоставленияДеревоЗначений.Строки.Добавить();
			СтрокаПоставщик.Контрагент = ТекСтрокаПоставщик.Контрагент;
			
			НайденныеСтрокиНоменклатурыПоПоставщику = НоменклатураДляСопоставленияТаблица.НайтиСтроки(Новый Структура("Контрагент", ТекСтрокаПоставщик.Контрагент));
			Для Каждого НайденнаяСтрокаНоменклатура Из НайденныеСтрокиНоменклатурыПоПоставщику Цикл
				СтрокаНоменклатура = СтрокаПоставщик.Строки.Добавить();
				ЗаполнитьЗначенияСвойств(СтрокаНоменклатура, НайденнаяСтрокаНоменклатура);
				ЕстьСтрокиВ_Дереве = Истина;
			КонецЦикла;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Если Не ЕстьСтрокиВ_Дереве Тогда
		Отказ = Истина;
	Иначе
		ЗначениеВРеквизитФормы(НоменклатураДляСопоставленияДеревоЗначений, "НоменклатураДляСопоставленияДерево");
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьСвойстваПолейФормы(НоменклатураДляСопоставленияТаблица)
	
	ПолеФормы = Элементы.НоменклатураДляСопоставленияДеревоНоменклатура;
	ПолеФормы.ОграничениеТипа = НоменклатураДляСопоставленияТаблица.Колонки.Номенклатура.ТипЗначения;
	ПолеФормы.ВыбиратьТип = Ложь;
	ПолеФормы.ВыборГруппИЭлементов = ГруппыИЭлементы.Элементы;
	
	ПолеФормы = Элементы.НоменклатураДляСопоставленияДеревоНоменклатураПоставщика;
	ПолеФормы.ОграничениеТипа = НоменклатураДляСопоставленияТаблица.Колонки.НоменклатураПоставщика.ТипЗначения;
	ПолеФормы.ВыбиратьТип = Ложь;
	ПолеФормы.ВыборГруппИЭлементов = ГруппыИЭлементы.Элементы;
	
КонецПроцедуры

&НаКлиенте
Процедура СопоставитьПовторитьСоздание(Команда)
	
	СопоставитьНоменклатуру();
	
	Результат = Новый Структура;
	Результат.Вставить("СопоставлениеВыполнено", Истина);
	Результат.Вставить("РезультатСопоставления", АдресНоменклатураДляСопоставления);
	
	Закрыть(Результат);
	
КонецПроцедуры

&НаСервере
Процедура СопоставитьНоменклатуру()
	
	ТаблицаСопоставления = ТаблицаНоменклатурыДляСопоставления();
	ЗаписатьРезультатыСопоставленияНоменклатуры(ТаблицаСопоставления);
	ПоместитьВоВременноеХранилище(ТаблицаСопоставления, АдресНоменклатураДляСопоставления);
	
КонецПроцедуры

// Преобразует дерево сопоставления в плоскую таблицу.
// 
// Возвращаемое значение:
//  ТаблицаЗначений - колонки полностью соответствуют колонкам дерева НоменклатураДляСопоставленияДерево.
//
&НаСервере
Функция ТаблицаНоменклатурыДляСопоставления()
	
	ДеревоДанных = РеквизитФормыВЗначение("НоменклатураДляСопоставленияДерево");
	
	Результат = Новый ТаблицаЗначений;
	
	Для Каждого КолонкаДерева Из ДеревоДанных.Колонки Цикл 
		
		КолонкаТаблицы = Результат.Колонки.Добавить(КолонкаДерева.Имя, КолонкаДерева.ТипЗначения);
		
	КонецЦикла;
	
	Для Каждого СтрокаПоставщик Из ДеревоДанных.Строки Цикл 
		
		Для Каждого СтрокаНоменклатура Из СтрокаПоставщик.Строки Цикл 
			
			ЗаполнитьЗначенияСвойств(Результат.Добавить(), СтрокаНоменклатура);
			
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Процедура ПолучитьНоменклатуруНаСервере()
	
	ПрофильКонфигурации = МетодСервера(, "СформироватьПрофильКонфигурации");
	
	ДеревоДанных = РеквизитФормыВЗначение("НоменклатураДляСопоставленияДерево");
	
	Для Каждого СтрокаПоставщик Из ДеревоДанных.Строки Цикл 
		
		Для Каждого СтрокаНоменклатура Из СтрокаПоставщик.Строки Цикл 
			
			Контрагент		 = СтрокаНоменклатура.Контрагент;
			КодЭД			 = СтрокаНоменклатура.КодЭД;
			АртикулЭД		 = СтрокаНоменклатура.АртикулЭД;
			НоменклатураЭД	 = СтрокаНоменклатура.НоменклатураЭД;
			
			Номенклатура = МетодСервера(, "ПолучитьНоменклатуруПоставщика", ПрофильКонфигурации, Контрагент, КодЭД, АртикулЭД, НоменклатураЭД);
			СтрокаНоменклатура.Номенклатура = Номенклатура;
			
		КонецЦикла;
		
	КонецЦикла;
	
	ЗначениеВРеквизитФормы(ДеревоДанных, "НоменклатураДляСопоставленияДерево");
	
КонецПроцедуры

#КонецОбласти