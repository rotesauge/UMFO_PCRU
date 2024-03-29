﻿
&НаСервере
Процедура pcru_ex_pcru_РаспределитьСуммыВместоНаСервере()

	Состав = Объект.Состав.Выгрузить();	
	СоставДляПроверки = Состав.Скопировать();
	СоставДляПроверки.Свернуть("РБП");
	Если Состав.Количество() <> СоставДляПроверки.Количество() Тогда
		СообщениеПользователю = Новый СообщениеПользователю;
		СообщениеПользователю.Текст = "Распределение уже было выполнено ранее";
		СообщениеПользователю.Сообщить();
		Возврат;
	КонецЕсли;	
	
	Объект.Состав.Очистить();	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	pcru_ex_РаспределениеСуммСпианияРасходовБудущихПериодовСрезПоследних.ТипЗатрат1 КАК ТипЗатрат1,
	|	pcru_ex_РаспределениеСуммСпианияРасходовБудущихПериодовСрезПоследних.ТипЗатрат2 КАК ТипЗатрат2,
	|	pcru_ex_РаспределениеСуммСпианияРасходовБудущихПериодовСрезПоследних.ПроцентТипЗатрат1 КАК ПроцентТипЗатрат1,
	|	pcru_ex_РаспределениеСуммСпианияРасходовБудущихПериодовСрезПоследних.ПроцентТипЗатрат2 КАК ПроцентТипЗатрат2
	|ИЗ
	|	РегистрСведений.pcru_ex_РаспределениеСуммСпианияРасходовБудущихПериодов.СрезПоследних(&Период, РБП = &РБП) КАК pcru_ex_РаспределениеСуммСпианияРасходовБудущихПериодовСрезПоследних";
	
	НачалоПериодаРегистрации = ?(Объект.ПериодичностьСписания = ПредопределенноеЗначение("Перечисление.БНФОПериодичностьСписанияРБП.Ежеквартально"), НачалоКвартала(Объект.ПериодРегистрации), НачалоМесяца(Объект.ПериодРегистрации));
	ОкончаниеПериодаРегистрации = ?(Объект.ПериодичностьСписания = ПредопределенноеЗначение("Перечисление.БНФОПериодичностьСписанияРБП.Ежеквартально"), КонецКвартала(Объект.ПериодРегистрации), КонецМесяца(Объект.ПериодРегистрации));
	ГраницаПериода = Новый Граница(КонецДня(НачалоПериодаРегистрации) + 1, ВидГраницы.Исключая);	
	//Запрос.УстановитьПараметр("Период", ГраницаПериода);
	Запрос.УстановитьПараметр("Период", НачалоПериодаРегистрации);
	
	Для Каждого Строка Из Состав Цикл
		стр = Объект.Состав.Добавить();
		ЗаполнитьЗначенияСвойств(стр, Строка);
		
		Запрос.УстановитьПараметр("РБП", Строка.РБП);
		Выборка = Запрос.Выполнить().Выбрать();
		Если Выборка.Следующий() Тогда
			
			Если Выборка.ПроцентТипЗатрат1 <> 0 Тогда
				стр.Субконто3 = Выборка.ТипЗатрат1;
				стр.Остаток = Окр(стр.Остаток / 100 * Выборка.ПроцентТипЗатрат1, 2);
				стр.ОстатокНУ = Окр(стр.ОстатокНУ / 100 * Выборка.ПроцентТипЗатрат1, 2);
				стр.ОстатокПР = Окр(стр.ОстатокПР / 100 * Выборка.ПроцентТипЗатрат1, 2);
				стр.ОстатокВР = Окр(стр.ОстатокВР / 100 * Выборка.ПроцентТипЗатрат1, 2);			
				
				стр.СуммаСписания = Окр(стр.СуммаСписания / 100 * Выборка.ПроцентТипЗатрат1, 2);
				стр.СуммаСписанияНУ = Окр(стр.СуммаСписанияНУ / 100 * Выборка.ПроцентТипЗатрат1, 2);
				стр.СуммаСписанияПР = Окр(стр.СуммаСписанияПР / 100 * Выборка.ПроцентТипЗатрат1, 2);
				стр.СуммаСписанияВР = Окр(стр.СуммаСписанияВР / 100 * Выборка.ПроцентТипЗатрат1, 2);

				стр.КонОстаток = Окр(стр.КонОстаток / 100 * Выборка.ПроцентТипЗатрат1, 2);
				стр.КонОстатокНУ = Окр(стр.КонОстатокНУ / 100 * Выборка.ПроцентТипЗатрат1, 2);
				стр.КонОстатокПР = Окр(стр.КонОстатокПР / 100 * Выборка.ПроцентТипЗатрат1, 2);
				стр.КонОстатокВР = Окр(стр.КонОстатокВР / 100 * Выборка.ПроцентТипЗатрат1, 2);			
			КонецЕсли;
			
			Если Выборка.ПроцентТипЗатрат2 <> 0 Тогда			
				
				Если Выборка.ПроцентТипЗатрат1 <> 0 Тогда
					стр2 = Объект.Состав.Добавить();
					ЗаполнитьЗначенияСвойств(стр2, Строка);
					
					стр2.Субконто3 = Выборка.ТипЗатрат2;
					стр2.Остаток = стр2.Остаток - стр.Остаток;   		//Окр(стр2.Остаток / 100 * Выборка.ПроцентТипЗатрат2, 2);
					стр2.ОстатокНУ = стр2.ОстатокНУ - стр.ОстатокНУ;	//Окр(стр2.ОстатокНУ / 100 * Выборка.ПроцентТипЗатрат2, 2);
					стр2.ОстатокПР = стр2.ОстатокПР - стр.ОстатокПР;	//Окр(стр2.ОстатокПР / 100 * Выборка.ПроцентТипЗатрат2, 2);
					стр2.ОстатокВР = стр2.ОстатокВР - стр.ОстатокВР;	//Окр(стр2.ОстатокВР / 100 * Выборка.ПроцентТипЗатрат2, 2);			
					
					стр2.СуммаСписания = стр2.СуммаСписания - стр.СуммаСписания;		//Окр(стр2.СуммаСписания / 100 * Выборка.ПроцентТипЗатрат2, 2);
					стр2.СуммаСписанияНУ = стр2.СуммаСписанияНУ - стр.СуммаСписанияНУ;	//Окр(стр2.СуммаСписанияНУ / 100 * Выборка.ПроцентТипЗатрат2, 2);
					стр2.СуммаСписанияПР = стр2.СуммаСписанияПР - стр.СуммаСписанияПР;	//Окр(стр2.СуммаСписанияПР / 100 * Выборка.ПроцентТипЗатрат2, 2);
					стр2.СуммаСписанияВР = стр2.СуммаСписанияВР - стр.СуммаСписанияВР;	//Окр(стр2.СуммаСписанияВР / 100 * Выборка.ПроцентТипЗатрат2, 2);
					
					стр2.КонОстаток = стр2.КонОстаток - стр.КонОстаток;   		//Окр(стр2.КонОстаток / 100 * Выборка.ПроцентТипЗатрат2, 2);
					стр2.КонОстатокНУ = стр2.КонОстатокНУ - стр.КонОстатокНУ;	//Окр(стр2.КонОстатокНУ / 100 * Выборка.ПроцентТипЗатрат2, 2);
					стр2.КонОстатокПР = стр2.КонОстатокПР - стр.КонОстатокПР;	//Окр(стр2.КонОстатокПР / 100 * Выборка.ПроцентТипЗатрат2, 2);
					стр2.КонОстатокВР = стр2.КонОстатокВР - стр.КонОстатокВР;	//Окр(стр2.КонОстатокВР / 100 * Выборка.ПроцентТипЗатрат2, 2);
				Иначе
					стр2 = стр;
					стр2.Субконто3 = Выборка.ТипЗатрат2;
					стр2.Остаток = Окр(стр2.Остаток / 100 * Выборка.ПроцентТипЗатрат2, 2);
					стр2.ОстатокНУ = Окр(стр2.ОстатокНУ / 100 * Выборка.ПроцентТипЗатрат2, 2);
					стр2.ОстатокПР = Окр(стр2.ОстатокПР / 100 * Выборка.ПроцентТипЗатрат2, 2);
					стр2.ОстатокВР = Окр(стр2.ОстатокВР / 100 * Выборка.ПроцентТипЗатрат2, 2);			
					
					стр2.СуммаСписания = Окр(стр2.СуммаСписания / 100 * Выборка.ПроцентТипЗатрат2, 2);
					стр2.СуммаСписанияНУ = Окр(стр2.СуммаСписанияНУ / 100 * Выборка.ПроцентТипЗатрат2, 2);
					стр2.СуммаСписанияПР = Окр(стр2.СуммаСписанияПР / 100 * Выборка.ПроцентТипЗатрат2, 2);
					стр2.СуммаСписанияВР = Окр(стр2.СуммаСписанияВР / 100 * Выборка.ПроцентТипЗатрат2, 2);
					
					стр2.КонОстаток = Окр(стр2.КонОстаток / 100 * Выборка.ПроцентТипЗатрат2, 2);
					стр2.КонОстатокНУ = Окр(стр2.КонОстатокНУ / 100 * Выборка.ПроцентТипЗатрат2, 2);
					стр2.КонОстатокПР = Окр(стр2.КонОстатокПР / 100 * Выборка.ПроцентТипЗатрат2, 2);
					стр2.КонОстатокВР = Окр(стр2.КонОстатокВР / 100 * Выборка.ПроцентТипЗатрат2, 2);
				КонецЕсли;
				
			КонецЕсли;
		КонецЕсли;		
	КонецЦикла;

КонецПроцедуры

&НаКлиенте
Процедура pcru_ex_pcru_РаспределитьСуммыВместо(Команда)
	pcru_ex_pcru_РаспределитьСуммыВместоНаСервере();
КонецПроцедуры

&НаСервере
&Перед("ЗаполнитьСоставНаСервере")
Процедура pcru_ex_ЗаполнитьСоставНаСервере(СписокРБП, ДобавлятьСтрокуПриНулевойСумме)
	
	Состав = Объект.Состав.Выгрузить();	
	СоставДляПроверки = Состав.Скопировать();
	СоставДляПроверки.Свернуть("РБП");
	Если Состав.Количество() <> СоставДляПроверки.Количество() Тогда
		СообщениеПользователю = Новый СообщениеПользователю;
		СообщениеПользователю.Текст = "Ранее было выполнено распределение. Для корректного расчета перезаполните документ";
		СообщениеПользователю.Сообщить();
	КонецЕсли;
	
КонецПроцедуры
