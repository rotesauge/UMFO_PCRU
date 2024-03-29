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

&НаКлиенте
Функция ПолучитьФормуОбработки(ИмяФормы, ПараметрыФормы = Неопределено , ВладелецФормы  = Неопределено, КлючУникальности = Неопределено, ЗакрыватьПризакрытииВладельца = Ложь)
	
	ПолучаемаяФорма=	ПолучитьФорму(ПутьКФормам+ИмяФормы
										, ПараметрыФормы
										,
										, КлючУникальности);
	
	Если НЕ ВладелецФормы = Неопределено Тогда
		ПолучаемаяФорма.ВладелецФормы=	ВладелецФормы;
	КонецЕсли;
	
	////Падает платформа в БП при режиме открытия окон "В закладках", в остальных режимах - все нормально
	//Если ЗакрыватьПризакрытииВладельца Тогда
	//	ПолучаемаяФорма.ЗакрыватьПризакрытииВладельца=	Истина;
	//КонецЕсли;
	
	Возврат ПолучаемаяФорма;
	
КонецФункции

&НаКлиенте
Процедура СформироватьЗаголовок()
	
	Элементы.НадписьУстановленПериод.Заголовок=	МетодКлиента("Модуль_Клиент","ПредставлениеПериодаДД", НачалоПериода, КонецПериода);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	МетодСервераБезКонтекста(,"УстановитьНастройкуПользователя", "ДиадокСтраницаВыбораПериодаПоУмолчанию", Элементы.Страницы.ТекущаяСтраница.Имя);
	
	ПлатформаПриЗакрытии();
	
КонецПроцедуры

&НаКлиенте
Процедура СтраницыПриСменеСтраницы(Элемент, ТекущаяСтраница)
	
	ТекущаяСтраницаФормы=	ТекущаяСтраница.Имя;
	УправлениеВидимостью();
	
КонецПроцедуры

