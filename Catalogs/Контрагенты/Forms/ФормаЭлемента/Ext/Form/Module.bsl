﻿
&НаСервере                                                       
Функция ПодключениеКWS()             
	МестоположениеWSDL =  			"http://localhost/DOCMNG/ws/Exchange.1cws?wsdl";//"http://localhost/DO/ws/Exchange.1cws?wsdl" ; //localhost - указываем ваш ip-адрес, где опубликован ws
	ИмяПользователя =   			"Admin";
	Пароль=             			"vTFXSSWX";
	URIПространстваИменСервиса =  	"1.1.1.1 ";     
	ИмяСервиса= 					"Exchange";
		
	ЗащищенноеСоединение = Новый ЗащищенноеСоединениеOpenSSL;            
	
	ВСОпределение = Новый WSОпределения(МестоположениеWSDL, ИмяПользователя, Пароль,,,ЗащищенноеСоединение);        	
	ВСПрокси = Новый WSПрокси(ВСОпределение,URIПространстваИменСервиса , ИмяСервиса,ИмяСервиса+"Soap" );     
	
	ВСПрокси.Пользователь = ИмяПользователя;
	ВСПрокси.Пароль = Пароль;
		
	Возврат ВСПрокси;

КонецФункции
	


&НаСервере
Процедура pcru_ex_ОтправитьВДокументооборотПослеНаСервере()
		
	//СтрJSON = ргОбменДанными.СтруктураКонтрагент(Объект.Ссылка);
	//Определение = Новый WSОпределения("http://ruspbpacc01/DOCMNG/ws/DocumentWorkflow.1cws?wsdl","WS","WS159753");
	//Прокси = Новый WSПрокси(Определение, "http://ruspbpacc01/DocumentWorkflow","Pcru_DocumentWorkflow" ,"Pcru_DocumentWorkflowSoap" );
	//Прокси.Пользователь = "WS";      Прокси.Пароль = "WS159753";
	//Результат = Прокси.NewContragent(СтрJSON);
	//Сообщить(Результат);
	//Возврат;
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Контрагент не записан.");
		Возврат;
	КонецЕсли;
	
	Попытка
		ргОбменДанными.ОтправитьВОбмен("Контрагент", Справочники.ОбменДаннымиКлиенты.НайтиПоКоду("UMFO"), Справочники.ОбменДаннымиКлиенты.НайтиПоКоду("DOCMNG"), Объект.Ссылка, Справочники.Контрагенты.СтруктураКонтрагент(Объект.Ссылка));
		
		//Запрос=Новый Запрос("ВЫБРАТЬ
		//|	ОбменДанными.Ссылка КАК Ссылка
		//|ИЗ
		//|	Справочник.ОбменДанными КАК ОбменДанными
		//|ГДЕ
		//|	ОбменДанными.Объект = &Ссылка");
		//Запрос.УстановитьПараметр("Ссылка",Объект.Ссылка);
		//НачатьТранзакцию();
		//РезЗапроса=Запрос.Выполнить();
		//ЗафиксироватьТранзакцию();
		//Если  РезЗапроса.Пустой() Тогда
		//	ОбменДанными=Справочники.ОбменДанными.СоздатьЭлемент();
		//	ОбменДанными.ДатаСоздания=ТекущаяДата();
		//	ОбменДанными.ВидСообщения=Справочники.ОбменДаннымиВидыСообщений.НайтиПоНаименованию("Контрагент");
		//	Если не ЗначениеЗаполнено(ОбменДанными.ВидСообщения) Тогда
		//		ВидСообщения = Справочники.ОбменДаннымиВидыСообщений.СоздатьЭлемент();
		//		ВидСообщения.Наименование = "Контрагент";
		//		ВидСообщения.Записать();
		//		ОбменДанными.ВидСообщения = ВидСообщения.Ссылка;
		//	КонецЕсли; 
		//	ОбменДанными.Отправитель=Справочники.ОбменДаннымиКлиенты.НайтиПоКоду("UMFO");
		//	ОбменДанными.Получатель=Справочники.ОбменДаннымиКлиенты.НайтиПоКоду("DOCMNG");
		//	ОбменДанными.Пользователь=ПараметрыСеанса.ТекущийПользователь;
		//	Если ОбменДанными.Пользователь.Пустая() Тогда
		//		ОбменДанными.Пользователь = Справочники.Пользователи.НайтиПоНаименованию("WS");
		//	КонецЕсли;
		//	ОбменДанными.ТелоСообщения="";
		//	ОбменДанными.Объект=Объект.Ссылка;
		//	ОбменДанными.ТипСообщения=Перечисления.ОбменДаннымиТипыСообщений.Исходящее;
		//	ОбменДанными.ТочкаМаршрута = Перечисления.ОбменДаннымиТочкиМаршрута.Новое;
		//	НачатьТранзакцию();
		//	ОбменДанными.Записать();
		//	ЗафиксироватьТранзакцию();
		//КонецЕсли;
		
		Сообщить("Успешно отправлено в Документооборот.");
	Исключение
		Сообщить("Ошибка отправки в Документооборот: " + ОписаниеОшибки());
	КонецПопытки;
