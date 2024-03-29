﻿&НаКлиенте
Перем КэшДолжности;

#Область ПЕРМЕННЫЕ_ПЛАТФОРМЫ

&НаКлиенте
Перем Платформа Экспорт;

&НаСервере
Перем ОбработкаОбъект;

#КонецОбласти

#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ПЛАТФОРМЫ

&НаКлиенте
Функция МетодКлиента(ИмяМодуля= "", ИмяМетода, 
		Параметр0= NULL, Параметр1= NULL, Параметр2= NULL, Параметр3= NULL, Параметр4= NULL,
		Параметр5= NULL, Параметр6= NULL, Параметр7= NULL, Параметр8= NULL, Параметр9= NULL) Экспорт
	
	Возврат  Платформа.МетодКлиента(ИмяМодуля, ИмяМетода, 
	Параметр0, Параметр1, Параметр2, Параметр3, Параметр4,
	Параметр5, Параметр6, Параметр7, Параметр8, Параметр9);
	
КонецФункции

&НаКлиенте
Функция МетодСервераБезКонтекста(ИмяМодуля= "", ИмяМетода,
		Параметр0= NULL, Параметр1= NULL, Параметр2= NULL, Параметр3= NULL, Параметр4= NULL, 
		Параметр5= NULL, Параметр6= NULL, Параметр7= NULL, Параметр8= NULL, Параметр9= NULL) Экспорт
	
	Возврат Платформа.МетодСервераБезКонтекста(ИмяМодуля, ИмяМетода,
	Параметр0, Параметр1, Параметр2, Параметр3, Параметр4,
	Параметр5, Параметр6, Параметр7, Параметр8, Параметр9);
	
КонецФункции

&НаСервере
Функция МетодСервера(Знач ИмяМодуля= "", Знач ИмяМетода,
		Параметр0= NULL, Параметр1= NULL, Параметр2= NULL, Параметр3= NULL, Параметр4= NULL, 
		Параметр5= NULL, Параметр6= NULL, Параметр7= NULL, Параметр8= NULL, Параметр9= NULL) Экспорт
	
	Возврат ОбработкаОбъект().МетодСервера(ИмяМодуля, ИмяМетода, 
	Параметр0, Параметр1, Параметр2, Параметр3, Параметр4,
	Параметр5, Параметр6, Параметр7, Параметр8, Параметр9);
	
КонецФункции

&НаСервере
Функция ОбработкаОбъект() Экспорт
	
	Если ОбработкаОбъект = Неопределено Тогда
		
		СтруктураОбработки= ПолучитьИзВременногоХранилища(Объект.ПараметрыКлиентСервер.ВременноеХранилище.АдресОбработкаОбъект);
		
		Если СтруктураОбработки <> Неопределено Тогда
			ОбработкаОбъект= СтруктураОбработки.ОбработкаОбъект;
		КонецЕсли;
		
		Если ОбработкаОбъект = Неопределено Тогда
			
			ОбработкаОбъект= РеквизитФормыВЗначение("Объект");
			
			Попытка
				ПоместитьВоВременноеХранилище(Новый Структура("ОбработкаОбъект", ОбработкаОбъект), Объект.ПараметрыКлиентСервер.ВременноеХранилище.АдресОбработкаОбъект);
			Исключение КонецПопытки;
		
		Иначе
			ОбработкаОбъект.ПараметрыКлиентСервер= Объект.ПараметрыКлиентСервер;
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат ОбработкаОбъект;
	
КонецФункции

&НаКлиенте
Функция ОсновнаяФорма(ТекущийВладелецФормы)
	
	Если ТекущийВладелецФормы = Неопределено Тогда
		Возврат Неопределено
	ИначеЕсли Прав(ТекущийВладелецФормы.ИмяФормы, 14) = "Форма_Основная" Тогда
		Возврат ТекущийВладелецФормы;
	Иначе
		Возврат ОсновнаяФорма(ТекущийВладелецФормы.ВладелецФормы);
	КонецЕсли;
	
КонецФункции


&НаСервере
Процедура ПлатформаПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Свойство("ОбъектПараметрыКлиентСервер", Объект.ПараметрыКлиентСервер);
	
КонецПроцедуры

&НаКлиенте
Процедура ПлатформаПриОткрытии(Отказ)
	
	ОсновнаяФорма= ОсновнаяФорма(ВладелецФормы);
	
	Если ОсновнаяФорма <> Неопределено Тогда
		Платформа= ОсновнаяФорма.Платформа;
	КонецЕсли;
		
	Платформа.ПриОткрытииФормыОбработки(ЭтаФорма, Отказ);
	
