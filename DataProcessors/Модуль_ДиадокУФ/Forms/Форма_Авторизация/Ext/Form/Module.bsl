﻿
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
	
	Параметры.Свойство("Организация", Организация);
	
	Режим= Параметры.Режим;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ПлатформаПриОткрытии(Отказ);

	ЭтаФорма.Заголовок = "Авторизация в " + Платформа.ПараметрыКлиент.СловарьWL.КраткоеНаименованиеСистемыПредложныйПадеж;
	
	Элементы.ТаблицаСертификатовИздатель.Видимость 	= Ложь;
	Элементы.ТаблицаСертификатовВДиадоке.Видимость 	= Ложь;
	Элементы.ТаблицаСертификатовОшибка.Видимость 	= Ложь;
	
	Элементы.ТаблицаСертификатовОтпечатокСертификата.Видимость = Ложь;
	
	ЗаполнитьДанные();
	
	ОбновитьПредставлениеПоРежиму();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	ПлатформаПриЗакрытии();
	
КонецПроцедуры

&НаКлиенте
Процедура УправлениеВидимостью()
	
	Если Режим = "АвторизацияПоЛогину" Тогда
		Элементы.Комментарий.Видимость=	Ложь;
	Иначе
		Элементы.Комментарий.Видимость=	Истина;
	КонецЕсли;
	
КонецПроцедуры


