﻿
&Вместо("ПодготовитьПараметрыНачислениеАмортизации")
Функция pcru_ex_ПодготовитьПараметрыНачислениеАмортизации(ТаблицаЗатрат, ТаблицаРеквизиты)
	
	Для Каждого СтрокаТаблицы Из ТаблицаЗатрат Цикл
		Если ЗначениеЗаполнено(СтрокаТаблицы.Подразделение) Тогда
			Если ТипЗнч(СтрокаТаблицы.ОбъектУчета) = Тип("СправочникСсылка.ОсновныеСредства") Тогда
				СтрокаТаблицы.Субконто3 = pcru_ex_ПолучитьТипЗатратПоПодразделению(СтрокаТаблицы.ОбъектУчета, СтрокаТаблицы.Подразделение);
			ИначеЕсли ТипЗнч(СтрокаТаблицы.ОбъектУчета) = Тип("СправочникСсылка.НематериальныеАктивы") Тогда
				Если СтрокаТаблицы.СуммаБУ <> 0 Тогда
					СтрокаТаблицы.Субконто3 = pcru_ex_ПолучитьТипЗатратПоПодразделению(СтрокаТаблицы.ОбъектУчета, СтрокаТаблицы.Подразделение);
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Результат = ПродолжитьВызов(ТаблицаЗатрат, ТаблицаРеквизиты);
	Возврат Результат;
	
КонецФункции

Функция pcru_ex_ПолучитьТипЗатратПоПодразделению(Актив, Подразделение)
	
	Запрос = Новый Запрос;
	Если ТипЗнч(Актив) = Тип("СправочникСсылка.ОсновныеСредства") Тогда
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	СостоянияОСОрганизацийСрезПоследних.ДатаСостояния КАК ДатаПринятия
		|ИЗ
		|	РегистрСведений.СостоянияОСОрганизаций.СрезПоследних(, ОсновноеСредство = &Актив И Состояние = &Состояние) КАК СостоянияОСОрганизацийСрезПоследних";
		Запрос.УстановитьПараметр("Состояние", Перечисления.СостоянияОС.ПринятоКУчету);
	ИначеЕсли ТипЗнч(Актив) = Тип("СправочникСсылка.НематериальныеАктивы") Тогда
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	СостоянияНМАОрганизацийСрезПоследних.Период КАК ДатаПринятия
		|ИЗ
		|	РегистрСведений.СостоянияНМАОрганизаций.СрезПоследних(, НематериальныйАктив = &Актив И Состояние = &Состояние) КАК СостоянияНМАОрганизацийСрезПоследних";
		Запрос.УстановитьПараметр("Состояние", Перечисления.ВидыСостоянийНМА.ПринятКУчету);
	КонецЕсли;
	Запрос.УстановитьПараметр("Актив", Актив);
	Выборка = Запрос.Выполнить().Выбрать();
	
	ДатаПринятия = Дата('00010101');
	Если Выборка.Следующий() Тогда
		ДатаПринятия = Выборка.ДатаПринятия;
	КонецЕсли;
	
	Если НачалоДня(ДатаПринятия) < Дата(2020,05,27,00,00,00) Тогда
		//Тип затрат 1
		Возврат Справочники.БНФОСубконто.НайтиПоКоду("000000092", ИСТИНА);
	КонецЕсли;
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	pcru_ex_ТипыЗатратПодразделений.ТипЗатрат КАК ТипЗатрат
	|ИЗ
	|	РегистрСведений.pcru_ex_ТипыЗатратПодразделений КАК pcru_ex_ТипыЗатратПодразделений
	|ГДЕ
	|	pcru_ex_ТипыЗатратПодразделений.Подразделение = &Подразделение";
	Запрос.УстановитьПараметр("Подразделение", Подразделение);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	ТипЗатрат = Справочники.БНФОСубконто.ПустаяСсылка();
	Если Выборка.Следующий() Тогда
		ТипЗатрат = Выборка.ТипЗатрат;
	КонецЕсли;
	
	Возврат ТипЗатрат;
	
КонецФункции