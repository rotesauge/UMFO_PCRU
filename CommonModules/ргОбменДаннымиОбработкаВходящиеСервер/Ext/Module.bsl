﻿
Функция ргОбменВходящиеПринять(вхЗадача, Объект, ТелоОтвета, Ошибка) Экспорт
	
	Результат = Ложь;
	
	Если вхЗадача.ВидСообщения.Наименование = "НачислениеОценочныхОбязательств" Тогда
		Результат = НачислениеОценочныхОбязательствПринять(вхЗадача, Объект, Ошибка);
	ИначеЕсли вхЗадача.ВидСообщения = Справочники.ОбменДаннымиВидыСообщений.НайтиПоКоду("ОтражениеЗарплатыВБухУчете") Тогда
		Результат = ОтражениеЗарплатыВБухучетеПринять(вхЗадача, Объект, Ошибка);
	ИначеЕсли вхЗадача.ВидСообщения = Справочники.ОбменДаннымиВидыСообщений.НайтиПоКоду("ПлатежноеПоручение") Тогда
		Результат = ПлатежноеПоручениеПринять(вхЗадача, Объект, Ошибка);
	КонецЕсли;	

	//Если вхЗадача.ВидСообщения = Справочники.ОбменДаннымиВидыСообщений.НайтиПоНаименованию("Контрагент") Тогда
	//	Результат = КонтрагентПринять(вхЗадача, Объект, Ошибка); 
	//ИначеЕсли вхЗадача.ВидСообщения = Справочники.ОбменДаннымиВидыСообщений.НайтиПоНаименованию("ДокументИзДиадок") Тогда
	//	Результат = СоздатьДокументДиадок(вхЗадача, Объект, Ошибка); 
	//ИначеЕсли вхЗадача.ВидСообщения = Справочники.ОбменДаннымиВидыСообщений.НайтиПоНаименованию("МатрицаЗаместителей") Тогда
	//	Результат = ДобавитьЗаместителя(вхЗадача, Объект, Ошибка);
	//ИначеЕсли вхЗадача.ВидСообщения = Справочники.ОбменДаннымиВидыСообщений.НайтиПоНаименованию("НаименованиеПользователя") Тогда
	//	Результат = УстановитьРусскоязычноеИмяПОльзователя(вхЗадача, Объект, Ошибка);
	//КонецЕсли;
	Возврат Результат;
	
КонецФункции