&НаКлиенте
Процедура ВойтиВСистему(Команда)
	ВыбратьНажатие();
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьНажатие()
	
	DiadocConnectin = Неопределено;

	Интерпретация= "";
	
	ПредставлениеПользователя = "Неизвестный пользователь";
	Если Режим = "АвторизацияПоСертификату" Тогда
		
		ТекДанные = Элементы.ТаблицаСертификатов.ТекущиеДанные;
		
		Если ТекДанные = Неопределено ИЛИ НЕ ТекДанные.ВДиадоке  Тогда
			
			Если ТекДанные <> Неопределено И ТекДанные.НетДоступаКОрганизациям Тогда
				ТекстПредупреждения = "Сертификат %1 не имеет доступа в Диадок. Попробуйте авторизоваться под ним в веб-версии, следуя подсказкам сервиса. 
				|
				|Если авторизация в веб-версии не помогла, обратитесь в техподдержку.";
				
				ТекстПредупреждения = СтрШаблон(ТекстПредупреждения, ТекДанные.Наименование);
			Иначе
				ТекстПредупреждения = "Данный сертификат не имеет доступа в %1, выберите другой действующий сертификат";
				ТекстПредупреждения = СтрШаблон(ТекстПредупреждения, Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы);
			КонецЕсли;
			
			ПоказатьПредупреждение(, ТекстПредупреждения, 120, Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы);
			Возврат;
		КонецЕсли;
		
		текСертификат = ТекДанные.ОтпечатокСертификата;
		Попытка
			DiadocConnection = Платформа.ПараметрыКлиент.КонтекстРаботаССерверомДиадок.DiadocInvoiceAPI.CreateConnectionByCertificate(текСертификат);
			ПредставлениеПользователя = ТекДанные.Наименование;
		Исключение
			ПоказатьОшибкуПоСпецификатору(ОписаниеОшибки());
			ЭтаФорма.ТекущийЭлемент = Элементы.ТаблицаСертификатов;
		КонецПопытки;
		
	Иначе
		
		Логин =	СокрЛП(Логин);
		
		Если ПустаяСтрока(Логин) Тогда
			ПоказатьПредупреждение(, "Заполните логин", 120, Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы);
			ЭтаФорма.ТекущийЭлемент = Элементы.Логин;
			Возврат;
		КонецЕсли;
		
		Если ПустаяСтрока(Пароль) Тогда
			ПоказатьПредупреждение(, "Заполните пароль", 120, Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы);
			ЭтаФорма.ТекущийЭлемент = Элементы.Пароль;
			Возврат;
		КонецЕсли;
		
		текСертификат = "login:" + Логин;
		Попытка
			DiadocConnection = Платформа.ПараметрыКлиент.КонтекстРаботаССерверомДиадок.DiadocInvoiceAPI.CreateConnectionByLogin(Логин, Пароль);
			ПредставлениеПользователя = Логин;
		Исключение
			текстОшибки = ОписаниеОшибки();

			Спецификатор = ПоказатьОшибкуПоСпецификатору(текстОшибки);
			Если Спецификатор = "AuthorizationBadLogin" Тогда
				ЭтаФорма.ТекущийЭлемент = Элементы.Логин;
			ИначеЕсли Спецификатор = "AuthorizationBadPassword" Тогда
				ЭтаФорма.ТекущийЭлемент = Элементы.Пароль;
			КонецЕсли;
					
		КонецПопытки;
		
	КонецЕсли;
	
	Если DiadocConnection <> Неопределено Тогда
		
		Если ЗначениеЗаполнено(Организация) И НЕ МетодКлиента("Модуль_РаботаССерверомДиадок","ПроверитьДоступКОрганизации", DiadocConnection, Организация) Тогда
			ПоказатьПредупреждение(, "Под данной учетной записью в " + Платформа.ПараметрыКлиент.СловарьWL.КраткоеНаименованиеСистемыПредложныйПадеж + " нет доступа к организации """ + Организация + """", 120, Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы);
			Возврат;
		КонецЕсли;
		
		СтруктураНастроек = Новый Структура;
		СтруктураНастроек.Вставить("ДиадокПоследнийСертификатПользователя"	 , текСертификат);
		СтруктураНастроек.Вставить("ДиадокПоследнееПредставлениеПользователя", ПредставлениеПользователя);
		МетодСервераБезКонтекста(,"УстановитьНастройкиПользователей"		 , СтруктураНастроек);
		
		Закрыть(Новый Структура("DiadocConnection, ПредставлениеПользователя", DiadocConnection, ПредставлениеПользователя));
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПереключениеРежимаВходаНажатие(Элемент, СтандартнаяОбработка)
	Режим = ? (Режим ="АвторизацияПоСертификату", "АвторизацияПоЛогину",  "АвторизацияПоСертификату");
	УправлениеВидимостью();
	ОбновитьПредставлениеПоРежиму();
	СтандартнаяОбработка = ложь;
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаСертификатовВыбор(Элемент, ВыбраннаяСтрока, Колонка, СтандартнаяОбработка)
	ВыбратьНажатие();
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаСертификатовПриАктивизацииСтроки(Элемент)
	
	Если НЕ Элементы.ТаблицаСертификатов.ТекущиеДанные = Неопределено Тогда
		Если НЕ Элементы.ТаблицаСертификатов.ТекущиеДанные.ВДиадоке Тогда
			//Комментарий = Элементы.ТаблицаСертификатов.ТекущиеДанные.Ошибка;
			//ЗаписатьЗначениеРеквизитаФормы(Элементы.ТаблицаСертификатов.ТекущиеДанные.Ошибка,"Комментарий");
			Комментарий =Элементы.ТаблицаСертификатов.ТекущиеДанные.Ошибка;
		Иначе
			Комментарий = "";
			//ЗаписатьЗначениеРеквизитаФормы(Элементы.ТаблицаСертификатов.ТекущиеДанные.Ошибка,"");
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаСертификатовПередУдалением(Элемент, Отказ)
	Отказ = истина;
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаСертификатовПередНачаломИзменения(Элемент, Отказ)
	Отказ = истина;
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаСертификатовПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	Отказ=	Истина;
КонецПроцедуры

&НаКлиенте
Процедура Декорация_НетСертификатаНажатие(Элемент)
	
	HTMLТекст = HTMLТекст_НетНужногоСертификата();
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ЗаголовокФормы", НСтр("ru = 'Авторизация по сертификату'"));
	ПараметрыФормы.Вставить("HTMLДокумент"	, HTMLТекст);
	
	МетодКлиента( , "ОткрытьФормуОбработкиМодально", "ФормаВыводаHTMLДокумента", ПараметрыФормы, ЭтаФорма);
	
КонецПроцедуры //Декорация_НетСертификатаНажатие()

&НаКлиенте
Процедура Декорация_ЗабылиПарольНажатие(Элемент)
	
	АдресаИнтернетРесурсов = МетодКлиента("Модуль_Клиент", "АдресаИнтернетРесурсов");
	
	ПерейтиПоНавигационнойСсылке(АдресаИнтернетРесурсов.СтраницаСменыПароля);
	
КонецПроцедуры


&НаКлиенте
Функция ПоказатьОшибкуПоСпецификатору(текстОшибки)
	
	СтруктураОшибки= МетодСервераБезКонтекста(,"ПолучитьСтруктуруОшибкиВнешнейКомпоненты", ТекстОшибки);
	
	Спецификатор= СтруктураОшибки.Спецификатор;
	
	Если Спецификатор = "InternetError" Тогда
		ОткрытьФормуВыводаОшибкиИнтернет();
	Иначе
		ОткрытьФормуВыводаОшибки(СтруктураОшибки);
	КонецЕсли;
	
	Возврат Спецификатор
	
КонецФункции

&НаКлиенте
Процедура ЗаполнитьДанные()

	Попытка
		
		МетодКлиента("Модуль_Клиент", "ПоказатьСостояниеОбработки", НСтр("ru = 'Получение списка сертификатов'"));
		
		Certificates = Платформа.ПараметрыКлиент.КонтекстРаботаССерверомДиадок.DiadocInvoiceAPI.GetPersonalCertificates();
		Для Индекс = 0 По Certificates.Count - 1 Цикл
			
			PersonalCertificate = Certificates.GetItem(Индекс);
			
			НоваяСтрока = ТаблицаСертификатов.Добавить();
			
			НоваяСтрока.Наименование 	= PersonalCertificate.Name;
			НоваяСтрока.СрокДействия	= PersonalCertificate.EndDate;
			НоваяСтрока.Организация 	= PersonalCertificate.OrganizationName;
			
			НоваяСтрока.ДатаВыдачи	= PersonalCertificate.BeginDate;
			НоваяСтрока.Издатель 	= PersonalCertificate.IssuerName;
			
			НоваяСтрока.ИНН	= PersonalCertificate.INN;
			НоваяСтрока.КПП = PersonalCertificate.Kpp;
			
			НоваяСтрока.ОтпечатокСертификата = PersonalCertificate.Thumbprint;
			
			Если НоваяСтрока.СрокДействия < НачалоДня(ТекущаяДата()) Тогда
				НоваяСтрока.Ошибка	 = "Срок действия сертификата истек";
				НоваяСтрока.ВДиадоке = Ложь;
			Иначе
				НоваяСтрока.ВДиадоке = Истина;
			КонецЕсли;
			
		КонецЦикла;
		
	Исключение
		
		Результат =	Новый Структура();
		Результат.Вставить("ОписаниеОшибки",	"Ошибка работы внешней компоненты");
		Результат.Вставить("Подробности", 		ОписаниеОшибки());
		
		ОткрытьФормуВыводаОшибки(Результат);
		
		Возврат;
		
	КонецПопытки;
	
	Попытка
		
		Для Каждого стр Из ТаблицаСертификатов Цикл
			
			Если Стр.ВДиадоке Тогда
				
				Если НЕ Платформа.ПараметрыКлиент.КонтекстРаботаССерверомДиадок.DiadocInvoiceAPI.VerifyThatUserHasAccessToAnyBox(стр.ОтпечатокСертификата) Тогда
					Стр.Ошибка = "По сертификату нет доступа в " + Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы;
					Стр.ВДиадоке				 = Ложь; 
					Стр.НетДоступаКорганизациям	 = Истина; 
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЦикла;
		
	Исключение
		ПоказатьОшибкуПоСпецификатору(ОписаниеОшибки());
	КонецПопытки;
	
	ТаблицаСертификатов.Сортировать("ВДиадоке Убыв, Наименование Возр, ДатаВыдачи Убыв");
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьПредставлениеПоРежиму()
	
	Если ПолучитьЗначениеРеквизитаФормы("Режим") = "АвторизацияПоСертификату" Тогда
		Элементы.РежимыАвторизации.ТекущаяСтраница = Элементы.СтраницаВходПоСертификату;
		ЗаписатьЗначениеРеквизитаФормы("Войти по логину и паролю", "ПереключениеРежимаВхода");
	Иначе
		Элементы.РежимыАвторизации.ТекущаяСтраница = Элементы.СтраницаВходПоЛогину;
		ЗаписатьЗначениеРеквизитаФормы("Войти по сертификату", "ПереключениеРежимаВхода");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуВыводаОшибкиИнтернет()
	
	МетодКлиента(,"ОткрытьФормуОбработкиМодально", "Форма_ВыводОшибкиИнтернет");
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуВыводаОшибки(Результат)
	
	ПараметрыФормы=	Новый Структура();
	ПараметрыФормы.Вставить("Заголовок", 		"Ошибка работы с модулем " + Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы);
	ПараметрыФормы.Вставить("ОписаниеОшибки", 	Результат.ОписаниеОшибки);
	ПараметрыФормы.Вставить("Подробности", 		Результат.Подробности);
	
	МетодКлиента(,"ОткрытьФормуОбработкиМодально", "Форма_ВыводОшибки", ПараметрыФормы, ЭтаФорма);
	
КонецПроцедуры

&НаСервере
Функция ПолучитьЗначениеРеквизитаФормы(ИмяРеквизита)
	мас = Новый Массив;
	мас.Добавить(Тип("ТаблицаЗначений"));
	мас.Добавить(Тип("ДеревоЗначений"));
		
	ТипРеквизита =ТипЗнч(ЭтаФорма[ИмяРеквизита]); 
	Если (Мас.Найти(ТипРеквизита) <> Неопределено) Или (Найти(ВРЕГ(ТипРеквизита), "ОБЪЕКТ") <> 0) тогда
		Возврат РеквизитФормыВЗначение(ИмяРеквизита);
	Иначе
		Возврат ЭтаФорма[ИмяРеквизита];
	конецесли;
КонецФункции

&НаСервере
Функция ЗаписатьЗначениеРеквизитаФормы(Значение,ИмяРеквизита)

	мас = Новый Массив;
	мас.Добавить(Тип("ТаблицаЗначений"));
	мас.Добавить(Тип("ДеревоЗначений"));
	
	
	ТипРеквизита =ТипЗнч(ЭтаФорма[ИмяРеквизита]); 
	Если (Мас.Найти(ТипРеквизита) <> Неопределено) Или (Найти(ВРЕГ(ТипРеквизита), "ОБЪЕКТ") <> 0) тогда
		ЗначениеВРеквизитФормы(Значение,ИмяРеквизита);
	Иначе
		ЭтаФорма[ИмяРеквизита] = Значение;
		
	конецесли;
	
	Возврат Истина;
КонецФункции

// Готовит текст в разметке HTML для информирования пользователя о дальнейших действиях
// в случае, если возникли проблемы авторизации по сертификату
//
// Возвращаемое значение:
//	Строка
&НаКлиенте
Функция HTMLТекст_НетНужногоСертификата()
	
	АдресаИнтернетРесурсов = МетодКлиента("Модуль_Клиент", "АдресаИнтернетРесурсов");
	
	HTMLШаблоны = HTMLШаблоны_НетНужногоСертификата();
	
	Результат = HTMLШаблоны.Начало;
	Результат = Результат + HTMLШаблоны.ТаблицаСтилей;
	Результат = Результат + HTMLШаблоны.НачалоТела;
	
	Если ТаблицаСертификатов.Количество() = 0 Тогда
		
		НоваяСтрока = HTMLШаблоны.Шапка;
		НоваяСтрока = СтрЗаменить(НоваяСтрока, "[Текст]", НСтр("ru = 'В окне авторизации нет нужного сертификата. Проделайте следующие шаги:'"));
		Результат = Результат + НоваяСтрока;
		
		СтрокаОповещения = МетодКлиента("Модуль_Клиент", "ПараметрыОповещенияВСтрокуHTMLСообщения", "ОбработчикПровестиДиагностику");
		
		Результат = Результат + НовыйАбзацHTML_НетНужногоСертификата(HTMLШаблоны
									, НСтр("ru = '1. '")
									, НСтр("ru = 'Пройдите в диагностику'")
									, СтрокаОповещения);
		
		Результат = Результат + НовыйАбзацHTML_НетНужногоСертификата(HTMLШаблоны
									, НСтр("ru = '2. '")
									, НСтр("ru = 'Войдите в сервис Диадок'")
									, АдресаИнтернетРесурсов.ПортальнаяАвторизация);
		
		Результат = Результат + НовыйАбзацHTML_НетНужногоСертификата(HTMLШаблоны
									, НСтр("ru = '3. Перезапустите модуль'"));
		
	Иначе
		
		ТекстЗамены = НСтр("ru = '1. Если в окне авторизации нет нужного сертификата, воспользуйтесь инструкцией '");
		Результат = Результат + НовыйАбзацHTML_НетНужногоСертификата(HTMLШаблоны
									, ТекстЗамены
									, НСтр("ru = 'Установить личный сертификат'")
									, АдресаИнтернетРесурсов.СправкаУстановкаСертификата);
		
		ТекстЗамены = НСтр("ru = '2. Если в окне авторизации нет действующего сертификата, свяжитесь с сервисным центром для продления'");
		Результат = Результат + НовыйАбзацHTML_НетНужногоСертификата(HTMLШаблоны, ТекстЗамены);

	КонецЕсли;
	
	Результат = Результат + HTMLШаблоны.КнопкиТехПоддрежки;
	Результат = Результат + HTMLШаблоны.Окончание;
	
	Возврат Результат;
	
КонецФункции //HTMLТекст_НетНужногоСертификата()

// Добавляет в существующий текст HTML новый абзац с подстановкой параметров
// см. метод "HTMLШаблоны"
//
// Параметры:
//	HTMLШаблоны		- Структура	- см. метод "HTMLШаблоны_НетНужногоСертификата" 
//	Текст			- Строка	- текст абзаца
//	ТекстКоманды	- Строка	- текст гипер ссылки
//	КомандаДействия	- Строка	- описание команды при клике по гиперссылке
&НаКлиенте
Функция НовыйАбзацHTML_НетНужногоСертификата(HTMLШаблоны, Текст = "", ТекстКоманды = "", КомандаДействия = "")
	
	Результат = HTMLШаблоны.Абзац;
	
	Результат = СтрЗаменить(Результат, "[Текст]", Текст);
	Результат = СтрЗаменить(Результат, "[ТекстКоманды]", ТекстКоманды);
	Результат = СтрЗаменить(Результат, "[КомандаДействия]", КомандаДействия);
	
	Возврат Результат;
	
КонецФункции //НовыйАбзацHTML_НетНужногоСертификата()

// Коллекция шаблонов для формирования HTML
//
// Возвращаемое значение:
//	Структура
&НаКлиенте
Функция HTMLШаблоны_НетНужногоСертификата()
	
	Начало = "<html><head>
	|<META content=""text/html; charset=utf-8"" http-equiv=Content-Type>";
	
	ТаблицаСтилей = "
	|<style type=text/css>
	|	body {font-family: Segoe UI}
	|	p.head {font-SIZE: 14pt}
	|	p.strtext{font-SIZE: 11pt}
	|</style>";
	
	НачалоТела = "</head><body>";
	
	Окончание = "</body></html>";
	
	Шапка = "
	|<p class=head>[Текст]</p>";
	
	Абзац = "
	|<p class=strtext>[Текст]<a href=""[КомандаДействия]"">[ТекстКоманды]</a>.</p>";
	
	Результат = Новый Структура;
	
	Результат.Вставить("Шапка"			, Шапка);
	Результат.Вставить("Абзац"			, Абзац);
	Результат.Вставить("Начало"			, Начало);
	Результат.Вставить("Окончание"		, Окончание);
	Результат.Вставить("НачалоТела"		, НачалоТела);
	Результат.Вставить("ТаблицаСтилей"	, ТаблицаСтилей);
	
	ДобавитьHTMLШаблоныКнопокТехПоддержки(Результат);
	
	Возврат Результат;
	
КонецФункции //HTMLШаблоны_НетНужногоСертификата()

// Добавляет в шаблон HTML сервисные кнопки
//
// Параметры:
//	HTMLШаблоны	- Структура	- набор HTML шаблонов 
&НаКлиенте
Процедура ДобавитьHTMLШаблоныКнопокТехПоддержки(HTMLШаблоны)
	
	Картинки = МетодКлиента("Модуль_Клиент", "ЭДО_БиблиотекаКартинок");
	
	КартинкаEmail 				= Base64Строка(Картинки.КартинкаEmail.ПолучитьДвоичныеДанные());
	КартинкаОнлайнКонсультант 	= Base64Строка(Картинки.КартинкаОнлайнКонсультант.ПолучитьДвоичныеДанные());
	
	СтрокаОповещенияЧат		 = МетодКлиента("Модуль_Клиент", "ПараметрыОповещенияВСтрокуHTMLСообщения", "ОбработчикОткрытьОнлайнЧат");
	СтрокаОповещенияПочта	 = МетодКлиента("Модуль_Клиент", "ПараметрыОповещенияВСтрокуHTMLСообщения", "ОбработчикОтправитьEmail");
	
	ТаблицаСтилей = МетодКлиента("Модуль_Клиент", "СвойствоСтруктуры", HTMLШаблоны, "ТаблицаСтилей", "");
	
	ТаблицаСтилей = ТаблицаСтилей + "
	|<style type=text/css>
	|	div.footer {position: absolute; bottom: 0; width: 100%; margin-bottom: 10px; font-SIZE: 11pt; text-align: center}
	|	img.support {border: 0; margin-right: 3px; vertical-align: bottom}
	|	a.support {margin-right: 10px}
	|</style>";
	
	КнопкиТехПоддрежки = "
	|<div class=footer>
	|	<a class=support href=" + СтрокаОповещенияПочта + "><nobr><img class=support src=""data:image/png;base64," + КартинкаEmail + """>Написать письмо в техподдержку</nobr></a>
	|	<a class=support href=" + СтрокаОповещенияЧат + "><nobr><img class=support src=""data:image/png;base64," + КартинкаОнлайнКонсультант + """>Задать вопрос онлайн-консультанту</nobr></a>
	|</div>";
	
	HTMLШаблоны.Вставить("ТаблицаСтилей"		, ТаблицаСтилей);
	HTMLШаблоны.Вставить("КнопкиТехПоддрежки"	, КнопкиТехПоддрежки);
	
КонецПроцедуры //ДобавитьHTMLШаблоныКнопокТехПоддержки()