&НаКлиенте
Процедура ПосчитатьДату(ДатаПериода, Направление, ЧислоДней)
	
	ДатаПериода=	ДатаПериода + Направление*ЧислоДней*24*3600;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьНачальныеНастройки()
	
	ТекущийЭлемент=			Элементы[СтраницаВыбораПериодаПоУмолчанию];
	ТекущаяСтраницаФормы=	СтраницаВыбораПериодаПоУмолчанию;
	
	ПереключательНачИнтервалаНачалоПериода=	1;
	ПереключательКонИнтервалаКонецПериода=	1;
	
	Если НЕ ЗначениеЗаполнено(НачалоПериода)
		ИЛИ НЕ ЗначениеЗаполнено(КонецПериода) Тогда
		
		ПолеГод=		НачалоГода(ТекущаяДата());
		ПолеКвартал=	НачалоКвартала(ТекущаяДата());
		ПолеМесяц=		НачалоМесяца(ТекущаяДата());
		ПолеДень=		НачалоДня(ТекущаяДата());
		
		НачалоПериода=	ТекущаяДата();
		КонецПериода=	ТекущаяДата();
		
	Иначе
		ПолеГод=		КонецГода(КонецПериода);
		ПолеКвартал=	КонецКвартала(КонецПериода);
		ПолеМесяц=		КонецМесяца(КонецПериода);
		ПолеДень=		КонецДня(КонецПериода);
	КонецЕсли;

	Если НачалоПериода = НачалоГода(НачалоПериода) И КонецПериода = КонецГода(КонецПериода) Тогда
		УправлениеПереключателями("ПереключательГод");
	ИначеЕсли  НачалоПериода = НачалоКвартала(НачалоПериода) И КонецПериода = КонецКвартала(КонецПериода) Тогда
		ПолеГод=		КонецГода(КонецПериода);
		ПолеКвартал=	КонецКвартала(КонецПериода);
		ПолеМесяц=		КонецМесяца(КонецПериода);
		ПолеДень=		КонецДня(КонецПериода);
		УправлениеПереключателями("ПереключательКвартал");
	ИначеЕсли  НачалоПериода = НачалоМесяца(НачалоПериода) И КонецПериода = КонецМесяца(КонецПериода) Тогда
		ПолеГод=		КонецГода(КонецПериода);
		ПолеКвартал=	КонецКвартала(КонецПериода);
		ПолеМесяц=		КонецМесяца(КонецПериода);
		ПолеДень=		КонецДня(КонецПериода);
		УправлениеПереключателями("ПереключательМесяц");
	ИначеЕсли  НачалоПериода = НачалоДня(НачалоПериода) И КонецПериода = КонецДня(КонецПериода) Тогда
		ПолеГод=		КонецГода(КонецПериода);
		ПолеКвартал=	КонецКвартала(КонецПериода);
		ПолеМесяц=		КонецМесяца(КонецПериода);
		ПолеДень=		КонецДня(КонецПериода);
		УправлениеПереключателями("ПереключательДень");
	Иначе
		ПолеГод=		КонецГода(КонецПериода);
		ПолеКвартал=	КонецКвартала(КонецПериода);
		ПолеМесяц=		КонецМесяца(КонецПериода);
		ПолеДень=		КонецДня(КонецПериода);
		УправлениеПереключателями("ПереключательПроизвольныйИнтервал")
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ПлатформаПриОткрытии(Отказ);
	
	Если КонецПериода = МетодКлиента("Модуль_Клиент","ДатаГоризонта") Тогда
		КонецПериода= Неопределено;
	КонецЕсли;

	УстановитьНачальныеНастройки();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьФорму(Команда)
	
	Результат= Новый Структура;
	Результат.Вставить("ДатаНачала"				, НачалоДня(НачалоПериода));
	Результат.Вставить("ДатаОкончания"			, ?(ЗначениеЗаполнено(КонецПериода), КонецДня(КонецПериода), МетодКлиента("Модуль_Клиент","ДатаГоризонта")));
	Результат.Вставить("ОтбиратьПоДатеДокумента", ОтбиратьПоДатеДокумента = Истина);
	Результат.Вставить("ТекущаяСтраница"		, Параметры.ТекущаяСтраница);
	
	Закрыть(Результат);
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ПлатформаПриСозданииНаСервере(Отказ, СтандартнаяОбработка);
	
	СтраницаВыбораПериодаПоУмолчанию= МетодСервера(,"ПолучитьНастройкуПользователя", "ДиадокСтраницаВыбораПериодаПоУмолчанию");
	Если НЕ ЗначениеЗаполнено(СтраницаВыбораПериодаПоУмолчанию) Тогда
		СтраницаВыбораПериодаПоУмолчанию= "Период";
	КонецЕсли;
	
	Параметры.Свойство("ДатаНачала"	  , НачалоПериода);
	Параметры.Свойство("ДатаОкончания", КонецПериода);
	
	Если Параметры.Свойство("ОтбиратьПоДатеДокумента", ОтбиратьПоДатеДокумента) Тогда
		Элементы.СтраницыОтбиратьПоДатеДокумента.ТекущаяСтраница= Элементы.СтраницаОтбиратьПоДатеДокумента;
	Иначе
		Элементы.СтраницыОтбиратьПоДатеДокумента.ТекущаяСтраница= Элементы.СтраницаОтбиратьПоДатеДокументаПустая;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	ЭтаФорма.Закрыть();	
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменениеМесяца()
	ПолеМесяцПредставление=	Формат(ПолеМесяц, "ДФ='MMMM yyyy ""г.""'");
КонецПроцедуры