КонецПроцедуры

Процедура pcru_ex_ОтправитьВДокументооборотПослеНаСервереOLD()
	СтруктураОбмена = Новый Структура;
	СтруктураОбмена.Вставить("Код",ЭтотОбъект.Объект.Код);
	СтруктураОбмена.Вставить("ИНН",ЭтотОбъект.Объект.ИНН);
	СтруктураОбмена.Вставить("КПП",ЭтотОбъект.Объект.КПП);
	СтруктураОбмена.Вставить("РодительКод",ЭтотОбъект.Объект.Родитель.Код);
	СтруктураОбмена.Вставить("Наименование",ЭтотОбъект.Объект.Наименование);
	СтруктураОбмена.Вставить("НаименованиеПолное",ЭтотОбъект.Объект.НаименованиеПолное);
	СтруктураОбмена.Вставить("НаименованиеПолное",ЭтотОбъект.Объект.НаименованиеПолное);
	СтруктураОбмена.Вставить("Комментарий",ЭтотОбъект.Объект.Комментарий);
	СтруктураОбмена.Вставить("ЮридическоеФизическоеЛицо",?(ЭтотОбъект.Объект.ЮридическоеФизическоеЛицо=Перечисления.ЮридическоеФизическоеЛицо.ФизическоеЛицо,"ФизическоеЛицо","ЮридическоеЛицо"));
	
	МассивКИ = Новый Массив;
	Для Каждого СтрокаТЧ Из ЭтотОбъект.Объект.КонтактнаяИнформация Цикл
		СтруктураОбменаКИ = Новый Структура;
		//
		Если СтрокаТЧ.Тип  = Перечисления.ТипыКонтактнойИнформации.Адрес Тогда
			СтруктураОбменаКИ.Вставить("Тип","Адрес");
			СтруктураОбменаКИ.Вставить("Регион",лев(СтрокаТЧ.Представление,6));
		КонецЕсли; 
		//
		Если СтрокаТЧ.Тип  = Перечисления.ТипыКонтактнойИнформации.Телефон Тогда
			СтруктураОбменаКИ.Вставить("Тип","Телефон");
			СтруктураОбменаКИ.Вставить("НомерТелефона",СтрокаТЧ.Представление);
		КонецЕсли; 
		//
		Если СтрокаТЧ.Тип  = Перечисления.ТипыКонтактнойИнформации.АдресЭлектроннойПочты Тогда
			СтруктураОбменаКИ.Вставить("Тип","АдресЭлектроннойПочты");
		КонецЕсли; 
		//
		Если СтрокаТЧ.Тип  = Перечисления.ТипыКонтактнойИнформации.Skype Тогда
			СтруктураОбменаКИ.Вставить("Тип","Skype");
		КонецЕсли; 
		//
		Если СтрокаТЧ.Тип  = Перечисления.ТипыКонтактнойИнформации.ВебСтраница Тогда
			СтруктураОбменаКИ.Вставить("Тип","ВебСтраница");
		КонецЕсли; 
		//
		Если СтрокаТЧ.Тип  = Перечисления.ТипыКонтактнойИнформации.Факс Тогда
			СтруктураОбменаКИ.Вставить("Тип","Факс");
		КонецЕсли; 
		//
		Если СтрокаТЧ.Тип  = Перечисления.ТипыКонтактнойИнформации.Другое Тогда
			СтруктураОбменаКИ.Вставить("Тип","Другое");
		КонецЕсли; 
		//
		Если СтрокаТЧ.Вид  = Справочники.ВидыКонтактнойИнформации.ФактАдресКонтрагента Тогда
			СтруктураОбменаКИ.Вставить("Вид","ФактАдресКонтрагента");
		КонецЕсли; 
		//
		Если СтрокаТЧ.Вид  = Справочники.ВидыКонтактнойИнформации.EmailКонтрагенты Тогда
			СтруктураОбменаКИ.Вставить("Вид","EmailКонтрагенты");
		КонецЕсли; 
		//
		Если СтрокаТЧ.Вид  = Справочники.ВидыКонтактнойИнформации.ДругаяИнформацияКонтрагенты Тогда
			СтруктураОбменаКИ.Вставить("Вид","ДругаяИнформацияКонтрагенты");
		КонецЕсли; 
		//
		Если СтрокаТЧ.Вид  = Справочники.ВидыКонтактнойИнформации.ПочтовыйАдресКонтрагента Тогда
			СтруктураОбменаКИ.Вставить("Вид","ПочтовыйАдресКонтрагента");
		КонецЕсли; 
		//
		Если СтрокаТЧ.Вид  = Справочники.ВидыКонтактнойИнформации.ТелефонКонтрагента Тогда
			СтруктураОбменаКИ.Вставить("Вид","ТелефонКонтрагента");
		КонецЕсли; 
		//
		Если СтрокаТЧ.Вид  = Справочники.ВидыКонтактнойИнформации.ФаксКонтрагенты Тогда
			СтруктураОбменаКИ.Вставить("Вид","ФаксКонтрагенты");
		КонецЕсли; 
		//
		Если СтрокаТЧ.Вид  = Справочники.ВидыКонтактнойИнформации.ЮрАдресКонтрагента Тогда
			СтруктураОбменаКИ.Вставить("Вид","ЮрАдресКонтрагента");
		КонецЕсли; 
		СтруктураОбменаКИ.Вставить("Представление",СтрокаТЧ.Представление);
		
		МассивКИ.Добавить(СтруктураОбменаКИ);	
		
	КонецЦикла;   
	
	СтруктураОбмена.Вставить("КИ",МассивКИ);
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	БанковскиеСчета.Код КАК Код,
	|	БанковскиеСчета.Наименование КАК Наименование,
	|	БанковскиеСчета.НомерСчета КАК НомерСчета,
	|	БанковскиеСчета.Банк КАК Банк,
	|	БанковскиеСчета.Валютный КАК Валютный,
	|	БанковскиеСчета.ВалютаДенежныхСредств КАК ВалютаДенежныхСредств,
	|	БанковскиеСчета.НомерИДатаРазрешения КАК НомерИДатаРазрешения,
	|	БанковскиеСчета.ДатаОткрытия КАК ДатаОткрытия,
	|	БанковскиеСчета.ДатаЗакрытия КАК ДатаЗакрытия,
	|	БанковскиеСчета.ПодразделениеОрганизации КАК ПодразделениеОрганизации,
	|	БанковскиеСчета.БанкДляРасчетов КАК БанкДляРасчетов,
	|	БанковскиеСчета.ВидСчета КАК ВидСчета,
	|	БанковскиеСчета.ТекстКорреспондента КАК ТекстКорреспондента,
	|	БанковскиеСчета.ТекстНазначения КАК ТекстНазначения,
	|	БанковскиеСчета.МесяцПрописью КАК МесяцПрописью,
	|	БанковскиеСчета.СуммаБезКопеек КАК СуммаБезКопеек,
	|	БанковскиеСчета.ВсегдаУказыватьКПП КАК ВсегдаУказыватьКПП,
	|	БанковскиеСчета.БНФОГруппаФинансовогоУчета КАК БНФОГруппаФинансовогоУчета,
	|	БанковскиеСчета.ГосударственныйКонтракт КАК ГосударственныйКонтракт,
	|	БанковскиеСчета.БНФОСвязанныйКонтрагент КАК БНФОСвязанныйКонтрагент,
	|	БанковскиеСчета.БНФОГруппаФинансовогоУчетаДенежныеСредстваВПути КАК БНФОГруппаФинансовогоУчетаДенежныеСредстваВПути,
	|	БанковскиеСчета.АЭ_ВидСчетаДляРеестра КАК АЭ_ВидСчетаДляРеестра,
	|	БанковскиеСчета.СчетКорпоративныхРасчетов КАК СчетКорпоративныхРасчетов,
	|	БанковскиеСчета.СчетБанк КАК СчетБанк,
	|	БанковскиеСчета.Банк.Код КАК БанкКод,
	|	БанковскиеСчета.Банк.Наименование КАК БанкНаименование,
	|	БанковскиеСчета.Банк.КоррСчет КАК БанкКоррСчет,
	|	БанковскиеСчета.Банк.Город КАК БанкГород,
	|	БанковскиеСчета.Банк.Адрес КАК БанкАдрес,
	|	БанковскиеСчета.Банк.Телефоны КАК БанкТелефоны,
	|	БанковскиеСчета.Банк.СВИФТБИК КАК БанкСВИФТБИК
	|ИЗ
	|	Справочник.БанковскиеСчета КАК БанковскиеСчета
	|ГДЕ
	|	БанковскиеСчета.Владелец = &Владелец
	|	ИЛИ БанковскиеСчета.БНФОСвязанныйКонтрагент = &Владелец";
	Запрос.УстановитьПараметр("Владелец",ЭтотОбъект.Объект.Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		СтруктураОбмена.Вставить("БанкКод",Выборка.БанкКод);
		СтруктураОбмена.Вставить("БанкНаименование",Выборка.БанкНаименование);
		СтруктураОбмена.Вставить("БанкКоррСчет",Выборка.БанкКоррСчет);
		СтруктураОбмена.Вставить("БанкГород",Выборка.БанкГород);
		СтруктураОбмена.Вставить("БанкАдрес",Выборка.БанкАдрес);
		СтруктураОбмена.Вставить("БанкТелефоны",Выборка.БанкТелефоны);
		СтруктураОбмена.Вставить("СчетНаименование",Выборка.Наименование);
		СтруктураОбмена.Вставить("НомерСчета",Выборка.НомерСчета);
		СтруктураОбмена.Вставить("ТекстКорреспондента",Выборка.ТекстКорреспондента);
		СтруктураОбмена.Вставить("ДатаОткрытия",Выборка.ДатаОткрытия);
		СтруктураОбмена.Вставить("ДатаЗакрытия",Выборка.ДатаЗакрытия);
		СтруктураОбмена.Вставить("ТекстНазначенияПлатежа",Выборка.ТекстНазначения);
	КонецЦикла;
	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJSON.УстановитьСтроку();
	ЗаписатьJSON(ЗаписьJSON,СтруктураОбмена ); 
	СтрJSON = ЗаписьJSON.Закрыть();
	
	
	
	
	
	Определение = Новый WSОпределения("http://ruspbpacc01/DOCMNG/ws/DocumentWorkflow.1cws?wsdl","WS","WS159753");
	Прокси = Новый WSПрокси(Определение, "http://ruspbpacc01/DocumentWorkflow","Pcru_DocumentWorkflow" ,"Pcru_DocumentWorkflowSoap" );       
	Прокси.Пользователь = "WS";      Прокси.Пароль = "WS159753";
	Результат = Прокси.NewContragent(СтрJSON);
	Сообщить(Результат);

	
	
	
	
	
	
	//Подключение = ПодключениеКWS();
	//Хранилище = Подключение.LoadContragent(СтрJSON);
	//Сообщить(СтрJSON);
	
	//СтрокаПодключения     = "srvr='RUSPBPACC01'; ref='docmng_new'; usr='Admin'; pwd='vTFXSSWX';";
	//
	//ComConnector          = Новый COMОбъект("V83.COMConnector");
	//
	//СообщениеПользователю = Новый СообщениеПользователю;
	//
	//ComConnection = COMConnector.Connect(СтрокаПодключения);
	//
	//ComConnection.ЗаписатьКонтрагента(СтрJSON);
	
	//
	//_Справочники =ComConnection.Справочники;
	//_Перечисления =ComConnection.Перечисления;
	// //  МенеджерКонтрагентов.CreateItem();
	//Если ЭтотОбъект.Объект.ЭтоГруппа тогда
	//	Запрос0 = ComConnection.NewObject("Запрос");
	//	Запрос0.Текст = "ВЫБРАТЬ
	//	|	Контрагенты.Ссылка КАК Ссылка
	//	|ИЗ
	//	|	Справочник.Контрагенты КАК Контрагенты
	//	|ГДЕ
	//	|	Контрагенты.Код = &Код и Контрагенты.Этогруппа";
	//	Запрос0.УстановитьПараметр("Код", ЭтотОбъект.Объект.Код);
	//	Результат0 = Запрос0.Выполнить();
	//	Выборка0 = Результат0.Выбрать();
	//	Если Выборка0.Объект0.Следующий() тогда
	//		//
	//	Иначе	
	//		ГрпОб = _Справочники.Контрагенты.СоздатьГруппу();
	//		ГрпОб.Код = ЭтотОбъект.Объект.Код;
	//		ГрпОб.Наименование = ЭтотОбъект.Объект.Наименование;
	//	КонецЕсли;
	//	
	//	Если ЭтотОбъект.Объект.РодительКод <> "" тогда
	//		ГрпОб.Родитель =  _Справочники.Контрагенты.НайтиПоКоду(ЭтотОбъект.Объект.РодительКод);
	//	КонецЕсли;
	//	ГрпОб.Записать();
	//	ГрпОб = Неопределено;
	//Иначе
	//	//Запрос1 = ComConnection.NewObject("Запрос");
	//	//Запрос1.Текст = "ВЫБРАТЬ
	//	//|	Контрагенты.Ссылка КАК Ссылка
	//	//|ИЗ
	//	//|	Справочник.Контрагенты КАК Контрагенты
	//	//|ГДЕ
	//	//|	Контрагенты.ИНН = &ИНН
	//	//|	И Контрагенты.КПП = &КПП
	//	//|	И Контрагенты.Наименование = &Наименование";
	//	//Запрос1.УстановитьПараметр("ИНН", ЭтотОбъект.Объект.ИНН);
	//	//Запрос1.УстановитьПараметр("КПП", ЭтотОбъект.Объект.КПП);
	//	//Запрос1.УстановитьПараметр("Наименование", ЭтотОбъект.Объект.Наименование);
	//	//Результат1 = Запрос1.Выполнить();
	//	//Выборка1 = Результат1.Выбрать();
	//	//Если Выборка1.Следующий() тогда
	//	//	СпрОб = Выборка1.Ссылка.ПолучитьОбъект();
	//	//Иначе	
	//	//	СпрОб = _Справочники.Контрагенты.СоздатьЭлемент();
	//	//КонецЕсли;
	
	//	
	//	СпрСС = Справочники.Контрагенты.НайтиПоРеквизиту("ИНН",ЭтотОбъект.Объект.ИНН);
	//	Если СпрСС.Пустая() тогда
	//		СпрОб = _Справочники.Контрагенты.СоздатьЭлемент();
	//		СпрОб.Код = ЭтотОбъект.Объект.Код;
	//	Иначе	
	//		СпрОб = СпрСС.ПолучитьОбъект();
	//	КонецЕсли;
	
	//	//Если Выборка1.Следующий() тогда
	//	//	СпрОб = Выборка1.Ссылка.ПолучитьОбъект();
	//	//Иначе	
	//	//	СпрОб = _Справочники.Контрагенты.СоздатьЭлемент();
	//	//КонецЕсли;
	//	
	//	Если не ЭтотОбъект.Объект.Родитель.Пустая() тогда
	//		СпрОб.Родитель = _Справочники.Контрагенты.НайтиПоКоду(ЭтотОбъект.Объект.Родитель.Код);
	//	КонецЕсли;
	//	СпрОб.Наименование = ЭтотОбъект.Объект.Наименование;  //ЭтотОбъект.Объект.Наименование = "КПД ООО"
	//	
	//	//Если Не ЗначениеЗаполнено(_Справочники.Контрагенты.НайтиПоКоду(ЭтотОбъект.Объект.Код)) Тогда 
	//	//	СпрОб.Код = ЭтотОбъект.Объект.Код;
	//	//КонецЕсли;
	//	
	//	СпрОб.НаименованиеПолное = ЭтотОбъект.Объект.НаименованиеПолное;
	//	/////////////////////////////////////////////////////
	//	
	//	
	//	Для Каждого СтрокаТЧ Из ЭтотОбъект.Объект.КонтактнаяИнформация Цикл
	//	//
	//	СтрокаКИ = СпрОб.КонтактнаяИнформация.Добавить();
	//	//
	//	Если СтрокаТЧ.Тип  = Перечисления.ТипыКонтактнойИнформации.Адрес Тогда
	//		СтрокаКИ.Тип =  _Перечисления.ТипыКонтактнойИнформации.Адрес;
	//		СтрокаКИ.Регион = лев(СтрокаТЧ.Представление,6);
	//	КонецЕсли; 
	//	//
	//	Если СтрокаТЧ.Тип  = Перечисления.ТипыКонтактнойИнформации.Телефон Тогда
	//		СтрокаКИ.Тип =  _Перечисления.ТипыКонтактнойИнформации.Телефон;
	//		СтрокаКИ.НомерТелефона = СтрокаТЧ.Представление;
	//	КонецЕсли; 
	//	//
	//	Если СтрокаТЧ.Тип  = Перечисления.ТипыКонтактнойИнформации.АдресЭлектроннойПочты Тогда
	//		СтрокаКИ.Тип =  _Перечисления.ТипыКонтактнойИнформации.АдресЭлектроннойПочты;
	//	КонецЕсли; 
	//	//
	//	Если СтрокаТЧ.Тип  = Перечисления.ТипыКонтактнойИнформации.Skype Тогда
	//		СтрокаКИ.Тип =  _Перечисления.ТипыКонтактнойИнформации.Skype;
	//	КонецЕсли; 
	//	//
	//	Если СтрокаТЧ.Тип  = Перечисления.ТипыКонтактнойИнформации.ВебСтраница Тогда
	//		СтрокаКИ.Тип =  _Перечисления.ТипыКонтактнойИнформации.ВебСтраница;
	//	КонецЕсли; 
	//	//
	//	Если СтрокаТЧ.Тип  = Перечисления.ТипыКонтактнойИнформации.Факс Тогда
	//		СтрокаКИ.Тип =  _Перечисления.ТипыКонтактнойИнформации.Факс;
	//	КонецЕсли; 
	//	//
	//	Если СтрокаТЧ.Тип  = Перечисления.ТипыКонтактнойИнформации.Другое Тогда
	//		СтрокаКИ.Тип =  _Перечисления.ТипыКонтактнойИнформации.Другое;
	//	КонецЕсли; 
	//	//
	//	Если СтрокаТЧ.Тип  = Справочники.ВидыКонтактнойИнформации.ФактАдресКонтрагента Тогда
	//		СтрокаКИ.Вид = _Справочники.ВидыКонтактнойИнформации.ФактАдресКонтрагента;
	//	КонецЕсли; 
	//	//
	//	Если СтрокаТЧ.Тип  = Справочники.ВидыКонтактнойИнформации.EmailКонтрагенты Тогда
	//		СтрокаКИ.Вид = _Справочники.ВидыКонтактнойИнформации.EmailКонтрагенты;
	//	КонецЕсли; 
	//	//
	//	Если СтрокаТЧ.Тип  = Справочники.ВидыКонтактнойИнформации.ДругаяИнформацияКонтрагенты Тогда
	//		СтрокаКИ.Вид = _Справочники.ВидыКонтактнойИнформации.ДругаяИнформацияКонтрагенты;
	//	КонецЕсли; 
	//	//
	//	Если СтрокаТЧ.Тип  = Справочники.ВидыКонтактнойИнформации.ПочтовыйАдресКонтрагента Тогда
	//		СтрокаКИ.Вид = _Справочники.ВидыКонтактнойИнформации.ПочтовыйАдресКонтрагента;
	//	КонецЕсли; 
	//	//
	//	Если СтрокаТЧ.Тип  = Справочники.ВидыКонтактнойИнформации.ТелефонКонтрагента Тогда
	//		СтрокаКИ.Вид = _Справочники.ВидыКонтактнойИнформации.ТелефонКонтрагента;
	//	КонецЕсли; 
	//	//
	//	Если СтрокаТЧ.Тип  = Справочники.ВидыКонтактнойИнформации.ФаксКонтрагенты Тогда
	//		СтрокаКИ.Вид = _Справочники.ВидыКонтактнойИнформации.ФаксКонтрагенты;
	//	КонецЕсли; 
	//	//
	//	Если СтрокаТЧ.Тип  = Справочники.ВидыКонтактнойИнформации.ЮрАдресКонтрагента Тогда
	//		СтрокаКИ.Вид = _Справочники.ВидыКонтактнойИнформации.ЮрАдресКонтрагента;
	//	КонецЕсли; 
	//	
	//	СтрокаКИ.Представление = СтрокаТЧ.Представление;
	//КонецЦикла;   
	//СпрОб.КПП = ЭтотОбъект.Объект.КПП;
	//СпрОб.ИНН = ЭтотОбъект.Объект.ИНН;
	//Если  СтрЧислоВхождений(СпрОб.Комментарий,ЭтотОбъект.Объект.Комментарий) = 0 тогда 
	//	СпрОб.Комментарий = СпрОб.Комментарий +" "+ ЭтотОбъект.Объект.Комментарий;
	//КонецЕсли;
	//СпрОб.ЮридическоеФизическоеЛицо = ?(ЭтотОбъект.Объект.ЮридическоеФизическоеЛицо=Перечисления.ЮридическоеФизическоеЛицо.ФизическоеЛицо,
	//ComConnection.Перечисления.ЮридическоеФизическоеЛицо.ФизическоеЛицо,
	//ComConnection.Перечисления.ЮридическоеФизическоеЛицо.ЮридическоеЛицо);
	//СпрОб.Записать();
	//
	//
	//Запрос = Новый Запрос;
	//Запрос.Текст = "ВЫБРАТЬ
	//|	БанковскиеСчета.Владелец КАК Владелец,
	//|	БанковскиеСчета.Код КАК Код,
	//|	БанковскиеСчета.Наименование КАК Наименование,
	//|	БанковскиеСчета.НомерСчета КАК НомерСчета,
	//|	БанковскиеСчета.Банк КАК Банк,
	//|	БанковскиеСчета.Валютный КАК Валютный,
	//|	БанковскиеСчета.ВалютаДенежныхСредств КАК ВалютаДенежныхСредств,
	//|	БанковскиеСчета.НомерИДатаРазрешения КАК НомерИДатаРазрешения,
	//|	БанковскиеСчета.ДатаОткрытия КАК ДатаОткрытия,
	//|	БанковскиеСчета.ДатаЗакрытия КАК ДатаЗакрытия,
	//|	БанковскиеСчета.ПодразделениеОрганизации КАК ПодразделениеОрганизации,
	//|	БанковскиеСчета.БанкДляРасчетов КАК БанкДляРасчетов,
	//|	БанковскиеСчета.ВидСчета КАК ВидСчета,
	//|	БанковскиеСчета.ТекстКорреспондента КАК ТекстКорреспондента,
	//|	БанковскиеСчета.ТекстНазначения КАК ТекстНазначения,
	//|	БанковскиеСчета.МесяцПрописью КАК МесяцПрописью,
	//|	БанковскиеСчета.СуммаБезКопеек КАК СуммаБезКопеек,
	//|	БанковскиеСчета.ВсегдаУказыватьКПП КАК ВсегдаУказыватьКПП,
	//|	БанковскиеСчета.БНФОГруппаФинансовогоУчета КАК БНФОГруппаФинансовогоУчета,
	//|	БанковскиеСчета.ГосударственныйКонтракт КАК ГосударственныйКонтракт,
	//|	БанковскиеСчета.БНФОСвязанныйКонтрагент КАК БНФОСвязанныйКонтрагент,
	//|	БанковскиеСчета.БНФОГруппаФинансовогоУчетаДенежныеСредстваВПути КАК БНФОГруппаФинансовогоУчетаДенежныеСредстваВПути,
	//|	БанковскиеСчета.АЭ_ВидСчетаДляРеестра КАК АЭ_ВидСчетаДляРеестра,
	//|	БанковскиеСчета.СчетКорпоративныхРасчетов КАК СчетКорпоративныхРасчетов,
	//|	БанковскиеСчета.СчетБанк КАК СчетБанк,
	//|	БанковскиеСчета.Банк.Код КАК БанкКод,
	//|	БанковскиеСчета.Банк.Наименование КАК БанкНаименование,
	//|	БанковскиеСчета.Банк.КоррСчет КАК БанкКоррСчет,
	//|	БанковскиеСчета.Банк.Город КАК БанкГород,
	//|	БанковскиеСчета.Банк.Адрес КАК БанкАдрес,
	//|	БанковскиеСчета.Банк.Телефоны КАК БанкТелефоны,
	//|	БанковскиеСчета.Банк.СВИФТБИК КАК БанкСВИФТБИК
	//|ИЗ
	//|	Справочник.БанковскиеСчета КАК БанковскиеСчета
	//|ГДЕ
	//|	БанковскиеСчета.Владелец = &Владелец
	//|	ИЛИ БанковскиеСчета.БНФОСвязанныйКонтрагент = &Владелец";
	//Запрос.УстановитьПараметр("Владелец",ЭтотОбъект.Объект.Ссылка);
	//Выборка = Запрос.Выполнить().Выбрать();
	//Пока Выборка.Следующий() Цикл
	//	
	//	
	//	Попытка
	//	Банк =  _Справочники.КлассификаторБанковРФ.НайтиПоКоду(Выборка.БанкКод); 
	//	Если Банк.Пустая() Тогда
	//		_КлассификаторБанковРФ = _Справочники.КлассификаторБанковРФ;
	//		БанкОб              = _КлассификаторБанковРФ.СоздатьЭлемент();
	//		БанкОб.Код          = Выборка.БанкКод;
	//		БанкОб.Наименование = Выборка.БанкНаименование;
	//		БанкОб.КоррСчет     = Выборка.БанкКоррСчет;
	//		БанкОб.Город        = Выборка.БанкГород;
	//		БанкОб.Адрес        = Выборка.БанкАдрес;
	//		БанкОб.Телефоны     = Выборка.БанкТелефоны;
	//		БанкОб.Записать();
	//		Банк                = БанкОб.Ссылка;
	//	КонецЕсли;    
	//	
	//	_БанковскиеСчета = _Справочники.БанковскиеСчета;
	//	БанковскийСчет                     = _БанковскиеСчета.СоздатьЭлемент();
	//	БанковскийСчет.Наименование        = Выборка.Наименование;
	//	БанковскийСчет.БИКБанка            = Выборка.БанкКод;
	//	БанковскийСчет.Банк                = Банк;
	//	БанковскийСчет.НомерСчета          = Выборка.НомерСчета;
	//	БанковскийСчет.ТекстКорреспондента = Выборка.ТекстКорреспондента;
	//	БанковскийСчет.НаименованиеБанка   = Выборка.БанкНаименование;
	//	БанковскийСчет.КоррСчетБанка       = Выборка.БанкКоррСчет;
	//	БанковскийСчет.ГородБанка          = Выборка.БанкГород;
	//	БанковскийСчет.АдресБанка          = Выборка.БанкАдрес;
	//	БанковскийСчет.ТелефоныБанка       = Выборка.БанкТелефоны;
	//	БанковскийСчет.ДатаОткрытия        = Выборка.НомерСчета;
	//	БанковскийСчет.ДатаЗакрытия        = Выборка.НомерСчета;
	//	БанковскийСчет.Наименование        = Выборка.НомерСчета;
	//	БанковскийСчет.Наименование        = Выборка.НомерСчета;
	//	БанковскийСчет.Владелец            = СпрОб.Ссылка;
	//	
	//	БанковскийСчет.Записать();
	//	Исключение
	//	КонецПопытки; 
	//	
	//КонецЦикла;
	//
	//СпрОб = Неопределено;
	//КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура pcru_ex_ОтправитьВДокументооборотПосле(Команда)
	pcru_ex_ОтправитьВДокументооборотПослеНаСервере();
КонецПроцедуры