Функция НачислениеОценочныхОбязательствПринять(вхЗадача, Объект, Ошибка)
	
	НачатьТранзакцию();
	Попытка
		Выборка=pcru_ex_WSWORKS.СтрокуJSONВСтруктуру(вхЗадача.ТипСообщения);
		//Для каждого Выборка Из СтруктураОтвета  Цикл
		//*********************************************************************** 
		НовДок = Документы.НачислениеОценочныхОбязательствПоОтпускам.СоздатьДокумент();
		НовДок.Бухгалтер = ""; 
		НовДок.Номер =  Выборка.Номер;
		
		//ДатаНорм =  Выборка.Дата;
		//ДатаНорм = СтрЗаменить(ДатаНорм,"-","");
		//ДатаНорм = СтрЗаменить(ДатаНорм,":","");
		//ДатаНорм = СтрЗаменить(ДатаНорм," ","");
		//ДатаНорм = СтрЗаменить(ДатаНорм,"T","");
		//ДатаНорм = Дата(ДатаНорм);
		ДатаНорм = ПрочитатьДатуJson(Выборка.Дата, ФорматДатыJSON.ISO);
		//
		НовДок.Дата = ДатаНорм;
		
		//ДатаНорм =  Выборка.ПериодРегистрации;
		//ДатаНорм = СтрЗаменить(ДатаНорм,"-","");
		//ДатаНорм = СтрЗаменить(ДатаНорм,":","");
		//ДатаНорм = СтрЗаменить(ДатаНорм," ","");
		//ДатаНорм = СтрЗаменить(ДатаНорм,"T","");
		//ДатаНорм = Дата(ДатаНорм);
		ДатаНорм = ПрочитатьДатуJson(Выборка.ПериодРегистрации, ФорматДатыJSON.ISO);
		
		НовДок.ПериодРегистрации =  ДатаНорм;
		
		НовДок.Организация = pcru_УМФО.Организация();
		НовДок.ОбязательстваОтраженыВБухучете =  Выборка.ОбязательстваОтраженыВБухучете;
		//		НовДок.Номер =  Выборка.Номер;
		//*********************************************************************** 
		
		Для каждого Выборка2 Из Выборка.ОценочныеОбязательстваПоСотрудникам  Цикл
			СтрокаНачисленнаяЗарплатаИВзносы = НовДок.ОценочныеОбязательства.Добавить();	
			ЗаполнитьЗначенияСвойств(СтрокаНачисленнаяЗарплатаИВзносы,Выборка2);
			СтрокаНачисленнаяЗарплатаИВзносы.pcru_ex_типзатрат = Выборка2.типзатрат ;
			СтрокаНачисленнаяЗарплатаИВзносы.СпособОтраженияЗарплатыВБухучете =  pcru_ex_ЗУП.ПолучитьСпособОтражения(Выборка2.СпособОтраженияЗарплатыВБухучете);
			СтрокаНачисленнаяЗарплатаИВзносы.Подразделение =  pcru_ex_ЗУП.ПолучитьПодразделение(Выборка2.Подразделение);
			//	СтрокаНачисленнаяЗарплатаИВзносы.СпособОтраженияЗарплатыВБухучете =  ПолучитьВидОперации(Выборка2.СпособОтраженияЗарплатыВБухучете);
			//	СтрокаНачисленнаяЗарплатаИВзносы.ВидНачисленияОплатыТрудаДляНУ =  ПолучитьВидНачисленияОплатыТрудаДляНУ(Выборка2.СпособОтраженияЗарплатыВБухучете);
		КонецЦикла;
		//*********************************************************************** 
		НовДок.Записать();
		//КонецЦикла;
		
		//Если ТипЗнч(вхЗадача) = Тип("СправочникСсылка.ОбменДанными") Тогда
		//	вхЗадачаОб = вхЗадача.ПолучитьОбъект();
		//	вхЗадачаОб.Объект = НовДок.Ссылка;
		//	вхЗадачаОб.Записать();
		//КонецЕсли;

		Объект = НовДок.Ссылка;
		ЗафиксироватьТранзакцию();
		ВОзврат Истина;
		
	Исключение
		Ошибка=ОписаниеОшибки();
		ОтменитьТранзакцию();
		Возврат Ложь;
	КонецПопытки;
	
КонецФункции // ргОбменВходящиеПринять(Выб.Ссылка,Ошибка)()

