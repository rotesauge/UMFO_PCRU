﻿
&НаСервере
Процедура Команда1НаСервере()
	
	
	//	 // Создать WS-прокси на основании ссылки и выполнить операцию Получить()
	//    Определение = Новый WSОпределения("http://ruspbsql01:7085/PC_EXT/WS/Proficredit X/Codeunit/_x0031_CExchange","PCRU\asevryugin","Cherrygarden12345",,,,true);
	//    
	//    Прокси = Новый WSПрокси(Определение,"urn:microsoft-dynamics-schemas/codeunit/_x0031_CExchange", "_x0031_CExchange", "_x0031_CExchange_Port",,,,,true);       
	//	
	//	
	//	
	//	       
	//			Прокси.Пользователь = "PCRU\asevryugin";      Прокси.Пароль = "Cherrygarden12345";
	//	
	//    ДанныеЗаявки = Прокси.GetContractInfo("0009000143");//GetCorrespondenceCount("71802.2","48801.1",ТекущаяДата());
	//	
	//	Сообщить(ДанныеЗаявки);
	//ЧтениеJSON = Новый ЧтениеJSON; 
	//	ЧтениеJSON.УстановитьСтроку(ДанныеЗаявки); 
	//	СтруктураДокумента= ПрочитатьJSON(ЧтениеJSON); 
	//	ЧтениеJSON.Закрыть();
	pcru_ex_WSWORKS.ПолучитьДатуПодписания("0009000143");
	
КонецПроцедуры

&НаКлиенте
Процедура Команда1(Команда)
	Команда1НаСервере();
КонецПроцедуры

&НаСервере
Процедура Команда2НаСервере()
	Определение = Новый WSОпределения("http://ruspbsql01:7085/PC_EXT/WS/Proficredit X/Codeunit/_x0031_CExchange","PCRU\asevryugin","Cherrygarden12345",,,,true);
	Прокси = Новый WSПрокси(Определение,"urn:microsoft-dynamics-schemas/codeunit/_x0031_CExchange", "_x0031_CExchange", "_x0031_CExchange_Port",,,,,true);       
	Прокси.Пользователь = "PCRU\asevryugin";
	Прокси.Пароль = "Cherrygarden12345";             
	Колво = Прокси.GetCorrespondenceCount("47422.1","60323.4",29,06,2020);//GetCorrespondenceCount("71802.2","48801.1",ТекущаяДата());
	Для Стр = 1 По Колво Цикл
		
		Сообщить( Прокси.GetCorrespondence("47422.1","60323.4",29,06,2020,Стр));
		
	КонецЦикла; 
	
	//ЧтениеJSON = Новый ЧтениеJSON; 
	//ЧтениеJSON.УстановитьСтроку(ДанныеЗаявки); 
	//СтруктураДокумента= ПрочитатьJSON(ЧтениеJSON); 
	//ЧтениеJSON.Закрыть();
	//Возврат	 ПолучитьДатуИзСтроки(СтруктураДокумента.DisbursementDate,Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура Команда2(Команда)
	Команда2НаСервере();
КонецПроцедуры

