
Функция ЗагрузитьКонтрагентаИзНАВ(НомерКонтракта)  экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	СтрокаПодключения = 
	"Provider=MSDASQL.1;
	|UID=1c_test;
	|Pwd=tset_c1;
	|Extended Properties=""DRIVER=SQL Server;
	|SERVER=RUSPBSQL01\CRMRU;
	|APP=1С Reglament Job;
	|DATABASE=PROFICREDIT""";
	//
	Connection  = Новый COMОбъект("ADODB.Connection");
	Command  = Новый COMОбъект("ADODB.Command");
	Command.CommandTimeOut = 300000;
	RecordSet = Новый COMОбъект("ADODB.RecordSet");
	//
	Попытка
		Connection.ConnectionString =СтрокаПодключения;	 
		Connection.Open();
		Command.ActiveConnection   = Connection;
	Исключение
		Возврат ОписаниеОшибки();
	КонецПопытки; 
	//Command.CommandText = "SELECT  
	//|                           contr.[Customer No_], 
	//|                           contr.[Contract No_], 
	//|                           contr.[Date of Signature] as ContrDate, 
	//|                           isnull(crmdata.FIO,'-') as FIO,
	//|                           isnull(crmdata.INN,'-') as INN, 
	//|                           isnull(crmdata.Addr,'-') as Addr,
	//|                           contr.[Product Type] as ProductType
	//|                           FROM            [PROFICREDIT].dbo.[Proficredit X$Contract] AS contr 
	//|                                           LEFT OUTER JOIN
	//|                                                        (SELECT        aeb.clv_TaxpayerID AS INN, cnt.clv_ContractNo, acc.Name AS FIO, acc.clv_DateOfBirth, ISNULL(Addr.Cor, '') AS Addr
	//|                                                         FROM            ProficreditRU_MSCRM.dbo.clv_Contract AS cnt LEFT OUTER JOIN
	//|                                                        (SELECT        AccountId, Name, clv_DateOfBirth
	//|                                                          FROM            ProficreditRU_MSCRM.dbo.Account) AS acc ON cnt.clv_Client = acc.AccountId LEFT OUTER JOIN
	//|                                                        (SELECT        ParentId, MIN(CASE WHEN AddressTypeCode = 2 THEN CONCAT(ISNULL(clv_District + N' р-н, ', ''), ISNULL(PostalCode + ' , ', ''), ISNULL(City, ''), 
	//|                                                                                    ISNULL(N' , ул. ' + Line1, ''), ISNULL(N' , д. ' + Line2, ''), ISNULL(N' , корп. ' + clv_Wing, ''), ISNULL(N' , кв. ' + clv_FlatNumber, '')) END) AS Cor
	//|                                                          FROM            (SELECT        CreatedByYomiName, CreatedOnBehalfByName, ModifiedByYomiName, TransactionCurrencyIdName, CreatedByName, 
	//|                                                                                                              CreatedOnBehalfByYomiName, ModifiedOnBehalfByName, ModifiedOnBehalfByYomiName, ModifiedByName, OwningUser, OwnerId, 
	//|                                                                                                              OwnerIdType, OwningBusinessUnit, ParentId, CustomerAddressId, AddressNumber, ObjectTypeCode, AddressTypeCode, Name, 
	//|                                                                                                              PrimaryContactName, Line1, Line2, Line3, City, StateOrProvince, County, Country, PostOfficeBox, PostalCode, UTCOffset, 
	//|                                                                                                              FreightTermsCode, UPSZone, Latitude, Telephone1, Longitude, ShippingMethodCode, Telephone2, Telephone3, Fax, VersionNumber, 
	//|                                                                                                              CreatedBy, CreatedOn, ModifiedBy, ModifiedOn, TimeZoneRuleVersionNumber, OverriddenCreatedOn, UTCConversionTimeZoneCode, 
	//|                                                                                                              ImportSequenceNumber, ParentIdTypeCode, CreatedOnBehalfBy, ModifiedOnBehalfBy, TransactionCurrencyId, ExchangeRate, 
	//|                                                                                                              clv_AddressCode, clv_cityquatercode, clv_country, clv_CountyCode, clv_RegionCode, clv_Validated, clv_ValidFrom, clv_ValidTo, 
	//|                                                                                                              clv_Dateofregistration, clv_Wing, clv_FlatNumber, clv_StayStartDate, clv_ApprovedForContract, clv_District, clv_PlaceType, nav_isnew, 
	//|                                                                                                              pcr_cityguid, pcr_streetguid, nav_Lat, nav_Lng, clv_personaldata
	//|                                                                                    FROM            ProficreditRU_MSCRM.dbo.CustomerAddress
	//|                                                                                    WHERE        (clv_ValidTo IS NULL) AND (City IS NOT NULL)) AS t
	//|                                                          GROUP BY ParentId) AS Addr ON acc.AccountId = Addr.ParentId AND cnt.clv_Client = Addr.ParentId LEFT OUTER JOIN
	//|                                                    ProficreditRU_MSCRM.dbo.AccountExtensionBase AS aeb ON aeb.AccountId = acc.AccountId
	//|                           WHERE        (cnt.statuscode <> 100000011)) AS crmdata ON crmdata.clv_ContractNo = contr.[Contract No_] COLLATE Serbian_Latin_100_CI_AS
	//|                           WHERE not crmdata.FIO is null and  contr.[Contract No_] in ('"+НомерКонтракта+"')";
	Command.CommandText = "USE ProficreditRU_MSCRM;
	|SELECT TOP 1
	|clv_ContractNo,clv_contract_inclusionname AS LinkedContract 
	|,CONVERT(int, cnt.clv_ContractNo) AS ContractNo,cnt.clv_ContractNo
	|,cast (dateadd(hour, 3, cnt.clv_loanstartdate) as date) as ContrDate
	|,cnt.clv_ProductName ProductType
	|,ac.accountnumber accountnumber
	|,cnt.clv_ClientName
	|,isnull(ac.clv_TaxpayerID,'-') as INN
	|,FIRST_VALUE (id.clv_passportseries)  over (partition by id.clv_Account order by id.createdon desc) as passportseries
	|,FIRST_VALUE (id.clv_passportnumber)  over (partition by id.clv_Account order by id.createdon desc) as passportnumber
	|,cast (dateadd(hour, 3, FIRST_VALUE (id.clv_idcardissuedate)  over (partition by id.clv_Account order by id.createdon desc)) as date) as idcardissuedate
	|,FIRST_VALUE (id.clv_issuercode)  over (partition by id.clv_Account order by id.createdon desc) as issuercode
	|,address1_postalcode, clv_address1_regioncode, clv_region1, address1_city, address1_line1, address1_line2, clv_address1_flatnumber
	|,address2_postalcode, clv_address2_regioncode, clv_region2, address2_city, address2_line1, address2_line2, clv_address2_flatnumber
	|,CONCAT(ISNULL(clv_region1 + N' р-н, ', ''),ISNULL(address1_postalcode + ' , ', ''), ISNULL(address1_city, ''), ISNULL(N' , ул. ' + address1_line1, ''), ISNULL(N' , д. ' + address1_line2, ''), ISNULL(N' , кв. ' + clv_address1_flatnumber, '')) Addr	
	|,CONCAT(ISNULL(clv_region2 + N' р-н, ', ''),ISNULL(address2_postalcode + ' , ', ''), ISNULL(address2_city, ''), ISNULL(N' , ул. ' + address2_line1, ''), ISNULL(N' , д. ' + address2_line2, ''), ISNULL(N' , кв. ' + clv_address2_flatnumber, '')) Addr2
	|from clv_contract cnt
	|join Account ac on ac.AccountId=cnt.clv_Client
	|join clv_idcard id on id.clv_Account=ac.AccountId and id.statecode=0
	|where cnt.statuscode in (100000005,100000009,100000010,100000014,100000015,100000016,100000022,808630007,100000003) 
	|and  cnt.clv_ContractNo = '"+НомерКонтракта+"'";
	
	Попытка
		RecordSet = Command.Execute();
		Если RecordSet.EOF() И RecordSet.BOF() Тогда
			Сообщить("По заданным условиям ничего не найдено.");
			Возврат "По заданным условиям ничего не найдено.";
		КонецЕсли;
		RecordSet.MoveFirst();
		Пока НЕ RecordSet.EOF() Цикл
			Если Строка(RecordSet.Fields("clv_ClientName").Value) =  "-" Тогда RecordSet.MoveNext(); Продолжить; КонецЕсли;
			Возврат ЗагрузитьКонтрагента( Прав(Строка(RecordSet.Fields("accountnumber").Value),8)//НомерКонтрагента,
			,Строка(RecordSet.Fields("clv_ContractNo").Value)//НомерДоговора,
			,Строка(RecordSet.Fields("clv_ClientName").Value)//ФИО,
			,Строка(RecordSet.Fields("Addr").Value)//ЮрАдрес,
			,Строка(RecordSet.Fields("INN").Value)//ИНН,
			,RecordSet.Fields("ContrDate").Value
			,RecordSet.Fields("ProductType").Value);//ДатаКонтракта)
			RecordSet.MoveNext(); 
		КонецЦикла;
		RecordSet.Close();
		Connection.Close();	
	Исключение
		Возврат ОписаниеОшибки();
	КонецПопытки; 
КонецФункции

Функция ЗагрузитьКонтрагента(НомерКонтрагента,НомерДоговора,ФИО,ЮрАдрес,ИНН,ДатаКонтракта,ProductType,LinkedContract = Неопределено) Экспорт	 	
	
	СтранаРегистрации = Справочники.СтраныМира.Россия;
	Родитель = Справочники.Контрагенты.НайтиПоКоду("000000096");
	ЮридическоеФизическоеЛицо = Перечисления.ЮридическоеФизическоеЛицо.ФизическоеЛицо; 
	Организация = Справочники.Организации.НайтиПоКоду("000000001");
	//
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	Контрагенты.Ссылка КАК Контрагент,
	|	ДоговорыКонтрагентов.Ссылка КАК Договор,
	|	БНФОДоговорыКредитовИДепозитов.Ссылка КАК Условие
	|ИЗ
	|	Справочник.БНФОДоговорыКредитовИДепозитов КАК БНФОДоговорыКредитовИДепозитов
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Контрагенты КАК Контрагенты
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
	|			ПО Контрагенты.Ссылка = ДоговорыКонтрагентов.Владелец
	|		ПО БНФОДоговорыКредитовИДепозитов.Контрагент = Контрагенты.Ссылка
	|ГДЕ
	|	Контрагенты.АЭ_Идентификатор = &АЭ_Идентификатор
	|	И ДоговорыКонтрагентов.Номер = &Номер
	|	И БНФОДоговорыКредитовИДепозитов.Номер = &Номер";
	
	Запрос.УстановитьПараметр("АЭ_Идентификатор",НомерКонтрагента );
	Запрос.УстановитьПараметр("Номер",НомерДоговора );
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	Стр = Новый Структура;
	Если Выборка.Следующий() Тогда 
		
		ДоговорОбъект = Выборка.Договор.ПолучитьОбъект();
		ДоговорОбъект.Комментарий = НомерКонтрагента+"."+НомерДоговора;
		ДоговорОбъект.Наименование = НомерДоговора;
		ДоговорОбъект.Записать();
		
		ДоговорОбъект = Выборка.Условие.ПолучитьОбъект();
		ДоговорОбъект.Комментарий = НомерКонтрагента+"."+НомерДоговора;
		ДоговорОбъект.Наименование = НомерДоговора;
		ДоговорОбъект.Записать();
		
		КонтрагентОбъект = Выборка.Контрагент.ПолучитьОбъект();
		КонтрагентОбъект.Комментарий = НомерКонтрагента+"."+НомерДоговора;
		КонтрагентОбъект.Записать();
		
		//Стр.Вставить("Контрагент",Выборка.Контрагент);
		//Стр.Вставить("Договор",Выборка.Договор);
		//Стр.Вставить("УсловиеЗайма",Выборка.Условие);
		//Стр.Вставить("_48801",pcru_УМФО.ПолучитьСчетПоАналитике("48801",Выборка.Условие));
		//Стр.Вставить("_48802",pcru_УМФО.ПолучитьСчетПоАналитике("48802",Выборка.Условие));
		//Стр.Вставить("_48803",pcru_УМФО.ПолучитьСчетПоАналитике("48803",Выборка.Условие));
		//Стр.Вставить("_48804",pcru_УМФО.ПолучитьСчетПоАналитике("48804",Выборка.Условие));
		//Стр.Вставить("_48805",pcru_УМФО.ПолучитьСчетПоАналитике("48805",Выборка.Условие));
		//Стр.Вставить("_48806",pcru_УМФО.ПолучитьСчетПоАналитике("48806",Выборка.Условие));
		//Стр.Вставить("_48807",pcru_УМФО.ПолучитьСчетПоАналитике("48807",Выборка.Условие));
		//Стр.Вставить("_48808",pcru_УМФО.ПолучитьСчетПоАналитике("48808",Выборка.Условие));
		//Стр.Вставить("_48809",pcru_УМФО.ПолучитьСчетПоАналитике("48809",Выборка.Условие));
		//Стр.Вставить("_48810",pcru_УМФО.ПолучитьСчетПоАналитике("48810",Выборка.Условие));
		//Стр.Вставить("_60322",pcru_УМФО.ПолучитьСчетПоАналитике("60322",Выборка.Условие));
		//Стр.Вставить("_60323",pcru_УМФО.ПолучитьСчетПоАналитике("60323",Выборка.Условие));
		//Стр.Вставить("_48801_2",pcru_УМФО.ПолучитьСчетПоАналитике("48801",Выборка.Условие,Справочники.БНФОСубконто.НайтиПоКоду("000000024")));
		//Стр.Вставить("_48802_2",pcru_УМФО.ПолучитьСчетПоАналитике("48802",Выборка.Условие,Справочники.БНФОСубконто.НайтиПоКоду("000000024")));
		//Возврат Стр;
	Иначе	
		НачатьТранзакцию();
		Попытка
			УстановитьПривилегированныйРежим(Истина);
			
			КонтрагентСсылка = Справочники.Контрагенты.НайтиПоНаименованию(ФИО);
			Если  ЗначениеЗаполнено(КонтрагентОбъект)  Тогда
			  КонтрагентОбъект = КонтрагентСсылка.ПолучитьОбъект();
			Иначе	
			  КонтрагентОбъект = Справочники.Контрагенты.СоздатьЭлемент();
			КонецЕсли; 
			// Общие данные
			КонтрагентОбъект.ЮридическоеФизическоеЛицо = ЮридическоеФизическоеЛицо;
			КонтрагентОбъект.СтранаРегистрации = СтранаРегистрации;
			КонтрагентОбъект.Родитель = Родитель;
			КонтрагентОбъект.Комментарий = НомерКонтрагента+"."+НомерДоговора; 
			// Данные из файла
			КонтрагентОбъект.АЭ_Идентификатор = НомерКонтрагента;
			КонтрагентОбъект.Наименование = ФИО;
			КонтрагентОбъект.НаименованиеПолное = ФИО;
			
			КонтрагентОбъект.АЭ_ИндивидуальныйПредприниматель = (ProductType="ПРОФИ Бизнес");//(Лев(СокрЛП(ФИО),3) = "ИП "); 
			
			Если ИНН <> "-" Тогда
				//			КонтрагентОбъект.ИНН = ИНН;
			КонецЕсли; 
			// Заполняем адреса
			ВидКИ = Справочники.ВидыКонтактнойИнформации.ЮрАдресКонтрагента;
			ТипКИ = ВидКИ.Тип;
			ОбъектXDTOКИ = УправлениеКонтактнойИнформациейСлужебный.КонтактнаяИнформацияXDTOПоПредставлению(ЮрАдрес, ТипКИ);
			ЗначенияПолей = УправлениеКонтактнойИнформациейСлужебный.КонтактнаяИнформацияXDTOВXML(ОбъектXDTOКИ);
			УправлениеКонтактнойИнформацией.ЗаписатьКонтактнуюИнформацию(КонтрагентОбъект, ЗначенияПолей, ВидКИ, ТипКИ);
			ВидКИ = Справочники.ВидыКонтактнойИнформации.ФактАдресКонтрагента;
			ТипКИ = ВидКИ.Тип;
			ОбъектXDTOКИ = УправлениеКонтактнойИнформациейСлужебный.КонтактнаяИнформацияXDTOПоПредставлению(ЮрАдрес, ТипКИ);
			ЗначенияПолей = УправлениеКонтактнойИнформациейСлужебный.КонтактнаяИнформацияXDTOВXML(ОбъектXDTOКИ);
			УправлениеКонтактнойИнформацией.ЗаписатьКонтактнуюИнформацию(КонтрагентОбъект, ЗначенияПолей, ВидКИ, ТипКИ);
			ВидКИ = Справочники.ВидыКонтактнойИнформации.ПочтовыйАдресКонтрагента;
			ТипКИ = ВидКИ.Тип;
			ОбъектXDTOКИ = УправлениеКонтактнойИнформациейСлужебный.КонтактнаяИнформацияXDTOПоПредставлению(ЮрАдрес, ТипКИ);
			ЗначенияПолей = УправлениеКонтактнойИнформациейСлужебный.КонтактнаяИнформацияXDTOВXML(ОбъектXDTOКИ);
			УправлениеКонтактнойИнформацией.ЗаписатьКонтактнуюИнформацию(КонтрагентОбъект, ЗначенияПолей, ВидКИ, ТипКИ);
			// запись элемента
			КонтрагентОбъект.Записать();
			Контрагент =  КонтрагентОбъект.Ссылка;
			Стр.Вставить("Контрагент",Контрагент);
			
			
			ДоговорСсылка = Справочники.ДоговорыКонтрагентов.НайтиПоНаименованию(НомерДоговора);
			Если ЗначениеЗаполнено(ДоговорСсылка)  Тогда
			    ДоговорОбъект = ДоговорСсылка.ПолучитьОбъект();
			Иначе	
			     ДоговорОбъект = Справочники.ДоговорыКонтрагентов.СоздатьЭлемент();
			КонецЕсли; 
			// Общие данные
			ДоговорОбъект.ВалютаВзаиморасчетов = Справочники.Валюты.НайтиПоКоду("643");
			ДоговорОбъект.ВидДоговора = Перечисления.ВидыДоговоровКонтрагентов.СПокупателем;
			ДоговорОбъект.Организация = Организация; 			
			ДоговорОбъект.БНФОГруппаФинансовогоУчета = Справочники.БНФОГруппыФинансовогоУчетаРасчетов.НайтиПоНаименованию("60322-60323 Расчеты с прочими дебиторами и кредиторами");
			ДоговорОбъект.АЭ_ПодразделениеОрганизации = Справочники.ПодразделенияОрганизаций.НайтиПоНаименованию("2.01.00 FINANCIAL DEPARTMENT/ФИНАНСОВЫЙ ОТДЕЛ");
			// Данные из файла
			ДоговорОбъект.Владелец = Контрагент;
			ДоговорОбъект.Код      = Прав(НомерДоговора,9);
			ДоговорОбъект.Номер    = НомерДоговора;
			//Дата
			ДоговорОбъект.Дата = ДатаКонтракта;
			ДоговорОбъект.Наименование = НомерДоговора;
			ДоговорОбъект.Комментарий = НомерКонтрагента+"."+НомерДоговора;
			//ДатаВыдачи
			//ДоговорОбъект.pcru_ex_ДатаВыдачи = pcru_ex_WSWORKS.ПолучитьДатуПодписания(НомерДоговора);
			// Запись
			ДоговорОбъект.Записать();
			НовДогСС= ДоговорОбъект.Ссылка;
			Стр.Вставить("Договор",НовДогСС);
			//
			НовУслССылка  = Справочники.БНФОДоговорыКредитовИДепозитов.НайтиПоНаименованию(НомерДоговора);
			Если ЗначениеЗаполнено(НовУслССылка)  Тогда
	 			НовУсл = НовУслССылка.ПолучитьОбъект();
			Иначе
    			НовУсл = Справочники.БНФОДоговорыКредитовИДепозитов.СоздатьЭлемент();
			КонецЕсли; 
			НовУсл.Номер = НомерДоговора;
			НовУсл.наименование = НомерДоговора;
			НовУсл.Комментарий  = НомерКонтрагента+"."+НомерДоговора; 
			НовУсл.АЭ_РазделУчета = Перечисления.АЭ_РазделыУчета.ЗаймПредоставленный;
			НовУсл.ФормаОплаты = Перечисления.ФормыОплаты.Безналичная;
			//НовУсл.ГруппаФинансовогоДосрочноеВыбытие = Справочники.БНФОГруппыФинансовогоУчетаФинансовыхИнструментов.НайтиПоНаименованию("");
			//НовУсл.ГруппаФинансовогоУчетаКорректировок  = Справочники.БНФОГруппыФинансовогоУчетаФинансовыхИнструментов.НайтиПоНаименованию("");
			НовУсл.ГруппаФинансовогоУчетаНачисленияПроцентов  = Справочники.БНФОГруппыФинансовогоУчетаФинансовыхИнструментов.НайтиПоНаименованию("Начисленные прочие доходы по займам выданным");
			НовУсл.ГруппаФинансовогоУчетаНачисленияПрочихДоходов = Справочники.БНФОГруппыФинансовогоУчетаФинансовыхИнструментов.НайтиПоНаименованию("Начисленные прочие доходы по займам выданным");
			НовУсл.ГруппаФинансовогоУчетаОсновногоДолга  = Справочники.БНФОГруппыФинансовогоУчетаФинансовыхИнструментов.НайтиПоНаименованию("Начисленные прочие доходы по займам выданным");
			//НовУсл.ГруппаФинансовогоУчетаПогашенияИмуществом = Справочники.БНФОГруппыФинансовогоУчетаФинансовыхИнструментов.НайтиПоНаименованию("");
			НовУсл.ГруппаФинансовогоУчетаРасчетовПоПроцентам = Справочники.БНФОГруппыФинансовогоУчетаФинансовыхИнструментов.НайтиПоНаименованию("Начисленные прочие доходы по займам выданным");
			НовУсл.ГруппаФинансовогоУчетаРасчетовПоПрочимДоходам = Справочники.БНФОГруппыФинансовогоУчетаФинансовыхИнструментов.НайтиПоНаименованию("Начисленные прочие доходы по займам выданным");
			НовУсл.ГруппаФинансовогоУчетаРасчетовПоПрочимРасходам = Справочники.БНФОГруппыФинансовогоУчетаФинансовыхИнструментов.НайтиПоНаименованию("Начисленные прочие доходы по займам выданным");
			//НовУсл.ГруппаФинансовогоУчетаРезервовПодОбесценение = Справочники.БНФОГруппыФинансовогоУчетаФинансовыхИнструментов.НайтиПоНаименованию("");
			НовУсл.АЭ_ПодразделениеОрганизации = Справочники.ПодразделенияОрганизаций.НайтиПоНаименованию("2.01.00 FINANCIAL DEPARTMENT/ФИНАНСОВЫЙ ОТДЕЛ");
			НовУсл.Организация = Организация;
			НовУсл.ТипСрочности = Перечисления.БНФОТипыСрочностиКредитовИДепозитов.Долгосрочный;
			НовУсл.ТипКомиссии = Перечисления.БНФОТипыКомиссииКредитовИДепозитов.Нет;
			НовУсл.Контрагент =  Контрагент;
			НовУсл.ДоговорКонтрагента  = НовДогСС;
			НовУсл.ВалютаВзаиморасчетов =  Справочники.Валюты.НайтиПоКоду("643");	
			НовУсл.ХарактерДоговора = Перечисления.БНФОХарактерДоговораКредитовИДепозитов.ЗаймВыданный;
			НовУсл.Дата = ДатаКонтракта;
			
			ДатаВыплаты = pcru_ex_WSWORKS.ПолучитьДатуПодписания(НомерДоговора);
			Если ДатаВыплаты <> Неопределено Тогда
				НовУсл.ДатаНачала = ДатаВыплаты;
			КонецЕсли;
			НовУсл.Записать();
			НовУсл.pcru_ex_ProductType = ProductType;
			Если ЗначениеЗаполнено(LinkedContract)  Тогда
			   НовУсл.pcru_ex_СвязанныйКонтракт  =  Справочники.БНФОДоговорыКредитовИДепозитов.НайтиПоНаименованию(LinkedContract);
			КонецЕсли; 
			НовУслСС	= НовУсл.Ссылка;
			Стр.Вставить("УсловиеЗайма",НовУслСС);
			ЗафиксироватьТранзакцию();
			УстановитьПривилегированныйРежим(Ложь);	
		Исключение
			Text = ОписаниеОшибки(); 
			ОтменитьТранзакцию();
			УстановитьПривилегированныйРежим(Ложь);	
			ВызватьИсключение  Text;
		КонецПопытки;
	КонецЕсли;
	
	Если ProductType="ПРОФИ Бизнес" Тогда //Лев(СокрЛП(ФИО),3) = "ИП " Тогда
		Возврат pcru_УМФО.ОткрытьСчетаИП(НомерДоговора);
	Иначе	
		Возврат pcru_УМФО.ОткрытьСчетаКонтрагента(НомерДоговора);
	КонецЕсли; 
	
КонецФункции

Процедура РегламентныйОбменКонтрагентами(НомерКонтракта = Неопределено) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
		
	Если НомерКонтракта = Неопределено Тогда
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
		|	БНФОДоговорыКредитовИДепозитов.Номер КАК Номер
		|ПОМЕСТИТЬ ВТ1
		|ИЗ
		|	Справочник.БНФОДоговорыКредитовИДепозитов КАК БНФОДоговорыКредитовИДепозитов
		|ГДЕ
		|	БНФОДоговорыКредитовИДепозитов.Комментарий ПОДОБНО ""%"" + БНФОДоговорыКредитовИДепозитов.Номер
		|
		|УПОРЯДОЧИТЬ ПО
		|	БНФОДоговорыКредитовИДепозитов.Номер УБЫВ
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ ПЕРВЫЕ 1
		|	т1.Номер КАК Номер
		|ИЗ
		|	(ВЫБРАТЬ
		|		pcru_ex_ХранимыеДанные.Данные КАК Номер
		|	ИЗ
		|		РегистрСведений.pcru_ex_ХранимыеДанные КАК pcru_ex_ХранимыеДанные
		|	ГДЕ
		|		pcru_ex_ХранимыеДанные.ИмяХранимыхДанных = ""LastContractCrm""
		|	
		|	ОБЪЕДИНИТЬ ВСЕ
		|	
		|	ВЫБРАТЬ
		|		БНФОДоговорыКредитовИДепозитов.Номер
		|	ИЗ
		|		ВТ1 КАК БНФОДоговорыКредитовИДепозитов) КАК т1";
		Выборка = Запрос.Выполнить().Выбрать();
		Пока Выборка.Следующий() Цикл
			ПоследнийНомерКонтракта = Число(Выборка.Номер)
		КонецЦикла;
	Иначе
		ПоследнийНомерКонтракта = Число(НомерКонтракта);
	КонецЕсли;
	
	СтрокаПодключения = 
	"Provider=MSDASQL.1;
	|UID=1c_test;
	|Pwd=tset_c1;
	|Extended Properties=""DRIVER=SQL Server;
	|SERVER=RUSPBSQL01\CRMRU;
	|APP=1С Reglament Job;
	|DATABASE=PROFICREDIT""";
	//
	Connection  = Новый COMОбъект("ADODB.Connection");
	Command  = Новый COMОбъект("ADODB.Command");
	Command.CommandTimeOut = 300000;
	RecordSet = Новый COMОбъект("ADODB.RecordSet");
	//
	Попытка
		Connection.ConnectionString =СтрокаПодключения;	 
		Connection.Open();
		Command.ActiveConnection   = Connection;
	Исключение
		Возврат;
	КонецПопытки; 
	
	ТекКонтрНомер = "";

	
	Command.CommandText = "USE ProficreditRU_MSCRM;
	|SELECT 
	|clv_ContractNo,clv_contract_inclusionname AS LinkedContract 
	|,CONVERT(int, cnt.clv_ContractNo) AS ContractNo
	|,cast (dateadd(hour, 3, cnt.clv_loanstartdate) as date) as ContrDate
	|,cnt.clv_ProductName ProductType
	|,ac.accountnumber accountnumber
	|,cnt.clv_ClientName
	|,isnull(ac.clv_TaxpayerID,'-') as INN
	|,FIRST_VALUE (id.clv_passportseries)  over (partition by id.clv_Account order by id.createdon desc) as passportseries
	|,FIRST_VALUE (id.clv_passportnumber)  over (partition by id.clv_Account order by id.createdon desc) as passportnumber
	|,cast (dateadd(hour, 3, FIRST_VALUE (id.clv_idcardissuedate)  over (partition by id.clv_Account order by id.createdon desc)) as date) as idcardissuedate
	|,FIRST_VALUE (id.clv_issuercode)  over (partition by id.clv_Account order by id.createdon desc) as issuercode
	|,address1_postalcode, clv_address1_regioncode, clv_region1, address1_city, address1_line1, address1_line2, clv_address1_flatnumber
	|,address2_postalcode, clv_address2_regioncode, clv_region2, address2_city, address2_line1, address2_line2, clv_address2_flatnumber
	|,CONCAT(ISNULL(clv_region1 + N' р-н, ', ''),ISNULL(address1_postalcode + ' , ', ''), ISNULL(address1_city, ''), ISNULL(N' , ул. ' + address1_line1, ''), ISNULL(N' , д. ' + address1_line2, ''), ISNULL(N' , кв. ' + clv_address1_flatnumber, '')) Addr	
	|,CONCAT(ISNULL(clv_region2 + N' р-н, ', ''),ISNULL(address2_postalcode + ' , ', ''), ISNULL(address2_city, ''), ISNULL(N' , ул. ' + address2_line1, ''), ISNULL(N' , д. ' + address2_line2, ''), ISNULL(N' , кв. ' + clv_address2_flatnumber, '')) Addr2
	|from clv_contract cnt
	|join Account ac on ac.AccountId=cnt.clv_Client
	|join clv_idcard id on id.clv_Account=ac.AccountId and id.statecode=0
	|where cnt.statuscode in (100000005,100000009,100000010,100000014,100000015,100000016,100000022,808630007,100000003) 
	|and  CONVERT(int, cnt.clv_ContractNo) > "+Формат(ПоследнийНомерКонтракта, "ЧЦ=20; ЧГ=0") +"";
	Попытка                                                                                                                            
		RecordSet = Command.Execute();
		Если RecordSet.EOF() И RecordSet.BOF() Тогда
			Сообщить("По заданным условиям ничего не найдено.");
			Возврат;
		КонецЕсли;
		RecordSet.MoveFirst();
		ТекКонтрНомер = "";
		Пока НЕ RecordSet.EOF() Цикл
			Если Строка(RecordSet.Fields("clv_ClientName").Value) =  "-" Тогда RecordSet.MoveNext(); Продолжить; КонецЕсли;
			ТекКонтрНомер = Строка(RecordSet.Fields("clv_ContractNo").Value);
			 ЗагрузитьКонтрагента( Прав(Строка(RecordSet.Fields("accountnumber").Value),8)//НомерКонтрагента,
			,Строка(RecordSet.Fields("clv_ContractNo").Value)//НомерДоговора,
			,Строка(RecordSet.Fields("clv_ClientName").Value)//ФИО,
			,Строка(RecordSet.Fields("Addr").Value)//ЮрАдрес,
			,Строка(RecordSet.Fields("INN").Value)//ИНН,
			,RecordSet.Fields("ContrDate").Value
			,RecordSet.Fields("ProductType").Value
			,RecordSet.Fields("LinkedContract").Value);//ДатаКонтракта)
			RecordSet.MoveNext(); 
		КонецЦикла;
		RecordSet.Close();
		Connection.Close();	
		
		Если НомерКонтракта = Неопределено Тогда
			МЗ = РегистрыСведений.pcru_ex_ХранимыеДанные.СоздатьМенеджерЗаписи();
			МЗ.ИмяХранимыхДанных = "LastContractCrm";
			МЗ.Данные = ТекКонтрНомер;
			МЗ.Записать(Истина);
		КонецЕсли;
	Исключение
		
	КонецПопытки; 
	
КонецПроцедуры