Функция ОтражениеЗарплатыВБухучетеПринять(вхЗадача, Объект, Ошибка)
	
	НачатьТранзакцию();
	Попытка		
		ЧтениеJSON = Новый ЧтениеJSON;
		ЧтениеJSON.УстановитьСтроку(вхЗадача.ТелоСообщения);
		СтруктураДокументаОтражения = ПрочитатьJSON(ЧтениеJSON);
		ЧтениеJSON.Закрыть();
		
		Запрос = Новый Запрос;
		Запрос.УстановитьПараметр("Номер", СтруктураДокументаОтражения.Номер);
		
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ОтражениеЗарплатыВБухучете.Ссылка КАК Ссылка
		|ИЗ
		|	Документ.ОтражениеЗарплатыВБухучете КАК ОтражениеЗарплатыВБухучете
		|ГДЕ
		|	ОтражениеЗарплатыВБухучете.Номер = &Номер";		
		
		Выборка = Запрос.Выполнить().Выбрать();
		Если Выборка.Следующий() Тогда
			НовДок = Выборка.Ссылка.ПолучитьОбъект();
			НовДок.НачисленнаяЗарплатаИВзносы.Очистить();
			НовДок.НачисленныйНДФЛ.Очистить();
			НовДок.УдержаннаяЗарплата.Очистить();
			НовДок.ВыплатаОтпусковЗаСчетРезерва.Очистить();
			НовДок.ФизическиеЛица.Очистить();
		Иначе
			НовДок = Документы.ОтражениеЗарплатыВБухучете.СоздатьДокумент();
		КонецЕсли;
		
		НовДок.Бухгалтер = ""; 
		НовДок.Номер =  СтруктураДокументаОтражения.Номер;
		НовДок.Дата =  ПрочитатьДатуJson(СтруктураДокументаОтражения.Дата, ФорматДатыJSON.ISO); //ПреобразоватьДатуИзСтрокиJSON(СтруктураДокументаОтражения.Дата);
		НовДок.Проведен =  СтруктураДокументаОтражения.Проведен;
		НовДок.ПериодРегистрации =  ПрочитатьДатуJson(СтруктураДокументаОтражения.ПериодРегистрации, ФорматДатыJSON.ISO); //ПреобразоватьДатуИзСтрокиJSON(СтруктураДокументаОтражения.ПериодРегистрации);
		НовДок.Организация =  pcru_УМФО.Организация();
		НовДок.ЗарплатаОтраженаВБухучете =  СтруктураДокументаОтражения.ЗарплатаОтраженаВБухучете;
		НовДок.КраткийСоставДокумента = СтруктураДокументаОтражения.КраткийСоставДокумента;
		НовДок.Комментарий = СтруктураДокументаОтражения.Комментарий;
		
		НаименованиеТЧДокумента = "НачисленнаяЗарплатаИВзносыНеДоходыКонтрагентов";
		НомерСтрокиТЧ = 0;
		Пока СтруктураДокументаОтражения.Свойство(НаименованиеТЧДокумента + НомерСтрокиТЧ) Цикл
			СтруктураЗначений = СтруктураДокументаОтражения[НаименованиеТЧДокумента + НомерСтрокиТЧ];
			
			СтрокаНачисленнаяЗарплатаИВзносы = НовДок.НачисленнаяЗарплатаИВзносы.Добавить();	
			ЗаполнитьЗначенияСвойств(СтрокаНачисленнаяЗарплатаИВзносы, СтруктураЗначений);
			
			СтрокаНачисленнаяЗарплатаИВзносы.ПериодПринятияРасходов = ПрочитатьДатуJson(СтруктураЗначений.ПериодПринятияРасходов, ФорматДатыJSON.ISO);//ПреобразоватьДатуИзСтрокиJSON(СтруктураЗначений.ПериодПринятияРасходов);
			СтрокаНачисленнаяЗарплатаИВзносы.ProcessCode = СтруктураЗначений.ProcessCode;
			СтрокаНачисленнаяЗарплатаИВзносы.pcru_ex_ТипЗатрат = СтруктураЗначений.ТипЗатрат;
			СтрокаНачисленнаяЗарплатаИВзносы.СпособОтраженияЗарплатыВБухучете = pcru_ex_ЗУП.ПолучитьСпособОтражения(СтруктураЗначений.СпособОтраженияЗарплатыВБухучете);
			СтрокаНачисленнаяЗарплатаИВзносы.Подразделение = pcru_ex_ЗУП.ПолучитьПодразделение(СтруктураЗначений.Подразделение);
			СтрокаНачисленнаяЗарплатаИВзносы.ВидОперации = pcru_ex_ЗУП.ПолучитьВидОперации(СтруктураЗначений.ВидОперации);
			СтрокаНачисленнаяЗарплатаИВзносы.ВидНачисленияОплатыТрудаДляНУ = pcru_ex_ЗУП.ПолучитьВидНачисленияОплатыТрудаДляНУ(СтруктураЗначений.СпособОтраженияЗарплатыВБухучете);
			
			НомерСтрокиТЧ = НомерСтрокиТЧ + 1;
		КонецЦикла;
		
		НаименованиеТЧДокумента = "НачисленнаяЗарплатаИВзносыДоходыКонтрагентов";
		НомерСтрокиТЧ = 0;
		Пока СтруктураДокументаОтражения.Свойство(НаименованиеТЧДокумента + НомерСтрокиТЧ) Цикл
			СтруктураЗначений = СтруктураДокументаОтражения[НаименованиеТЧДокумента + НомерСтрокиТЧ];
			
			СтрокаНачисленнаяЗарплатаИВзносы = НовДок.НачисленнаяЗарплатаИВзносы.Добавить();	
			ЗаполнитьЗначенияСвойств(СтрокаНачисленнаяЗарплатаИВзносы, СтруктураЗначений);
			
			СтрокаНачисленнаяЗарплатаИВзносы.ПериодПринятияРасходов = ПрочитатьДатуJson(СтруктураЗначений.ПериодПринятияРасходов, ФорматДатыJSON.ISO);//ПреобразоватьДатуИзСтрокиJSON(СтруктураЗначений.ПериодПринятияРасходов);
			СтрокаНачисленнаяЗарплатаИВзносы.ФизическоеЛицо = pcru_ex_ЗУП.ПолучитьФизЛицоWS(СтруктураЗначений.ФизическоеЛицо, вхЗадача.Отправитель);
			СтрокаНачисленнаяЗарплатаИВзносы.СпособОтраженияЗарплатыВБухучете = pcru_ex_ЗУП.ПолучитьСпособОтражения(СтруктураЗначений.СпособОтраженияЗарплатыВБухучете);
			СтрокаНачисленнаяЗарплатаИВзносы.ВидОперации = pcru_ex_ЗУП.ПолучитьВидОперации(СтруктураЗначений.ВидОперации);
			СтрокаНачисленнаяЗарплатаИВзносы.ВидНачисленияОплатыТрудаДляНУ = pcru_ex_ЗУП.ПолучитьВидНачисленияОплатыТрудаДляНУ(СтруктураЗначений.СпособОтраженияЗарплатыВБухучете);
			
			НомерСтрокиТЧ = НомерСтрокиТЧ + 1;
		КонецЦикла;
		
		НаименованиеТЧДокумента = "НачисленныйНДФЛНеДоходыКонтрагентов";
		НомерСтрокиТЧ = 0;
		Пока СтруктураДокументаОтражения.Свойство(НаименованиеТЧДокумента + НомерСтрокиТЧ) Цикл
			СтруктураЗначений = СтруктураДокументаОтражения[НаименованиеТЧДокумента + НомерСтрокиТЧ];
			
			СтрокаНачисленныйНДФЛ = НовДок.НачисленныйНДФЛ.Добавить();	
			ЗаполнитьЗначенияСвойств(СтрокаНачисленныйНДФЛ, СтруктураЗначений);
			
			СтрокаНачисленныйНДФЛ.ВидОперации = pcru_ex_ЗУП.ПолучитьВидОперации(СтруктураЗначений.ВидОперации);
			
			НомерСтрокиТЧ = НомерСтрокиТЧ + 1;
		КонецЦикла;
		
		НаименованиеТЧДокумента = "НачисленныйНДФЛДоходыКонтрагентов";
		НомерСтрокиТЧ = 0;
		Пока СтруктураДокументаОтражения.Свойство(НаименованиеТЧДокумента + НомерСтрокиТЧ) Цикл
			СтруктураЗначений = СтруктураДокументаОтражения[НаименованиеТЧДокумента + НомерСтрокиТЧ];
			
			СтрокаНачисленныйНДФЛ = НовДок.НачисленныйНДФЛ.Добавить();	
			ЗаполнитьЗначенияСвойств(СтрокаНачисленныйНДФЛ, СтруктураЗначений);
			
			СтрокаНачисленныйНДФЛ.ВидОперации = pcru_ex_ЗУП.ПолучитьВидОперации(СтруктураЗначений.ВидОперации);
			СтрокаНачисленныйНДФЛ.ФизическоеЛицо = pcru_ex_ЗУП.ПолучитьФизЛицоWS(СтруктураЗначений.ФизическоеЛицо, вхЗадача.Отправитель);
			
			НомерСтрокиТЧ = НомерСтрокиТЧ + 1;
		КонецЦикла;
		
		НаименованиеТЧДокумента = "УдержаннаяЗарплата";
		НомерСтрокиТЧ = 0;
		Пока СтруктураДокументаОтражения.Свойство(НаименованиеТЧДокумента + НомерСтрокиТЧ) Цикл
			СтруктураЗначений = СтруктураДокументаОтражения[НаименованиеТЧДокумента + НомерСтрокиТЧ];
			
			СтрокаУдержаннаяЗарплата = НовДок.УдержаннаяЗарплата.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаУдержаннаяЗарплата, СтруктураЗначений);
			
			СтрокаУдержаннаяЗарплата.Подразделение = pcru_ex_ЗУП.ПолучитьПодразделение(СтруктураЗначений.Подразделение);
			СтрокаУдержаннаяЗарплата.ВидОперации = pcru_ex_ЗУП.ПолучитьВидОперации(СтруктураЗначений.ВидОперации);
			Если  СтрокаУдержаннаяЗарплата.ВидОперации = Перечисления.ВидыОперацийПоЗарплате.УдержаниеПоПрочимОперациямСРаботниками тогда
				СтрокаУдержаннаяЗарплата.ФизическоеЛицо = pcru_ex_ЗУП.ПолучитьФизЛицоWS(СтруктураЗначений.ФизическоеЛицо, вхЗадача.Отправитель);
			Конецесли;
			СтрокаУдержаннаяЗарплата.Контрагент = pcru_ex_ЗУП.ПолучитьКонтрагентаWS(СтруктураЗначений.Контрагент, вхЗадача.Отправитель);
			
			НомерСтрокиТЧ = НомерСтрокиТЧ + 1;
		КонецЦикла;
		
		НаименованиеТЧДокумента = "ФизическиеЛица";
		НомерСтрокиТЧ = 0;
		Пока СтруктураДокументаОтражения.Свойство(НаименованиеТЧДокумента + НомерСтрокиТЧ) Цикл
			СтруктураЗначений = СтруктураДокументаОтражения[НаименованиеТЧДокумента + НомерСтрокиТЧ];
			
			СтрокаФизическиеЛица = НовДок.ФизическиеЛица.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаФизическиеЛица, СтруктураЗначений);
			
			СтрокаФизическиеЛица.ФизическоеЛицо = pcru_ex_ЗУП.ПолучитьФизЛицоWS(СтруктураЗначений.ФизическоеЛицо, вхЗадача.Отправитель);
			
			НомерСтрокиТЧ = НомерСтрокиТЧ + 1;
		КонецЦикла;
		
		НовДок.Записать();
		
		//Если ТипЗнч(вхЗадача) = Тип("СправочникСсылка.ОбменДанными") Тогда
		//	вхЗадачаОб = вхЗадача.ПолучитьОбъект();
		//	вхЗадачаОб.Объект = НовДок.Ссылка;
		//	вхЗадачаОб.Записать();
		//КонецЕсли;

		Объект = НовДок.Ссылка;
		ЗафиксироватьТранзакцию();
		Возврат Истина;
	Исключение
		Ошибка=ОписаниеОшибки();
		ОтменитьТранзакцию();
		Возврат Ложь;
	КонецПопытки;
	