&НаСервере
Процедура Команда3НаСервере()
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	БНФОБанковскийДвиженияССубконто.Регистратор КАК СсылкаНаДокумент
	|ИЗ
	|	РегистрБухгалтерии.БНФОБанковский.ДвиженияССубконто(
	|			&Дата1,
	|			&Дата2,Регистратор Ссылка Документ.БНФОМемориальныйОрдер и (
	|			ВидСубконтоКт2.Наименование = ""Тип затрат""
	|					И СубконтоКт2 = ЗНАЧЕНИЕ(Справочник.БНФОСУБКОНТО.Пустаяссылка)
	|				ИЛИ ВидСубконтоДт2.Наименование = ""Тип затрат""
	|					И СубконтоДт2 = ЗНАЧЕНИЕ(Справочник.БНФОСУБКОНТО.Пустаяссылка)
	|				ИЛИ ВидСубконтоКт3.Наименование = ""Тип затрат""
	|					И СубконтоКт3 = ЗНАЧЕНИЕ(Справочник.БНФОСУБКОНТО.Пустаяссылка)
	|				ИЛИ ВидСубконтоДт3.Наименование = ""Тип затрат""
	|					И СубконтоДт3 = ЗНАЧЕНИЕ(Справочник.БНФОСУБКОНТО.Пустаяссылка)),
	|			,
	|			) КАК БНФОБанковскийДвиженияССубконто";
	Запрос.УстановитьПараметр("Дата1",ЭтаФорма.Дата1);//Дата(2020,08,01));
	Запрос.УстановитьПараметр("Дата2",ЭтаФорма.Дата2);//Дата(2020,09,01) );
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		
		Проводки = РегистрыБухгалтерии.БНФОБанковский.СоздатьНаборЗаписей();
		Проводки.Отбор.Регистратор.Установить(Выборка.СсылкаНаДокумент);
		Проводки.Прочитать();
		Для каждого Проводка Из  Проводки Цикл
			
			Если Лев(Проводка.СчетДт.Код,1) = "7" Тогда
				
				Ндог =  Лев(Прав(Проводка.СчетАналитическогоУчетаКт.Код,15),10);
				
				Если ЗначениеЗаполнено(Ндог)  Тогда
					Нск =  1;
					Для каждого ВидСубконто Из Проводка.СчетДт.ВидыСубконто Цикл
						Если  ВидСубконто.ВидСубконто.Наименование = "Тип затрат"  Тогда
							ДатаВыплаты = pcru_ex_WSWORKS.ПолучитьДатуПодписания(Ндог);
							Если ДатаВыплаты <> Неопределено Тогда
								Если ДатаВыплаты < Дата(2020,5,1,0,0,0) Тогда
									БНФОБухгалтерскийУчет.УстановитьСубконто(Проводка.СчетДт, Проводка.СубконтоДт, Нск, Справочники.БНФОСубконто.НайтиПоКоду("000000092")); 
								Иначе
									БНФОБухгалтерскийУчет.УстановитьСубконто(Проводка.СчетДт, Проводка.СубконтоДт, Нск, Справочники.БНФОСубконто.НайтиПоКоду("000000093")); 
								КонецЕсли;
							КонецЕсли; 
						КонецЕсли;
						Нск = Нск + 1;
					КонецЦикла; 
				КонецЕсли; 
			КонецЕсли; 
			Если Лев(Проводка.СчетКт.Код,1) = "7" Тогда
				
				Ндог =  Лев(Прав(Проводка.СчетАналитическогоУчетаДт.Код,15),10);
				
				Если ЗначениеЗаполнено(Ндог)  Тогда
					Нск =  1;
					Для каждого ВидСубконто Из Проводка.СчетКт.ВидыСубконто Цикл
						Если  ВидСубконто.ВидСубконто.Наименование = "Тип затрат"  Тогда
							ДатаВыплаты = pcru_ex_WSWORKS.ПолучитьДатуПодписания(Ндог);
							Если ДатаВыплаты <> Неопределено Тогда
								Если ДатаВыплаты < Дата(2020,5,1,0,0,0) Тогда
									БНФОБухгалтерскийУчет.УстановитьСубконто(Проводка.СчетКт, Проводка.СубконтоКт, Нск, Справочники.БНФОСубконто.НайтиПоКоду("000000092")); 
								Иначе
									БНФОБухгалтерскийУчет.УстановитьСубконто(Проводка.СчетКт, Проводка.СубконтоКт, Нск, Справочники.БНФОСубконто.НайтиПоКоду("000000093")); 
								КонецЕсли;
							КонецЕсли;
						КонецЕсли;
						Нск = Нск + 1;
					КонецЦикла; 
				КонецЕсли; 
			КонецЕсли; 
		КонецЦикла; 
		Попытка
			Проводки.Записать();
		Исключение
		КонецПопытки; 
		
	КонецЦикла;
	
	
	
КонецПроцедуры

&НаКлиенте
Процедура Команда3(Команда)
	Команда3НаСервере();
КонецПроцедуры

&НаСервере
Процедура Команда4НаСервере()
	pcru_ex_WSWORKS.ОбновитьСостояния();	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура Команда4(Команда)
	Команда4НаСервере();
КонецПроцедуры