КонецПроцедуры

&НаКлиенте
Процедура ПлатформаПриЗакрытии()
	
	Платформа.ПриЗакрытииФормыОбработки(ЭтаФорма);
	
КонецПроцедуры

#КонецОбласти

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ПлатформаПриСозданииНаСервере(Отказ, СтандартнаяОбработка);
	
	ResolutionRequestType = Параметры.ResolutionRequestType;
	Организация			  = Параметры.Организация;
	
	Форма_УстановитьЗаголовок();
	НадписьНетПолучателей_УстановитьЗаголовок();
	
	Подписант_УстановитьВидимость();
	Подписант_ЗаполнитьЗначениемПоУмолчанию();
	
	DepartmentID = ПустойИдентификатор();
	Подразделение = "Головное подразделение";
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ПлатформаПриОткрытии(Отказ);
	
	ДанныеОрганизации = МетодКлиента("Модуль_РаботаССерверомДиадок", "ДанныеКонтекстаДиадок", Организация, "ДанныеОрганизации");
	
	Если Не ДанныеОрганизации = Неопределено Тогда 
		НаименованиеОрганизации = ДанныеОрганизации.Name;
	Иначе 
		НаименованиеОрганизации = "<Нет данных>";
		ЭлементФормы = Элементы.Организация;
		ЭлементФормы.ОтображениеПодсказки = ОтображениеПодсказки.Кнопка;
		ЭлементФормы.Подсказка = "Проверьте настройки сопоставления ящиков Диадок и организаций 1С";
		ЭлементФормы.ЦветТекста = WebЦвета.Красный;
	КонецЕсли;
	
	УправлениеФормой();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	ПлатформаПриЗакрытии();
	
КонецПроцедуры

//{ ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

	&НаКлиенте
	Процедура ПодразделениеНажатие(Элемент, СтандартнаяОбработка)
		
		СтандартнаяОбработка = Ложь;
				
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("DepartmentId"	, DepartmentID);
		ПараметрыФормы.Вставить("OrganizationId", МетодКлиента("Модуль_РаботаССерверомДиадок", "ДанныеКонтекстаДиадок", Организация, "BoxId"));
		
		МетодКлиента(, "ОткрытьФормуОбработкиМодально", "ВыборПодразделенияОрганизации", ПараметрыФормы, ЭтаФорма, "ОбработчикОткрытиеФормыВыбораПодразделенияОрганизации");

	КонецПроцедуры
		
	&НаКлиенте
	Процедура ПолучательПриИзменении(Элемент)
		
		ДолжностьПолучателя = КэшДолжности[Получатель];
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ПодписантПриИзменении(Элемент)
		
		ДолжностьПодписанта = КэшДолжности[Подписант];
		
	КонецПроцедуры
	
//} ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ


//{ ВСПОМОГАТЕЛЬНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаКлиентеНаСервереБезКонтекста
Функция ПустойИдентификатор()
	
	Возврат "00000000-0000-0000-0000-000000000000";
	