&НаКлиенте
Процедура УправлениеВидимостью()
	
	Если ТекущаяСтраницаФормы = "Интервал" Тогда
		
		Если ПереключательНачИнтервалаДнейДоТекДаты = 1 Тогда
			Элементы.ДнейДоТекущейДаты.Доступность=		Истина;
			Элементы.ИнтервалНачалоПериода.Доступность= Ложь;
		ИначеЕсли ПереключательНачИнтервалаНачалоПериода = 1 Тогда
			Элементы.ДнейДоТекущейДаты.Доступность=		Ложь;
			Элементы.ИнтервалНачалоПериода.Доступность= Истина;
		Иначе
			Элементы.ДнейДоТекущейДаты.Доступность=		Ложь;
			Элементы.ИнтервалНачалоПериода.Доступность= Ложь;
		КонецЕсли;
		
		Если ПереключательКонИнтервалаДнейПослеТекДаты = 1 Тогда
			Элементы.ДнейПослеТекущейДаты.Доступность=	Истина;
			Элементы.ИнтервалКонецПериода.Доступность= 	Ложь;
		ИначеЕсли ПереключательКонИнтервалаКонецПериода = 1 Тогда
			Элементы.ДнейПослеТекущейДаты.Доступность=	Ложь;
			Элементы.ИнтервалКонецПериода.Доступность= 	Истина;
		Иначе
			Элементы.ДнейПослеТекущейДаты.Доступность=	Ложь;
			Элементы.ИнтервалКонецПериода.Доступность=	Ложь;
		КонецЕсли;
		
	ИначеЕсли ТекущаяСтраницаФормы = "Период" Тогда
		
		Если ПереключательГод Тогда
			
			Элементы.ПолеГод.Доступность=		Истина;
			Элементы.ПолеКвартал.Доступность=	Ложь;
			Элементы.ПолеМесяц.Доступность=		Ложь;
			Элементы.ПолеДень.Доступность=		Ложь;
			
			Элементы.СНачалаГода.Доступность=		Ложь;
			Элементы.СНачалаКвартала.Доступность=	Ложь;
			Элементы.СНачалаМесяца.Доступность=		Ложь;
			
			Элементы.НачалоПериода.Доступность=	Ложь;
			Элементы.КонецПериода.Доступность=	Ложь;
			
		ИначеЕсли ПереключательКвартал Тогда
			
			Элементы.ПолеГод.Доступность=		Ложь;
			Элементы.ПолеКвартал.Доступность=	Истина;
			Элементы.ПолеМесяц.Доступность=		Ложь;
			Элементы.ПолеДень.Доступность=		Ложь;
			
			Элементы.СНачалаГода.Доступность=		Истина;
			Элементы.СНачалаКвартала.Доступность=	Ложь;
			Элементы.СНачалаМесяца.Доступность=		Ложь;
			
			Элементы.НачалоПериода.Доступность=	Ложь;
			Элементы.КонецПериода.Доступность=	Ложь;
			
		ИначеЕсли ПереключательМесяц Тогда
			
			Элементы.ПолеГод.Доступность=		Ложь;
			Элементы.ПолеКвартал.Доступность=	Ложь;
			Элементы.ПолеМесяц.Доступность=		Истина;
			Элементы.ПолеДень.Доступность=		Ложь;
			
			Элементы.СНачалаГода.Доступность=		Истина;
			Элементы.СНачалаКвартала.Доступность=	Истина;
			Элементы.СНачалаМесяца.Доступность=		Ложь;
			
			Элементы.НачалоПериода.Доступность=	Ложь;
			Элементы.КонецПериода.Доступность=	Ложь;
			
			
		ИначеЕсли ПереключательДень Тогда
			
			Элементы.ПолеГод.Доступность=		Ложь;
			Элементы.ПолеКвартал.Доступность=	Ложь;
			Элементы.ПолеМесяц.Доступность=		Ложь;
			Элементы.ПолеДень.Доступность=		Истина;
			
			Элементы.СНачалаГода.Доступность=		Истина;
			Элементы.СНачалаКвартала.Доступность=	Истина;
			Элементы.СНачалаМесяца.Доступность=		Истина;
			
			Элементы.НачалоПериода.Доступность=	Ложь;
			Элементы.КонецПериода.Доступность=	Ложь;
			
		ИначеЕсли ПереключательПроизвольныйИнтервал Тогда
			
			Элементы.ПолеГод.Доступность=		Ложь;
			Элементы.ПолеКвартал.Доступность=	Ложь;
			Элементы.ПолеМесяц.Доступность=		Ложь;
			Элементы.ПолеДень.Доступность=		Ложь;
			
			Элементы.СНачалаГода.Доступность=		Ложь;
			Элементы.СНачалаКвартала.Доступность=	Ложь;
			Элементы.СНачалаМесяца.Доступность=		Ложь;
			
			Элементы.НачалоПериода.Доступность=	Истина;
			Элементы.КонецПериода.Доступность=	Истина;
			
		КонецЕсли;
		
	КонецЕсли;
	
	ИзменениеМесяца();
	
	СформироватьЗаголовок();
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверкаИнтервала(РежимСдвига)
	
	Если РежимСдвига = 1 Тогда
		Если НачалоДня(НачалоПериода) > НачалоДня(КонецПериода) Тогда
			Сообщить("Недопустимое значение интервала: начало периода больше конца!");
			НачалоПериода=	НачалоДня(КонецПериода);
		КонецЕсли;
	ИначеЕсли РежимСдвига = 2 Тогда
		КонецПериодаДляПроверки=	?(ЗначениеЗаполнено(КонецПериода), КонецПериода, МетодКлиента("Модуль_Клиент","ДатаГоризонта"));
		Если НачалоДня(КонецПериодаДляПроверки) < НачалоДня(НачалоПериода) Тогда
			Сообщить("Недопустимое значение интервала: конец периода меньше начала!");
			КонецПериода=	НачалоДня(НачалоПериода);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

