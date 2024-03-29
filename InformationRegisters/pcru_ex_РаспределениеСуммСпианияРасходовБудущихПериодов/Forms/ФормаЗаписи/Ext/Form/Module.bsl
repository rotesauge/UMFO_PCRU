﻿
&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	Если Запись.ПроцентТипЗатрат1 + Запись.ПроцентТипЗатрат2 <> 100 Тогда
		СообщениеПользователю = Новый СообщениеПользователю;
		СообщениеПользователю.Текст = "Сумма по процентам распределения не равна 100";
		СообщениеПользователю.Сообщить();
		
		Отказ = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроцентТипЗатрат2ПриИзменении(Элемент)
	
	Запись.ПроцентТипЗатрат1 = 100 - Запись.ПроцентТипЗатрат2;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроцентТипЗатрат1ПриИзменении(Элемент)
	
	Запись.ПроцентТипЗатрат2 = 100 - Запись.ПроцентТипЗатрат1;
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Ключ.Пустой() Тогда
		Запись.ТипЗатрат1 = Справочники.БНФОСубконто.НайтиПоКоду("000000092");	//Тип затрат 1
		Запись.ТипЗатрат2 = Справочники.БНФОСубконто.НайтиПоКоду("000000093");	//Тип затрат 2
	КонецЕсли;
	
КонецПроцедуры