КонецФункции

	&НаСервере
	Процедура Подписант_УстановитьВидимость()
		
		НоваяВидимость = ResolutionRequestType = "ApprovementRequest";
		
		ОбновитьСвойствоЭлементаФормы(Элементы.ГруппаПодписант, "Видимость", НоваяВидимость);
		
	КонецПроцедуры
	
	&НаСервере
	Процедура Подписант_ЗаполнитьЗначениемПоУмолчанию()
		
		Если ResolutionRequestType = "ApprovementRequest" Тогда
			
			НастройкиПодписанта = МетодСервера(,"ПолучитьНастройкиПодписантаСогласование");
			
			Подписант			= НастройкиПодписанта.ИдентификаторКонечногоПодписанта;
			ДолжностьПодписанта = НастройкиПодписанта.ДолжностьКонечногоПодписанта;
			
		КонецЕсли;
		
	КонецПроцедуры
	
	&НаСервере
	Процедура Форма_УстановитьЗаголовок()
		
		НовыйЗаголовок = "Передача на " + ?(ResolutionRequestType = "ApprovementRequest", "согласование", "подписание");
		
		ОбновитьСвойствоЭлементаФормы(ЭтаФорма, "Заголовок", НовыйЗаголовок);
		
	КонецПроцедуры
	
	&НаСервере
	Процедура НадписьНетПолучателей_УстановитьЗаголовок()
		
		НовыйЗаголовок = "В подразделении нет сотрудников с правом " + ?(ResolutionRequestType = "ApprovementRequest", "согласования", "подписи");
		
		ОбновитьСвойствоЭлементаФормы(Элементы.НадписьНетПолучателей, "Заголовок", НовыйЗаголовок);
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура УправлениеФормой()
		
		ПолучательПодписант_ЗаполнитьСписокВыбора();
		
		Получатель_СкрытьПоказать();
			
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ПолучательПодписант_ЗаполнитьСписокВыбора()
		
		КэшДолжности = Новый Соответствие;
		
		Элементы.Получатель.СписокВыбора.Очистить();
		Элементы.Подписант.СписокВыбора.Очистить();
		
		Box = МетодКлиента("Модуль_РаботаССерверомДиадок", "ДанныеКонтекстаДиадок", Организация, "Box");
		
		Если Box = Неопределено Тогда 
			ВГраница = -1;
		Иначе 
			OrganizationUsers = Box.GetUsers();
			ВГраница = OrganizationUsers.Count - 1;
		КонецЕсли;
		
		Для Сч = 0 По ВГраница Цикл
			
			User = OrganizationUsers.GetItem(Сч);
			
			МожетПодписать 	 = User.Permissions.CanSignDocuments;
			МожетСогласовать = User.Permissions.CanAddResolutions;
			ДостаточноПрав	 = Ложь;
			
			Если МожетПодписать ИЛИ (МожетСогласовать И ResolutionRequestType = "ApprovementRequest") Тогда
				
				Если ЗначениеЗаполнено(DepartmentId) И DepartmentID <> ПустойИдентификатор() Тогда
					
					Если User.Permissions.UserDepartment <> Неопределено И User.Permissions.UserDepartment.Id = DepartmentId Тогда
						ДостаточноПрав = Истина;
					КонецЕсли;
					
					Если Не ДостаточноПрав Тогда
						
						SelectedDepartments = User.Permissions.SelectedDepartments;
						
						ВГраница1 = SelectedDepartments.Count - 1;
						Для Сч1 = 0 По ВГраница1 Цикл
							Если SelectedDepartments.GetItem(Сч1).Id = DepartmentId Тогда
								ДостаточноПрав = Истина;
								Прервать;
							КонецЕсли;
						КонецЦикла;
						
					КонецЕсли;
					
				Иначе
					ДостаточноПрав = Истина;
				КонецЕсли;
				
			КонецЕсли;
			
			Если ДостаточноПрав
				И ((МожетСогласовать И ResolutionRequestType = "ApprovementRequest")
					ИЛИ (МожетПодписать И ResolutionRequestType = "SignatureRequest")) Тогда
				
				Элементы.Получатель.СписокВыбора.Добавить(User.Id, User.Name);
				КэшДолжности.Вставить(User.Id, User.Position);
				
			КонецЕсли;
			
			Если ДостаточноПрав И МожетПодписать И ResolutionRequestType = "ApprovementRequest" Тогда
				
				Элементы.Подписант.СписокВыбора.Добавить(User.Id, User.Name);
				КэшДолжности.Вставить(User.Id, User.Position);
				
			КонецЕсли;
			
		КонецЦикла;
		
		Элементы.Получатель.СписокВыбора.СортироватьПоПредставлению();
		Элементы.Подписант.СписокВыбора.СортироватьПоПредставлению();
		
		ЛюбойПолучатель = "Любой с правом согласования";
		Если ResolutionRequestType = "SignatureRequest" Тогда
			ЛюбойПолучатель = "Любой с правом подписи";
		КонецЕсли;
		
		Элементы.Получатель.СписокВыбора.Вставить(0, "", ЛюбойПолучатель);
		Элементы.Подписант.СписокВыбора.Вставить(0, "", "Любой с правом подписи");
		
		КэшДолжности.Вставить("", "");
		
		Если ЗначениеЗаполнено(Получатель) Тогда
			Если Элементы.Получатель.СписокВыбора.НайтиПоЗначению(Получатель) = Неопределено Тогда
				Получатель			= Неопределено;
				ДолжностьПолучателя = Неопределено;
			Иначе
				ДолжностьПолучателя = КэшДолжности[Получатель];
			КонецЕсли;
		КонецЕсли; 
		
		Если ЗначениеЗаполнено(Подписант) Тогда
			Если Элементы.Подписант.СписокВыбора.НайтиПоЗначению(Подписант) = Неопределено Тогда
				Подписант			= Неопределено;
				ДолжностьПодписанта = Неопределено;
			Иначе
				ДолжностьПодписанта = КэшДолжности[Подписант];
			КонецЕсли;
		КонецЕсли; 
	
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ОбработчикОткрытиеФормыВыбораПодразделенияОрганизации(РезультатЗакрытия, ДополнительныеПараметры) Экспорт
		
		Если РезультатЗакрытия <> Неопределено И РезультатЗакрытия.DepartmentID <> DepartmentID Тогда 
			
			DepartmentID = РезультатЗакрытия.DepartmentID;
			Подразделение = РезультатЗакрытия.DepartmentName;
			УправлениеФормой();
			
		КонецЕсли;
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура Получатель_СкрытьПоказать()
		
		ПолучательВидимость = ЗначениеЗаполнено(Элементы.Получатель.СписокВыбора);
		
		ОбновитьСвойствоЭлементаФормы(Элементы.Получатель		    , "Видимость", ПолучательВидимость);
		ОбновитьСвойствоЭлементаФормы(Элементы.ДолжностьПолучателя	, "Видимость", ПолучательВидимость);
		ОбновитьСвойствоЭлементаФормы(Элементы.НадписьНетПолучателей, "Видимость", НЕ ПолучательВидимость);
			
	КонецПроцедуры
	
	&НаКлиентеНаСервереБезКонтекста
	Процедура ОбновитьСвойствоЭлементаФормы(Элемент, СвойствоЭлемента, ЗначениеСвойства)
		
		Если Элемент[СвойствоЭлемента] <> ЗначениеСвойства Тогда
			Элемент[СвойствоЭлемента] = ЗначениеСвойства;
		КонецЕсли;
		
	КонецПроцедуры
	
//} ВСПОМОГАТЕЛЬНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

//{ КОМАНДЫ

	&НаКлиенте
	Процедура Сформировать(Команда)
		
		ФИОПолучателя = "";
		Если ЗначениеЗаполнено(Получатель) Тогда
			ЭлементСписка = Элементы.Получатель.СписокВыбора.НайтиПоЗначению(Получатель);
			Если ЭлементСписка <> Неопределено Тогда
				ФИОПолучателя = ЭлементСписка.Представление;
			КонецЕсли;
		КонецЕсли; 
		
		ПараметрыПолучателя = Новый Структура;
		ПараметрыПолучателя.Вставить("Организация"			, Организация);
		ПараметрыПолучателя.Вставить("ResolutionRequestType", ResolutionRequestType);
		ПараметрыПолучателя.Вставить("TargetDepartmentId"	, DepartmentId);
		ПараметрыПолучателя.Вставить("TargetUserId"			, Получатель);
		ПараметрыПолучателя.Вставить("Комментарий"			, Комментарий);
		ПараметрыПолучателя.Вставить("ФИОПолучателя"		, ФИОПолучателя);
		ПараметрыПолучателя.Вставить("ДолжностьПолучателя"	, ДолжностьПолучателя);
		
		ФИОПодписанта = "";
		Если ЗначениеЗаполнено(Подписант) Тогда
			ЭлементСписка = Элементы.Подписант.СписокВыбора.НайтиПоЗначению(Подписант);
			Если ЭлементСписка <> Неопределено Тогда
				ФИОПодписанта = ЭлементСписка.Представление;
				МетодСервераБезКонтекста(,"УстановитьНастройкиПодписантаСогласование", Подписант, ДолжностьПодписанта);
			КонецЕсли;
		КонецЕсли; 
		
		ПараметрыПолучателя.Вставить("ФИОПодписанта"	  , ФИОПодписанта);
		ПараметрыПолучателя.Вставить("ДолжностьПодписанта", ДолжностьПодписанта);
		
		ЭтоТекущийПользователь = Получатель = МетодКлиента("Модуль_РаботаССерверомДиадок", "ДанныеКонтекстаДиадок", Организация, "ДанныеСотрудника").Id;
		ПараметрыПолучателя.Вставить("ЭтоТекущийПользователь", ЭтоТекущийПользователь);
		
		Закрыть(ПараметрыПолучателя);

	КонецПроцедуры

//} КОМАНДЫ