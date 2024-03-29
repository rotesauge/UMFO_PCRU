﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЗагрузитьПараметрыВРеквизитыФормы();
		
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если ЗавершениеРаботы
		И (Модифицированность ИЛИ ПеренестиВДокумент) Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	Если Модифицированность И НЕ ПеренестиВДокумент Тогда
		
		Отказ = Истина;
		
		Оповещение   = Новый ОписаниеОповещения("ПередЗакрытиемЗавершение", ЭтотОбъект);
		ТекстВопроса = НСтр("ru = 'Данные были изменены. Сохранить изменения?'");
		ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНетОтмена,, КодВозвратаДиалога.Да);
		
	ИначеЕсли ПеренестиВДокумент Тогда
		
		Отказ = НЕ ПроверитьЗаполнение();
		
		Если Отказ Тогда
			Модифицированность = Истина;
			ПеренестиВДокумент = Ложь;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	
	Если ПеренестиВДокумент Тогда
		СтруктураВозврата = Новый Структура;
		СтруктураВозврата.Вставить("АдресХранилищаРасшифровкаНалога", АдресХранилищаРасшифровкаНалога);
		ОповеститьОВыборе(СтруктураВозврата);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	Если НЕ Отказ Тогда
		АдресХранилищаРасшифровкаНалога = ПоместитьРасшифровкаНалогаВоВременноеХранилище();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	ПеренестиВДокумент = Истина;
	Закрыть(КодВозвратаДиалога.OK);
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Модифицированность = Ложь;
	ПеренестиВДокумент = Ложь;
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыРасшифровкаНалога

&НаКлиенте
Процедура ОбновитьИтоги() Экспорт
	
	ИтогоСумма = РасшифровкаНалога.Итог("Сумма");
	
	Элементы.РасшифровкаНалогаСумма.ТекстПодвала = Формат(ИтогоСумма, "ЧЦ=15; ЧДЦ=2");
	
КонецПроцедуры

&НаКлиенте
Процедура РасшифровкаНалогаПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	// В качестве источника данных для поля на форме выступает таблица значений,
	// поэтому ведем нумерацию ее строк самостоятельно.
	Если НоваяСтрока Тогда
		ТекущиеДанные = Элементы.РасшифровкаНалога.ТекущиеДанные;
		ТекущиеДанные.НомерСтроки = РасшифровкаНалога.Количество();
		
		//Массив = Новый Массив(); 
		//Массив.Добавить(Тип("СправочникСсылка.БНФОСчетаАналитическогоУчета")); 
		//ОписаниеТипов = Новый ОписаниеТипов(Массив);
		//ТекущиеДанные.СчетУчетаРасчетов = ОписаниеТипов;
		
		Если БНФОИспользуетсяУчетНФО Тогда
			ТекущиеДанные.СчетУчетаРасчетов = ПредопределенноеЗначение("Справочник.БНФОСчетаАналитическогоУчета.ПустаяСсылка");
		Иначе
			ТекущиеДанные.СчетУчетаРасчетов = ПредопределенноеЗначение("ПланСчетов.Хозрасчетный.ПустаяСсылка");
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура РасшифровкаНалогаПриИзменении(Элемент)
	
	ОбновитьИтоги();
	
КонецПроцедуры

&НаКлиенте
Процедура РасшифровкаНалогаПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	Если НоваяСтрока И ОтменаРедактирования Тогда
		ОбновитьИтоги();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура РасшифровкаНалогаПослеУдаления(Элемент)
	
	ПеренумероватьСтроки(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗагрузитьПараметрыВРеквизитыФормы()
	
	АдресХранилищаРасшифровкаНалога = Параметры.ПараметрыФормы.АдресХранилищаРасшифровкаНалога;
	
	Если ЗначениеЗаполнено(АдресХранилищаРасшифровкаНалога) Тогда
		ТаблицаРасшифровкаНалога = ПолучитьИзВременногоХранилища(АдресХранилищаРасшифровкаНалога);
		РасшифровкаНалога.Загрузить(ТаблицаРасшифровкаНалога);
	КонецЕсли;
	
	Если РасшифровкаНалога.Количество() = 0 Тогда
		СтрокаНалог = РасшифровкаНалога.Добавить();
		СтрокаНалог.НомерСтроки = РасшифровкаНалога.Количество();
	КонецЕсли;
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, Параметры.ПараметрыФормы.Шапка);
	
	БНФОИспользуетсяУчетНФО = БНФООбщегоНазначенияНФОПовтИсп.ИспользуетсяУчетНФО(Организация, ТекущаяДата());
	
	МассивТипов = Новый Массив();
	Если БНФОИспользуетсяУчетНФО Тогда
		МассивТипов.Добавить(Тип("СправочникСсылка.БНФОСчетаАналитическогоУчета")); 
	Иначе
		МассивТипов.Добавить(Тип("ПланСчетовСсылка.Хозрасчетный")); 
	КонецЕсли;
	
	ОписаниеТипов = Новый ОписаниеТипов(МассивТипов);
	Элементы.РасшифровкаНалогаСчетУчетаРасчетов.ОграничениеТипа = ОписаниеТипов;

	ИтогоСумма = РасшифровкаНалога.Итог("Сумма");	
	Элементы.РасшифровкаНалогаСумма.ТекстПодвала = Формат(ИтогоСумма, "ЧЦ=15; ЧДЦ=2");

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ПеренумероватьСтроки(Форма)
	
	Для Сч = 0 По Форма.РасшифровкаНалога.Количество() - 1 Цикл
		СтрокаНалог = Форма.РасшифровкаНалога[Сч];
		СтрокаНалог.НомерСтроки = Сч + 1;
	КонецЦикла;
	
КонецПроцедуры


&НаСервере
Функция ПоместитьРасшифровкаНалогаВоВременноеХранилище()
	
	ТаблицаРасшифровкаНалога = РасшифровкаНалога.Выгрузить();
	
	АдресХранилища = ПоместитьВоВременноеХранилище(ТаблицаРасшифровкаНалога, УникальныйИдентификатор);
	
	Возврат АдресХранилища;
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// ЗАВЕРШЕНИЕ НЕМОДАЛЬНЫХ ВЫЗОВОВ

&НаКлиенте
Процедура ПередЗакрытиемЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		Модифицированность = Ложь;
		ПеренестиВДокумент = Истина;
		Закрыть();
	ИначеЕсли Результат = КодВозвратаДиалога.Нет Тогда
		Модифицированность = Ложь;
		ПеренестиВДокумент = Ложь;
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