///////////////////////////////////
//Блок управления действиями
&НаКлиенте
Процедура УправлениеПереключателями(ИмяТекущегоЭлемента)
	
	ТекущийПереключатель=	ИмяТекущегоЭлемента;
	
	Если ТекущаяСтраницаФормы = "Интервал" Тогда
		
		//Левая группа
		Если ИмяТекущегоЭлемента = "ПереключательНачИнтервалаБезОграничения" Тогда
			
			ПереключательНачИнтервалаБезОграничения=	1;
			ПереключательНачИнтервалаДнейДоТекДаты=		0;
			ПереключательНачИнтервалаНачалоГода=		0;
			ПереключательНачИнтервалаНачалоКвартала=	0;
			ПереключательНачИнтервалаНачалоМесяца=		0;
			ПереключательНачИнтервалаНачалоНедели=		0;
			ПереключательНачИнтервалаНачалоДня=			0;
			ПереключательНачИнтервалаНачалоПериода=		0;
			
			НачалоПериода=	Дата(0001,01,01);
			
		ИначеЕсли  ИмяТекущегоЭлемента = "ПереключательНачИнтервалаДнейДоТекДаты" Тогда
			
			ПереключательНачИнтервалаБезОграничения=	0;
			ПереключательНачИнтервалаДнейДоТекДаты=		1;
			ПереключательНачИнтервалаНачалоГода=		0;
			ПереключательНачИнтервалаНачалоКвартала=	0;
			ПереключательНачИнтервалаНачалоМесяца=		0;
			ПереключательНачИнтервалаНачалоНедели=		0;
			ПереключательНачИнтервалаНачалоДня=			0;
			ПереключательНачИнтервалаНачалоПериода=		0;
			
			НачалоПериода=	ТекущаяДата();
			ПосчитатьДату(НачалоПериода, -1, ДнейДоТекущейДаты);
			ПроверкаИнтервала(2);
			
		ИначеЕсли  ИмяТекущегоЭлемента = "ПереключательНачИнтервалаНачалоГода" Тогда
			
			ПереключательНачИнтервалаБезОграничения=	0;
			ПереключательНачИнтервалаДнейДоТекДаты=		0;
			ПереключательНачИнтервалаНачалоГода=		1;
			ПереключательНачИнтервалаНачалоКвартала=	0;
			ПереключательНачИнтервалаНачалоМесяца=		0;
			ПереключательНачИнтервалаНачалоНедели=		0;
			ПереключательНачИнтервалаНачалоДня=			0;
			ПереключательНачИнтервалаНачалоПериода=		0;
			
			НачалоПериода=	НачалоГода(ТекущаяДата());
			ПроверкаИнтервала(2);
			
		ИначеЕсли  ИмяТекущегоЭлемента = "ПереключательНачИнтервалаНачалоКвартала" Тогда
			
			ПереключательНачИнтервалаБезОграничения=	0;
			ПереключательНачИнтервалаДнейДоТекДаты=		0;
			ПереключательНачИнтервалаНачалоГода=		0;
			ПереключательНачИнтервалаНачалоКвартала=	1;
			ПереключательНачИнтервалаНачалоМесяца=		0;
			ПереключательНачИнтервалаНачалоНедели=		0;
			ПереключательНачИнтервалаНачалоДня=			0;
			ПереключательНачИнтервалаНачалоПериода=		0;
			
			НачалоПериода=	НачалоКвартала(ТекущаяДата());
			ПроверкаИнтервала(2);
			
		ИначеЕсли  ИмяТекущегоЭлемента = "ПереключательНачИнтервалаНачалоМесяца" Тогда
			
			ПереключательНачИнтервалаБезОграничения=	0;
			ПереключательНачИнтервалаДнейДоТекДаты=		0;
			ПереключательНачИнтервалаНачалоГода=		0;
			ПереключательНачИнтервалаНачалоКвартала=	0;
			ПереключательНачИнтервалаНачалоМесяца=		1;
			ПереключательНачИнтервалаНачалоНедели=		0;
			ПереключательНачИнтервалаНачалоДня=			0;
			ПереключательНачИнтервалаНачалоПериода=		0;
			
			НачалоПериода=	НачалоМесяца(ТекущаяДата());
			ПроверкаИнтервала(2);
			
		ИначеЕсли  ИмяТекущегоЭлемента = "ПереключательНачИнтервалаНачалоНедели" Тогда
			
			ПереключательНачИнтервалаБезОграничения=	0;
			ПереключательНачИнтервалаДнейДоТекДаты=		0;
			ПереключательНачИнтервалаНачалоГода=		0;
			ПереключательНачИнтервалаНачалоКвартала=	0;
			ПереключательНачИнтервалаНачалоМесяца=		0;
			ПереключательНачИнтервалаНачалоНедели=		1;
			ПереключательНачИнтервалаНачалоДня=			0;
			ПереключательНачИнтервалаНачалоПериода=		0;
			
			НачалоПериода=	НачалоНедели(ТекущаяДата());
			ПроверкаИнтервала(2);
			
		ИначеЕсли  ИмяТекущегоЭлемента = "ПереключательНачИнтервалаНачалоДня" Тогда
			
			ПереключательНачИнтервалаБезОграничения=	0;
			ПереключательНачИнтервалаДнейДоТекДаты=		0;
			ПереключательНачИнтервалаНачалоГода=		0;
			ПереключательНачИнтервалаНачалоКвартала=	0;
			ПереключательНачИнтервалаНачалоМесяца=		0;
			ПереключательНачИнтервалаНачалоНедели=		0;
			ПереключательНачИнтервалаНачалоДня=			1;
			ПереключательНачИнтервалаНачалоПериода=		0;
			
			НачалоПериода=	НачалоДня(ТекущаяДата());
			ПроверкаИнтервала(1);
			
		ИначеЕсли ИмяТекущегоЭлемента = "ПереключательНачИнтервалаНачалоПериода" Тогда
		
			ПереключательНачИнтервалаБезОграничения=	0;
			ПереключательНачИнтервалаДнейДоТекДаты=		0;
			ПереключательНачИнтервалаНачалоГода=		0;
			ПереключательНачИнтервалаНачалоКвартала=	0;
			ПереключательНачИнтервалаНачалоМесяца=		0;
			ПереключательНачИнтервалаНачалоНедели=		0;
			ПереключательНачИнтервалаНачалоДня=			0;
			ПереключательНачИнтервалаНачалоПериода=		1;
			
		//Правая группа
		ИначеЕсли ИмяТекущегоЭлемента = "ПереключательКонИнтервалаБезОграничения" Тогда
		
			ПереключательКонИнтервалаБезОграничения=	1;
			ПереключательКонИнтервалаДнейПослеТекДаты=	0;
			ПереключательКонИнтервалаКонецГода=			0;
			ПереключательКонИнтервалаКонецКвартала=		0;
			ПереключательКонИнтервалаКонецМесяца=		0;
			ПереключательКонИнтервалаКонецНедели=		0;
			ПереключательКонИнтервалаКонецДня=			0;
			ПереключательКонИнтервалаКонецПериода=		0;
			
			КонецПериода=	Дата(0001,01,01);
			
		ИначеЕсли  ИмяТекущегоЭлемента = "ПереключательКонИнтервалаДнейПослеТекДаты" Тогда
			
			ПереключательКонИнтервалаБезОграничения=	0;
			ПереключательКонИнтервалаДнейПослеТекДаты=	1;
			ПереключательКонИнтервалаКонецГода=			0;
			ПереключательКонИнтервалаКонецКвартала=		0;
			ПереключательКонИнтервалаКонецМесяца=		0;
			ПереключательКонИнтервалаКонецНедели=		0;
			ПереключательКонИнтервалаКонецДня=			0;
			ПереключательКонИнтервалаКонецПериода=		0;
			
			КонецПериода=	ТекущаяДата();
			ПосчитатьДату(КонецПериода, -1, ДнейПослеТекущейДаты);
			ПроверкаИнтервала(1);
			
		ИначеЕсли  ИмяТекущегоЭлемента = "ПереключательКонИнтервалаКонецГода" Тогда
			
			ПереключательКонИнтервалаБезОграничения=	0;
			ПереключательКонИнтервалаДнейПослеТекДаты=	0;
			ПереключательКонИнтервалаКонецГода=			1;
			ПереключательКонИнтервалаКонецКвартала=		0;
			ПереключательКонИнтервалаКонецМесяца=		0;
			ПереключательКонИнтервалаКонецНедели=		0;
			ПереключательКонИнтервалаКонецДня=			0;
			ПереключательКонИнтервалаКонецПериода=		0;
			
			КонецПериода=	КонецГода(ТекущаяДата());
			ПроверкаИнтервала(1);
			
		ИначеЕсли  ИмяТекущегоЭлемента = "ПереключательКонИнтервалаКонецКвартала" Тогда
			
			ПереключательКонИнтервалаБезОграничения=	0;
			ПереключательКонИнтервалаДнейПослеТекДаты=	0;
			ПереключательКонИнтервалаКонецГода=			0;
			ПереключательКонИнтервалаКонецКвартала=		1;
			ПереключательКонИнтервалаКонецМесяца=		0;
			ПереключательКонИнтервалаКонецНедели=		0;
			ПереключательКонИнтервалаКонецДня=			0;
			ПереключательКонИнтервалаКонецПериода=		0;
			
			КонецПериода=	КонецКвартала(ТекущаяДата());
			ПроверкаИнтервала(1);
			
		ИначеЕсли  ИмяТекущегоЭлемента = "ПереключательКонИнтервалаКонецМесяца" Тогда
			
			ПереключательКонИнтервалаБезОграничения=	0;
			ПереключательКонИнтервалаДнейПослеТекДаты=	0;
			ПереключательКонИнтервалаКонецГода=			0;
			ПереключательКонИнтервалаКонецКвартала=		0;
			ПереключательКонИнтервалаКонецМесяца=		1;
			ПереключательКонИнтервалаКонецНедели=		0;
			ПереключательКонИнтервалаКонецДня=			0;
			ПереключательКонИнтервалаКонецПериода=		0;
			
			КонецПериода=	КонецМесяца(ТекущаяДата());
			ПроверкаИнтервала(1);
			
		ИначеЕсли  ИмяТекущегоЭлемента = "ПереключательКонИнтервалаКонецНедели" Тогда
			
			ПереключательКонИнтервалаБезОграничения=	0;
			ПереключательКонИнтервалаДнейПослеТекДаты=	0;
			ПереключательКонИнтервалаКонецГода=			0;
			ПереключательКонИнтервалаКонецКвартала=		0;
			ПереключательКонИнтервалаКонецМесяца=		0;
			ПереключательКонИнтервалаКонецНедели=		1;
			ПереключательКонИнтервалаКонецДня=			0;
			ПереключательКонИнтервалаКонецПериода=		0;
			
			КонецПериода=	КонецНедели(ТекущаяДата());
			ПроверкаИнтервала(1);
			
		ИначеЕсли  ИмяТекущегоЭлемента = "ПереключательКонИнтервалаКонецДня" Тогда
			
			ПереключательКонИнтервалаБезОграничения=	0;
			ПереключательКонИнтервалаДнейПослеТекДаты=	0;
			ПереключательКонИнтервалаКонецГода=			0;
			ПереключательКонИнтервалаКонецКвартала=		0;
			ПереключательКонИнтервалаКонецМесяца=		0;
			ПереключательКонИнтервалаКонецНедели=		0;
			ПереключательКонИнтервалаКонецДня=			1;
			ПереключательКонИнтервалаКонецПериода=		0;
			
			КонецПериода=	КонецДня(ТекущаяДата());
			ПроверкаИнтервала(2);
			
		ИначеЕсли ИмяТекущегоЭлемента = "ПереключательКонИнтервалаКонецПериода" Тогда
		
			ПереключательКонИнтервалаБезОграничения=	0;
			ПереключательКонИнтервалаДнейПослеТекДаты=	0;
			ПереключательКонИнтервалаКонецГода=			0;
			ПереключательКонИнтервалаКонецКвартала=		0;
			ПереключательКонИнтервалаКонецМесяца=		0;
			ПереключательКонИнтервалаКонецНедели=		0;
			ПереключательКонИнтервалаКонецДня=			0;
			ПереключательКонИнтервалаКонецПериода=		1;
			
		КонецЕсли;
		
	ИначеЕсли ТекущаяСтраницаФормы = "Период" Тогда
		
		Если ИмяТекущегоЭлемента = "ПереключательГод" Тогда
			
			ПереключательГод=					1;
			ПереключательКвартал=				0;
			ПереключательМесяц=					0;
			ПереключательДень=					0;
			ПереключательПроизвольныйИнтервал=	0;
			
			НачалоПериода=	НачалоГода(ПолеГод);
			КонецПериода=	КонецГода(ПолеГод);
			
		ИначеЕсли ИмяТекущегоЭлемента = "ПереключательКвартал" Тогда
			
			ПереключательГод=					0;
			ПереключательКвартал=				1;
			ПереключательМесяц=					0;
			ПереключательДень=					0;
			ПереключательПроизвольныйИнтервал=	0;
			
			НачалоПериода=	НачалоКвартала(ПолеКвартал);
			КонецПериода=	КонецКвартала(ПолеКвартал);
			
		ИначеЕсли ИмяТекущегоЭлемента = "ПереключательМесяц" Тогда
			
			ПереключательГод=					0;
			ПереключательКвартал=				0;
			ПереключательМесяц=					1;
			ПереключательДень=					0;
			ПереключательПроизвольныйИнтервал=	0;
			
			НачалоПериода=	НачалоМесяца(ПолеМесяц);
			КонецПериода=	КонецМесяца(ПолеМесяц);
			
		ИначеЕсли ИмяТекущегоЭлемента = "ПереключательДень" Тогда
			
			ПереключательГод=					0;
			ПереключательКвартал=				0;
			ПереключательМесяц=					0;
			ПереключательДень=					1;
			ПереключательПроизвольныйИнтервал=	0;
			
			НачалоПериода=	НачалоДня(ПолеДень);
			КонецПериода=	КонецДня(ПолеДень);
			
		ИначеЕсли ИмяТекущегоЭлемента = "ПереключательПроизвольныйИнтервал" Тогда
			
			ПереключательГод=					0;
			ПереключательКвартал=				0;
			ПереключательМесяц=					0;
			ПереключательДень=					0;
			ПереключательПроизвольныйИнтервал=	1;
			
		КонецЕсли;
	КонецЕсли;
	
	УправлениеВидимостью();
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменениеФлаговСНачала(ИмяТекущегоЭлемента)
	
	ТекущийФлагСНачала=	ИмяТекущегоЭлемента;
	
	УправлениеПереключателями(ТекущийПереключатель);
	
	Если ИмяТекущегоЭлемента = "СНачалаГода" Тогда
		
		Если СНачалаГода Тогда
			НачалоПериода=		НачалоГода(ПолеКвартал);
		КонецЕсли;
		
		СНачалаКвартала=	Ложь;
		СНачалаМесяца=		Ложь;
		
	ИначеЕсли ИмяТекущегоЭлемента = "СНачалаКвартала" Тогда
		
		Если СНачалаКвартала Тогда
			НачалоПериода=	НачалоКвартала(ПолеМесяц);
		КонецЕсли;
		
		СНачалаГода=	Ложь;
		СНачалаМесяца=	Ложь;
		
	ИначеЕсли ИмяТекущегоЭлемента = "СНачалаМесяца" Тогда
		
		Если СНачалаМесяца Тогда
			НачалоПериода=		НачалоМесяца(ПолеДень);
		КонецЕсли;
		
		СНачалаГода=		Ложь;
		СНачалаКвартала=	Ложь;
		
	КонецЕсли;

	СформироватьЗаголовок();
	
