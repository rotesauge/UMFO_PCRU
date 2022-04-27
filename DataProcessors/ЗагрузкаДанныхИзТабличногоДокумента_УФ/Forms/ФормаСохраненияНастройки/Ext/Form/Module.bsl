﻿///////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЭтаФорма.Заголовок = "Сохранение настройки © Алексеенко П.В.";
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

&НаКлиенте
// Процедура - обработчик события "Нажатие" в: Кнопка "ОК"
//
Процедура ОКНажатие(Команда)
	
	ОповеститьОВыборе(Новый Структура("Источник, СписокНастроек", "ФормаСохраненияНастроек", Элементы.СписокНастроек.ТекущиеДанные))
	
КонецПроцедуры

&НаКлиенте
// Процедура - обработчик события "Нажатие" в: Кнопка "Удалить"
//
Процедура УдалитьНажатие(Команда)
	
	ТекущиеДанные = Элементы.СписокНастроек.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат
	КонецЕсли;
	
	Если СписокНастроек.Количество() = 1 Тогда
		Оповестить("УдаленаНастройка", ТекущиеДанные.Представление);
		ТекущиеДанные.Представление = "";
		ТекущиеДанные.Пометка = Ложь
	Иначе
		УдалитьНастройку(ТекущиеДанные.Представление);		
		Если НЕ ТекущиеДанные.КартинкаСтроки = 1 Тогда
			Оповестить("УдаленаНастройка", ТекущиеДанные.Представление);
			СписокНастроек.Удалить(ТекущиеДанные)
		КонецЕсли;
	КонецЕсли
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаКлиенте
// Процедура - обработчик окончания ввода наименования настройки
//
Процедура НаименованиеНастройкиОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, СтандартнаяОбработка)
	
	Настройка = СписокНастроек.НайтиСтроки(Новый Структура("Представление", Текст));
	
	Если НЕ Настройка.Количество() Тогда
		
		ТекНастройка = СписокНастроек.Добавить();		
		ТекНастройка.Представление = Текст
		
	Иначе
		ТекНастройка = Настройка[0]	
	КонецЕсли;
	
	Элементы.СписокНастроек.ТекущаяСтрока = СписокНастроек.Индекс(ТекНастройка)
	
КонецПроцедуры

&НаКлиенте
// Процедура - обработчик изменения настройки по умолчанию
//
Процедура СписокНастроекПометкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.СписокНастроек.ТекущиеДанные;
	Оповестить("УстановленаНастройкаПоУмолчанию", Новый Структура("Представление, Пометка", ТекущиеДанные.Представление, ТекущиеДанные.Пометка));
	Если ТекущиеДанные.Пометка Тогда
		Для каждого ЭлементСписка Из СписокНастроек Цикл
			Если ЭлементСписка.Пометка и Не ЭлементСписка = ТекущиеДанные Тогда
				ЭлементСписка.Пометка = Ложь
			КонецЕсли
		КонецЦикла
	КонецЕсли
	
КонецПроцедуры

&НаКлиенте
// Обработчик выбора настройки
//
Процедура СписокНастроекВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ОповеститьОВыборе(Новый Структура("Источник, СписокНастроек", "ФормаСохраненияНастроек", Элементы.СписокНастроек.ТекущиеДанные))	
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ ФОРМЫ

&НаСервере
// Процедура удаляет настройку из Хранилища настроек форм
//
Процедура УдалитьНастройку(Представление)
	
	ХранилищеНастроекДанныхФорм.Удалить(ИдентификаторОбработки, "Настройки:" + Представление, Неопределено)
	
КонецПроцедуры
