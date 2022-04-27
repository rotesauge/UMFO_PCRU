﻿
&После("ПриЗаписи")
Процедура pcru_ex_ПриЗаписи(Отказ, Замещение)
	Для каждого Запись Из ЭтотОбъект Цикл
		мз = РегистрыСведений.pcru_ex_СостоянияПлатежныхПоручений.СоздатьМенеджерЗаписи();
		мз.ДокументПП = Запись.СсылкаНаОбъект;
		мз.Период = ТекущаяДата();
		Попытка
			мз.Пользователь = ПараметрыСеанса.ТекущийПользователь;
		Исключение
			мз.Пользователь = Запись.СсылкаНаОбъект.Ответственный;
		КонецПопытки; 
		мз.Состояние = Запись.Состояние;
		мз.Записать(Истина);
	КонецЦикла;
КонецПроцедуры