&НаСервере
Процедура ПроверитьАдресНаСервере()
	
	СтруктураПроверки = Новый Структура("Адрес, ФорматАдреса", ЭтаФорма.Адрес, "ФИАС");
	РезультатыПроверки = АдресныйКлассификатор.ПроверитьАдреса(ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(СтруктураПроверки));
	
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьАдрес(Команда)
	ПроверитьАдресНаСервере();
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ЭтаФорма.Дата1 = НачалоМесяца(ТекущаяДата());
	ЭтаФорма.Дата2 = КонецМесяца(ТекущаяДата());
КонецПроцедуры

&НаСервере
Процедура УдалениеЗадвоенияМемОрдеровНаСервере()
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	БНФОМемориальныйОрдер.Дата КАК Дата,
	|	ВЫРАЗИТЬ(БНФОМемориальныйОрдер.Комментарий КАК СТРОКА(250)) КАК Комментарий,
	|	МАКСИМУМ(БНФОМемориальныйОрдер.Ссылка) КАК Ссылка,
	|	БНФОМемориальныйОрдер.СуммаОперации КАК Сумма
	|ИЗ
	|	Документ.БНФОМемориальныйОрдер КАК БНФОМемориальныйОрдер
	|ГДЕ
	|	БНФОМемориальныйОрдер.Дата >= &Дата
	|
	|СГРУППИРОВАТЬ ПО
	|	БНФОМемориальныйОрдер.Дата,
	|	ВЫРАЗИТЬ(БНФОМемориальныйОрдер.Комментарий КАК СТРОКА(250)),
	|	БНФОМемориальныйОрдер.СуммаОперации
	|
	|ИМЕЮЩИЕ
	|	КОЛИЧЕСТВО(БНФОМемориальныйОрдер.Ссылка) > 1";
	Запрос.УстановитьПараметр("Дата",ЭтотОбъект.Дата1 );
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		Запрос1 = Новый Запрос;
		Запрос1.Текст = "ВЫБРАТЬ
		|	БНФОМемориальныйОрдер.Ссылка КАК Ссылка
		|ИЗ
		|	Документ.БНФОМемориальныйОрдер КАК БНФОМемориальныйОрдер
		|ГДЕ
		|	БНФОМемориальныйОрдер.Ссылка <> &Ссылка
		|	И БНФОМемориальныйОрдер.Дата = &Дата
		|	И БНФОМемориальныйОрдер.СуммаОперации = &Сумма
		|	И ВЫРАЗИТЬ(БНФОМемориальныйОрдер.Комментарий КАК СТРОКА(250)) ПОДОБНО &Комментарий";
		Запрос1.УстановитьПараметр("Ссылка",Выборка.Ссылка);
		Запрос1.УстановитьПараметр("Дата", Выборка.Дата);
		Запрос1.УстановитьПараметр("Комментарий",Выборка.Комментарий );
		Запрос1.УстановитьПараметр("Сумма", Выборка.Сумма);
		Выборка1 = Запрос1.Выполнить().Выбрать();
		Пока Выборка1.Следующий() Цикл
			Выборка1.Ссылка.ПолучитьОбъект().Удалить();
		КонецЦикла;
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура УдалениеЗадвоенияМемОрдеров(Команда)
	УдалениеЗадвоенияМемОрдеровНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура WSNAV(Команда)
	WSNAVSRV();

КонецПроцедуры

&НаСервере
Процедура WSNAVSRV()
	Определение = Новый WSОпределения("http://ruspbsql01:7085/PC_EXT/WS/Proficredit X/Codeunit/_x0031_CExchange","PCRU\asevryugin","Cherrygarden12345",,,,true);
	Прокси = Новый WSПрокси(Определение,"urn:microsoft-dynamics-schemas/codeunit/_x0031_CExchange", "_x0031_CExchange", "_x0031_CExchange_Port",,,,,true);       
	Прокси.Пользователь = "PCRU\asevryugin";
	Прокси.Пароль = "Cherrygarden12345";
	                                          
	ДанныеЗаявки = Прокси.GetCorrespondence("48801.2","47422.1",24,9,2020,1);
	Сообщить(ДанныеЗаявки);
	//ЧтениеJSON = Новый ЧтениеJSON; 
	//ЧтениеJSON.УстановитьСтроку(ДанныеЗаявки); 
	//СтруктураДокумента= ПрочитатьJSON(ЧтениеJSON); 
	//ЧтениеJSON.Закрыть();
	
	Возврат	 ;

КонецПроцедуры