КонецПроцедуры

&НаКлиенте
Процедура Регулирование(ИмяТекущегоЭлемента, Направление)
	
	Если ИмяТекущегоЭлемента = "ПолеГод" Тогда
		ПолеГод=		ДобавитьМесяц(ПолеГод, Направление*12);
		НачалоПериода=	НачалоГода(ПолеГод);
		КонецПериода=	КонецГода(ПолеГод);
	ИначеЕсли ИмяТекущегоЭлемента = "ПолеКвартал" Тогда
		ПолеКвартал=	ДобавитьМесяц(ПолеКвартал, Направление*3);
		НачалоПериода=	НачалоКвартала(ПолеКвартал);
		КонецПериода=	КонецКвартала(ПолеКвартал);
	ИначеЕсли ИмяТекущегоЭлемента = "ПолеМесяц" ИЛИ ИмяТекущегоЭлемента = "ПолеМесяцПредставление" Тогда
		ПолеМесяц=		ДобавитьМесяц(ПолеМесяц, Направление*1);
		ИзменениеМесяца();
		НачалоПериода=	НачалоМесяца(ПолеМесяц);
		КонецПериода=	КонецМесяца(ПолеМесяц);
	ИначеЕсли ИмяТекущегоЭлемента = "ПолеДень" Тогда
		ПосчитатьДату(ПолеДень, Направление, 1);
		//ПолеДень=		ПолеДень + Направление*3600*24;
		НачалоПериода=	НачалоДня(ПолеДень);
		КонецПериода=	КонецДня(ПолеДень);
	КонецЕсли;
	
	ИзменениеФлаговСНачала(ТекущийФлагСНачала);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолеДеньПриИзменении(Элемент)
	
	НачалоПериода=	НачалоДня(ПолеДень);
	КонецПериода=	КонецДня(ПолеДень);
	
	ИзменениеФлаговСНачала(ТекущийФлагСНачала);
	
