﻿
////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЭтаФорма.Заголовок = "Выберите добавляемую настройку © Алексеенко П.В.";
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	СисИнфо = Новый СистемнаяИнформация;
	Если Лев(СисИнфо.ВерсияПриложения, 3) = "8.3" Тогда
		Элементы.Справочник.КнопкаВыпадающегоСписка = Истина;
		Элементы.Регистр.КнопкаВыпадающегоСписка = Истина;
		Элементы.ТабличнаяЧасть.КнопкаВыпадающегоСписка = Истина;
		Элементы.РегистрСведений.КнопкаВыпадающегоСписка = Истина;
		Элементы.Справочник1.КнопкаВыпадающегоСписка = Истина;
		Элементы.РегистрСведений1.КнопкаВыпадающегоСписка = Истина;
	КонецЕсли
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// КОМАНДЫ ФОРМЫ

&НаКлиенте
Процедура ОК(Команда)
	
	СтруктураДанных = Новый Структура("Источник, ДобавляемаяНастройка", "ФормаДобавленияДополнительнойНастройки", ПолучитьСтруктуруДобавляемыхНастроек());
	ОповеститьОВыборе(СтруктураДанных);	
		
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

&НаКлиенте
Процедура ВидДобавляемойНастройкиПриИзменении(Элемент)
	
	Элементы.Страницы.ТекущаяСтраница = Элементы.Страницы.ПодчиненныеЭлементы[ВидДобавляемойНастройки];
	ПриИзмененииВидаНастройки(Неопределено);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаКлиенте
Функция ПолучитьСтруктуруДобавляемыхНастроек()
	
	СтруктураДобавляемыхНастроек = Новый Структура("Настройка, Представление, ЭтоРегистр, ЗагружаетсяДоОбъекта, РежимЗагрузки", "", ПредставлениеНастройки, Ложь, Ложь, ВидДобавляемойНастройки);
	
	Если ВидДобавляемойНастройки = 0 Тогда
		СтруктураДобавляемыхНастроек.Настройка = Справочник;
		СтруктураДобавляемыхНастроек.ЗагружаетсяДоОбъекта = Истина;
	ИначеЕсли ВидДобавляемойНастройки = 1 Тогда
		СтруктураДобавляемыхНастроек.Настройка = ТабличнаяЧасть;
	ИначеЕсли ВидДобавляемойНастройки = 2 Тогда
		СтруктураДобавляемыхНастроек.Настройка = Регистр;
		СтруктураДобавляемыхНастроек.ЭтоРегистр = Истина;
	ИначеЕсли ВидДобавляемойНастройки = 3 Тогда
		СтруктураДобавляемыхНастроек.Настройка = РегистрСведений;
		СтруктураДобавляемыхНастроек.ЗагружаетсяДоОбъекта = Истина;
		СтруктураДобавляемыхНастроек.ЭтоРегистр = Истина;
	ИначеЕсли ВидДобавляемойНастройки = 6 Тогда
		СтруктураДобавляемыхНастроек.Настройка = Справочник;
		СтруктураДобавляемыхНастроек.ЗагружаетсяДоОбъекта = Истина;
	ИначеЕсли ВидДобавляемойНастройки = 7 Тогда
		СтруктураДобавляемыхНастроек.Настройка = РегистрСведений;
		СтруктураДобавляемыхНастроек.ЗагружаетсяДоОбъекта = Истина;
	КонецЕсли;
	
	Возврат СтруктураДобавляемыхНастроек
	
КонецФункции

&НаКлиенте
Процедура ПриИзмененииВидаНастройки(Элемент)
	
	Если ВидДобавляемойНастройки = 0 Тогда
		ПредставлениеНастройки = Элементы.Справочник.ТекстРедактирования;
	ИначеЕсли ВидДобавляемойНастройки = 1 Тогда
		ПредставлениеНастройки = "ТЧ: " + Элементы.ТабличнаяЧасть.ТекстРедактирования;
	ИначеЕсли ВидДобавляемойНастройки = 2 Тогда
		ПредставлениеНастройки = Элементы.Регистр.ТекстРедактирования;
	ИначеЕсли ВидДобавляемойНастройки = 3 Тогда
		ПредставлениеНастройки = "Поиск через: " + Элементы.РегистрСведений.ТекстРедактирования;
	ИначеЕсли ВидДобавляемойНастройки = 6 Тогда
		ПредставлениеНастройки = "Поиск через: " + Элементы.Справочник.ТекстРедактирования;
	ИначеЕсли ВидДобавляемойНастройки = 7 Тогда
		ПредставлениеНастройки = Элементы.РегистрСведений1.ТекстРедактирования;
	КонецЕсли;
	
КонецПроцедуры

