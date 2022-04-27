﻿
////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЭтаФорма.Заголовок = "Настройки © Алексеенко П.В.";
	
	Параметры.СтруктураВозвращаемыхДанных = Новый Структура();	
	Для каждого РеквизитФормы Из ЭтаФорма.ПолучитьРеквизиты() Цикл
		Параметры.СтруктураВозвращаемыхДанных.Вставить(РеквизитФормы.Имя)	
	КонецЦикла;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

&НаКлиенте
Процедура ПерваяСтрокаДанныхТабличногоДокументаПриИзменении(Элемент)
	
	Если ПерваяСтрокаДанныхТабличногоДокумента = 0 Тогда
		ПерваяСтрокаДанныхТабличногоДокумента = 1;
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// КОМАНДЫ ФОРМЫ

&НаКлиенте
Процедура ОК(Команда)
	
	Для каждого КлючИЗначение Из Параметры.СтруктураВозвращаемыхДанных Цикл
		Параметры.СтруктураВозвращаемыхДанных[КлючИЗначение.Ключ] = ЭтаФорма[КлючИЗначение.Ключ]	
	КонецЦикла;
	ОповеститьОВыборе(Новый Структура("Источник, Настройки", "ФормаНастроек", Параметры.СтруктураВозвращаемыхДанных));
	
КонецПроцедуры