КонецПроцедуры

&НаКлиенте
Процедура НачалоПериодаПриИзменении(Элемент)
	ПроверкаИнтервала(1);
КонецПроцедуры

&НаКлиенте
Процедура КонецПериодаПриИзменении(Элемент)
	
	ПроверкаИнтервала(2);
	
	ПолеГод=		НачалоГода(КонецПериода);
	ПолеКвартал=	НачалоКвартала(КонецПериода);
	ПолеМесяц=		НачалоМесяца(КонецПериода);
	ПолеДень=		НачалоДня(КонецПериода);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолеМесяцПредставлениеОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка=	Ложь;
КонецПроцедуры

&НаКлиенте
Процедура СНачалаГодаПриИзменении(Элемент)
	ИзменениеФлаговСНачала(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура СНачалаКварталаПриИзменении(Элемент)
	ИзменениеФлаговСНачала(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура СНачалаМесяцаПриИзменении(Элемент)
	ИзменениеФлаговСНачала(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ДнейДоТекущейДатыПриИзменении(Элемент)
	ПосчитатьДату(НачалоПериода, -1, ДнейДоТекущейДаты);
КонецПроцедуры

&НаКлиенте
Процедура ДнейПослеТекущейДатыПриИзменении(Элемент)
	ПосчитатьДату(КонецПериода, 1, ДнейПослеТекущейДаты);
КонецПроцедуры

///////////////////////////////////
//Регулирование
&НаКлиенте
Процедура ПолеГодРегулирование(Элемент, Направление, СтандартнаяОбработка)
	
	СтандартнаяОбработка=	Ложь;
	Регулирование(ТекущийЭлемент.Имя, Направление);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолеКварталРегулирование(Элемент, Направление, СтандартнаяОбработка)
	
	СтандартнаяОбработка=	Ложь;
	Регулирование(ТекущийЭлемент.Имя, Направление);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолеМесяцПредставлениеРегулирование(Элемент, Направление, СтандартнаяОбработка)
	
	СтандартнаяОбработка=	Ложь;
	Регулирование(ТекущийЭлемент.Имя, Направление);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолеДеньРегулирование(Элемент, Направление, СтандартнаяОбработка)
	
	СтандартнаяОбработка=	Ложь;
	Регулирование(ТекущийЭлемент.Имя, Направление);
	
КонецПроцедуры

///////////////////////////////////
//Переключатели
&НаКлиенте
Процедура ПереключательГодПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ПереключательКварталПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ПереключательМесяцПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ПереключательДеньПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ПереключательПроизвольныйИнтервалПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ПереключательНачИнтервалаБезОграниченияПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ПереключательНачИнтервалаДнейДоТекДатыПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ПереключательНачИнтервалаНачалоГодаПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ПереключательНачИнтервалаНачалоКварталаПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ПереключательНачИнтервалаНачалоМесяцаПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ПереключательНачИнтервалаНачалоНеделиПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ПереключательНачИнтервалаНачалоДняПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ПереключательНачИнтервалаНачалоПериодаПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ПереключательКонИнтервалаБезОграниченияПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ПереключательКонИнтервалаДнейПослеТекДатыПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ПереключательКонИнтервалаКонецГодаПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ПереключательКонИнтервалаКонецКварталаПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ПереключательКонИнтервалаКонецМесяцаПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ПереключательКонИнтервалаКонецНеделиПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ПереключательКонИнтервалаКонецДняПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ПереключательКонИнтервалаКонецПериодаПриИзменении(Элемент)
	УправлениеПереключателями(ТекущийЭлемент.Имя);
КонецПроцедуры