КонецФункции // ()

Функция ПлатежноеПоручениеПринять(вхЗадача, Объект, Ошибка)
	
	УстановитьПривилегированныйРежим(Истина);
	Попытка
		ЧтениеJSON = Новый ЧтениеJSON; 
		ЧтениеJSON.УстановитьСтроку(вхЗадача.ТелоСообщения); 
		СтруктураПараметров = ПрочитатьJSON(ЧтениеJSON); 
		ЧтениеJSON.Закрыть();
	Исключение
		Ошибка = ОписаниеОшибки();
		Возврат Ложь;
	КонецПопытки;	

	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ПлатежноеПоручение.Ссылка КАК Ссылка
	|ИЗ
	|	Документ.ПлатежноеПоручение КАК ПлатежноеПоручение
	|ГДЕ
	|	ПлатежноеПоручение.АЭ_Идентификатор = &Номер";
	Запрос.УстановитьПараметр("Номер",Стрзаменить(СокрЛП(СтруктураПараметров.Номер),"-",""));
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		Ошибка = "Документ уже существует, номер документа " + СокрЛП(Выборка.Ссылка.Номер) + " от " + Выборка.Ссылка.Дата;
		Возврат Ложь;			
	КонецЦикла;
		
	НачатьТранзакцию();
	Попытка			
		НовДок = Документы.ПлатежноеПоручение.СоздатьДокумент();
		НовДок.АЭ_Идентификатор = Стрзаменить(СокрЛП(СтруктураПараметров.Номер),"-","");
		НовДок.Дата = ТекущаяДата();
		НовДок.ВидОперации = Перечисления.ВидыОперацийСписаниеДенежныхСредств.ОплатаПоставщику;
		НовДок.Организация = pcru_УМФО.Организация();
		НовДок.Налог = Справочники.ВидыНалоговИПлатежейВБюджет.НайтиПоНаименованию("");
		НовДок.ВидНалоговогоОбязательства = Перечисления.ВидыПлатежейВГосБюджет.Налог;
		НовДок.СчетОрганизации = Справочники.БанковскиеСчета.НайтиПоРеквизиту("НомерСчета","40702810903000479930",,НовДок.Организация);
		НовДок.Контрагент = Справочники.Контрагенты.НайтиПоРеквизиту("ИНН",СтруктураПараметров.Контрагент);

		НовДок.СчетКонтрагента = НовДок.Контрагент.ОсновнойБанковскийСчет;
		НовДок.СуммаДокумента = СтруктураПараметров.Сумма;
		НовДок.СтавкаНДС = Перечисления.СтавкиНДС.НДС20;
		НовДок.СуммаНДС = (СтруктураПараметров.Сумма * 20)/120;
		НовДок.ВидПлатежа = "";
		НовДок.ОчередностьПлатежа = 5;
		НовДок.НазначениеПлатежа = "Оплата счета №" + СтруктураПараметров.Номер + " от " + СтруктураПараметров.Дата;
		НовДок.ВалютаДокумента = pcru_УМФО.ВалютаРубль();
		НовДок.ТекстПлательщика = УчетДенежныхСредствБП.СформироватьТекстНаименованияПлательщикаПолучателя("", НовДок.Организация,     НовДок.СчетОрганизации, Ложь, НовДок.Дата);
		НовДок.ТекстПолучателя = УчетДенежныхСредствБП.СформироватьТекстНаименованияПлательщикаПолучателя("", НовДок.Контрагент,      НовДок.СчетКонтрагента, Ложь, НовДок.Дата);
		НовДок.Комментарий = "Загружено из документооборота оплата счета №" + СтруктураПараметров.НомерДокумента + " от " + СтруктураПараметров.Дата;
		НовДок.ИННПлательщика = НовДок.Организация.ИНН;
		НовДок.КПППлательщика = НовДок.Организация.КПП;
		НовДок.ИННПолучателя = НовДок.Контрагент.ИНН;
		НовДок.СтатьяДвиженияДенежныхСредств = Справочники.СтатьиДвиженияДенежныхСредств.НайтиПоНаименованию("Оплата поставщикам (подрядчикам)") ;
		
		Попытка
			НовДок.КПППолучателя = НовДок.Контрагент.КПП;
		Исключение
		КонецПопытки;
		НовДок.ПодразделениеОрганизации   = Справочники.ПодразделенияОрганизаций.НайтиПоКоду("000000003");
		
		Таблица = Неопределено;
		Если СтруктураПараметров.Свойство("Таблица",Таблица) Тогда
			Запрос1 = Новый Запрос;
			Запрос1.Текст = 
			"ВЫБРАТЬ
			|	pcru_ex_СопоставлениеВнешнихДанных.Значение КАК пкру_СтатьяРасходов
			|ИЗ
			|	РегистрСведений.pcru_ex_СопоставлениеВнешнихДанных КАК pcru_ex_СопоставлениеВнешнихДанных
			|ГДЕ
			|	pcru_ex_СопоставлениеВнешнихДанных.КодВнешнихДанных = &КодВнешнихДанных";
			
			Запрос2 = Новый Запрос;
			Запрос2.Текст = "ВЫБРАТЬ
			|	БНФОСубконто.Ссылка КАК ТипЗатрат
			|ИЗ
			|	Справочник.БНФОСубконто КАК БНФОСубконто
			|ГДЕ
			|	БНФОСубконто.Владелец.Наименование = ""Тип затрат""
			|	И БНФОСубконто.Наименование = &Наименование";
			
			Для Каждого СтрокаТаблицы Из Таблица Цикл
				СтрРЗ = НовДок.пкру_РаспределениеЗатрат.Добавить();
				СтрРЗ.пкру_CostCentr = pcru_УМФО.ПолучитьПодразделениеПоКостЦентру(СтрокаТаблицы.CostCentr);
				//++ Севрюгин А.А  30.12.2020 20:44:55   
				Запрос1.УстановитьПараметр("КодВнешнихДанных",СтрокаТаблицы.СтатьяРасходов );
				ТЗ = Запрос1.Выполнить().Выгрузить();
				Для Каждого Выборка Из ТЗ Цикл
					ЗаполнитьЗначенияСвойств(СтрРЗ, Выборка);
				КонецЦикла;
				 
				Запрос2.УстановитьПараметр("Наименование",СтрокаТаблицы.ТипЗатрат );
				ТЗ = Запрос2.Выполнить().Выгрузить();
				Для Каждого Выборка Из ТЗ Цикл
					ЗаполнитьЗначенияСвойств(СтрРЗ, Выборка);
				КонецЦикла;
				СтрРЗ.Сумма = СтрокаТаблицы.Сумма;
			КонецЦикла; 
		КонецЕсли;
		НовДок.ДополнительныеСвойства.Вставить("АвторВерсии", Справочники.Пользователи.НайтиПоНаименованию("USER"));
		НовДок.Ответственный =  Справочники.Пользователи.НайтиПоНаименованию("USER");
		НовДок.Записать();
		
		ЗафиксироватьТранзакцию();
		Объект = НовДок.Ссылка;
		Возврат Истина;		
	Исключение
		Ошибка = ОписаниеОшибки();
		ОтменитьТранзакцию();
		Возврат Ложь;
	КонецПопытки;

КонецФункции
