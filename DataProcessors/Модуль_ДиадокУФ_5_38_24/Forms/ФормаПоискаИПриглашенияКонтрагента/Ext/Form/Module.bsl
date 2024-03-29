﻿////////////////////////////////////////////////////////////////////////////////
//{ ПЕРЕМЕННЫЕ МОДУЛЯ
	
	&НаКлиенте
	Перем CounteragentList;
	&НаКлиенте
	Перем МассивКонтрагентовДляПроверки;
	&НаКлиенте
	Перем КоличествоОбрабатываемыхКонтрагентов;
	&НаКлиенте
	Перем Итерация;
	
	&НаКлиенте
	Перем Organization Экспорт;
	
//} ПЕРЕМЕННЫЕ МОДУЛЯ
////////////////////////////////////////////////////////////////////////////////

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

////////////////////////////////////////////////////////////////////////////////
//{ УПРАВЛЕНИЕ ФОРМОЙ
	
	&НаСервере
	Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
		
		ПлатформаПриСозданииНаСервере(Отказ, СтандартнаяОбработка);
		
		СписокСтатусов=	МетодСервера(,"ПолучитьСписокСтатусовВзаимоотношений");
		СписокСтатусов.Добавить("Ликвидирован", "Ликвидирован");
		
		Если Объект.ПараметрыКлиентСервер.МаркерКонфигурации = "УТ11" Тогда
			Элементы.ДеревоРодителейБП30.Видимость= 	Ложь;
			Элементы.ДеревоРодителейБП30.Доступность= 	Ложь;
			Элементы.ДеревоРодителейУТ11.Видимость= 	Истина;
			Элементы.ДеревоРодителейУТ11.Доступность= 	Истина;
		Иначе
			Элементы.ДеревоРодителейБП30.Видимость= 	Истина;
			Элементы.ДеревоРодителейБП30.Доступность= 	Истина;
			Элементы.ДеревоРодителейУТ11.Видимость= 	Ложь;
			Элементы.ДеревоРодителейУТ11.Доступность= 	Ложь;
		КонецЕсли;
		
		ЗаполнитьСписки();
		
	КонецПроцедуры
		
	&НаКлиенте
	Процедура УправлениеФормой()
		
		АвтоЗаголовок=	Ложь;
		Заголовок=		"Поиск контрагентов организации " + Organization.Name + ?(Organization.Inn = "", "", ", ИНН " + Organization.Inn);
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ПриОткрытии(Отказ)
		
		ПлатформаПриОткрытии(Отказ);
		
		ИнициированоОбновление=	Ложь;
		
		ПоследняяСсылка= ПредопределенноеЗначение("Справочник.Контрагенты.ПустаяСсылка");
		
		УправлениеФормой();
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ПриЗакрытии()
		
		ПлатформаПриЗакрытии();
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ИнициироватьОбновлениеСписка()
		
		ТаблицаКонтрагентов.Очистить();
		
		ПоследняяСсылка=						ПредопределенноеЗначение("Справочник.Контрагенты.ПустаяСсылка");
		КоличествоОбрабатываемыхКонтрагентов=	ПолучитьКоличествоОбрабатываемыхКонтрагентов(Родитель, Объект.ПараметрыКлиентСервер.МаркерКонфигурации);
		ИнициированоОбновление=					Истина;
		Итерация=								0;
		
		ОтключитьОбработчикОжидания("ПодключаемыйОбработчикОбновитьСтатусРаботыСКА");
		ПодключитьОбработчикОжидания("ПодключаемыйОбработчикОбновитьСтатусРаботыСКА", 0.1, Истина);
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ДеревоРодителейБП30ПриАктивизацииСтроки(Элемент)
		
		Если НЕ ИзменениеТаблицы И НЕ Кэширование Тогда
			Если НЕ Элементы.ДеревоРодителейБП30.ТекущиеДанные = Неопределено Тогда
				Родитель=	Элементы.ДеревоРодителейБП30.ТекущиеДанные.Ссылка;
			Иначе
				Родитель=	ПредопределенноеЗначение("Справочник.Контрагенты.ПустаяСсылка");
			КонецЕсли;
			ИнициироватьОбновлениеСписка();
		КонецЕсли;
		
		ИзменениеТаблицы=	Ложь;
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ДеревоРодителейУТ11ПриАктивизацииСтроки(Элемент)
		
		Если НЕ ИзменениеТаблицы И НЕ Кэширование Тогда
			Если НЕ Элементы.ДеревоРодителейУТ11.ТекущиеДанные = Неопределено Тогда
				Родитель=	Элементы.ДеревоРодителейУТ11.ТекущиеДанные.Ссылка;
			Иначе
				Родитель=	ПредопределенноеЗначение("Справочник.Контрагенты.ПустаяСсылка");
			КонецЕсли;
			ИнициироватьОбновлениеСписка();
		КонецЕсли;
		
		ИзменениеТаблицы=	Ложь;
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ТаблицаКонтрагентовПометкаПриИзменении(Элемент)
		
		ТекущиеДанные=	Элементы.ТаблицаКонтрагентов.ТекущиеДанные;
		Если ТекущиеДанные = Неопределено Тогда
			Возврат;
		Иначе
			Если НЕ ТекущиеДанные.МожноОтправитьПриглашение Тогда
				
				СообщениеПользователю=	Новый СообщениеПользователю;
				СообщениеПользователю.Текст=	"Данному контрагенту нельзя отправить приглашение, статус """ + ТекущиеДанные.СтатусРасшифровка + """";
				СообщениеПользователю.Сообщить();
				
				ТекущиеДанные.Пометка=	Ложь;
				
			КонецЕсли;
			
			СтруктураСтроки=	Новый Структура;
			СтруктураСтроки.Вставить("ГУИД", 	ТекущиеДанные.ГУИД);
			СтруктураСтроки.Вставить("Пометка", ТекущиеДанные.Пометка);
			
			СинхронизироватьСтрокуВКэше(СтруктураСтроки);
			
		КонецЕсли;
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура КонтрагентыОтправитьПриглашение(Команда)
		
		ВыбранныеСтроки=	ТаблицаКонтрагентов.НайтиСтроки(Новый Структура("Пометка", Истина));
		
		Если ВыбранныеСтроки.Количество() = 0 Тогда
			СообщениеПользователю=			Новый СообщениеПользователю;
			СообщениеПользователю.Текст=	"Не выбраны контрагенты для отправки приглашений!";
			СообщениеПользователю.Сообщить();
			Возврат;
		КонецЕсли;
		
		ПараметрыФормы=	Новый Структура();
		ПараметрыФормы.Вставить("Заголовок", 	"Отправка приглашения");
		ПараметрыФормы.Вставить("Комментарий", 	"Предлагаем обмениваться электронными документами через систему "+Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы+".");
		ПараметрыФормы.Вставить("Режим", 		"ОтправкаПриглашения");
		
		МетодКлиента(,"ОткрытьФормуОбработкиМодально", "ФормаВводаКомментария", ПараметрыФормы, ЭтаФорма, "ОбработчикОткрытиеФормыВводаКомментария", ВыбранныеСтроки);

	КонецПроцедуры
	
	&НаКлиенте
	Процедура СнятьУстановитьПометки(Пометка)
		
		Для Каждого СтрокаТаблицыКонтрагентов Из ТаблицаКонтрагентов Цикл
			Если Пометка Тогда
				Если НЕ СтрокаТаблицыКонтрагентов.Пометка И СтрокаТаблицыКонтрагентов.МожноОтправитьПриглашение Тогда
					СтрокаТаблицыКонтрагентов.Пометка=	Пометка;
				КонецЕсли;
			Иначе
				СтрокаТаблицыКонтрагентов.Пометка=	Пометка;
			КонецЕсли;
		КонецЦикла;
		
		СинхронизироватьСтрокиВКэше();
		
		ИзменениеТаблицы=	Истина;
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура УстановитьКартинкуИЗаголовокКнопкиПометки(Пометка)
		
		Если Пометка Тогда
			Элементы.КнопкаСнятьУстановитьПометки.Картинка= 	БиблиотекаКартинок.УстановитьФлажки;
			Элементы.КнопкаСнятьУстановитьПометки.Заголовок=	"Снять пометку со всех контрагентов";
			ПометкаВсех=	Истина;
		Иначе
			Элементы.КнопкаСнятьУстановитьПометки.Картинка= 	БиблиотекаКартинок.СнятьФлажки;
			Элементы.КнопкаСнятьУстановитьПометки.Заголовок=	"Пометить всех контрагентов";
			ПометкаВсех=	Ложь;
		КонецЕсли;
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ОбработатьПометки(СбросПометок = Ложь)
		
		Если Элементы.КнопкаСнятьУстановитьПометки.Картинка= 	БиблиотекаКартинок.СнятьФлажки 
			И НЕ СбросПометок Тогда
			УстановитьКартинкуИЗаголовокКнопкиПометки(Истина);
			СнятьУстановитьПометки(Истина);
		Иначе
			УстановитьКартинкуИЗаголовокКнопкиПометки(Ложь);
			СнятьУстановитьПометки(Ложь);
		КонецЕсли;
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура СнятьУстановитьПометкиКоманда(Команда)
		
		ОбработатьПометки();
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ТаблицаКонтрагентовПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
		Отказ=	Истина;
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ТаблицаКонтрагентовПередУдалением(Элемент, Отказ)
		Отказ=	Истина;
	КонецПроцедуры
	
	&НаКлиенте
	Процедура Обновить(Команда)
		
		ИнициироватьОбновлениеСписка();
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура СтатусВзаимоотношенийПриИзменении(Элемент)
		
		ЗагрузитьТаблицуИзКэша();
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ОткрытьКарточкуКонтрагента()
		
		ТекущиеДанные= Элементы.ТаблицаКонтрагентов.ТекущиеДанные;
		
		Если ТекущиеДанные = Неопределено Тогда
			Возврат;
		КонецЕсли;
		
		Если ЗначениеЗаполнено(ТекущиеДанные.Ссылка) Тогда
			МетодКлиента(,"ОткрытьФормуОбъектаИБ", ТекущиеДанные.Ссылка);
		КонецЕсли;
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ТаблицаКонтрагентовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
		
		ОткрытьКарточкуКонтрагента();
		
	КонецПроцедуры
	
//} УПРАВЛЕНИЕ ФОРМОЙ
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//{ ОБРАБОТКА СОБЫТИЙ

	&НаКлиенте
	Процедура ОбработчикОткрытиеФормыВводаКомментария(РезультатЗакрытия, ВыбранныеСтроки) Экспорт
		
		Если НЕ РезультатЗакрытия = Неопределено Тогда
			
			СообщениеПользователю		= Новый СообщениеПользователю;
			КоличествоВыбранных			= ВыбранныеСтроки.Количество();
			НомерОбработанного			= 0;
			КоличествоУспешноОтправлено	= 0;
			
			Для каждого ВыбранныйКонтрагент Из ВыбранныеСтроки Цикл
				
				ОбработкаПрерыванияПользователя();
				
				НомерОбработанного =	НомерОбработанного + 1;
				
				Результат =	МетодКлиента("Модуль_Клиент", "ОтправитьПринятьПриглашениеКонтрагенту", Organization, ВыбранныйКонтрагент.CounteragentID, ВыбранныйКонтрагент.ИНН, РезультатЗакрытия.Комментарий, РезультатЗакрытия.ПутьКФайлу);

				Если НЕ Результат = Истина Тогда
					СообщениеПользователю.Текст = "" + НомерОбработанного + ". Не удалось отправить приглашение контрагенту: " + ВыбранныйКонтрагент.Наименование + ", ИНН " + ВыбранныйКонтрагент.ИНН;
					СообщениеПользователю.Сообщить();
				Иначе
					КоличествоУспешноОтправлено = КоличествоУспешноОтправлено + 1;
				КонецЕсли;
				
				МетодКлиента("Модуль_Клиент", "ПоказатьСостояниеОбработкиСписка"
				, НСтр("ru = 'Отправка приглашений контрагентам'")
				, НомерОбработанного
				, КоличествоВыбранных);
				
			КонецЦикла;
			
			ПоказатьПредупреждение(, "Успешно отправлено приглашений: " + КоличествоУспешноОтправлено + " из " + КоличествоВыбранных, 120, Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы);
			Если КоличествоУспешноОтправлено = КоличествоВыбранных Тогда
				Закрыть();
			КонецЕсли;
			
		КонецЕсли;
		
	КонецПроцедуры

//} ОБРАБОТКА СОБЫТИЙ
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//{ СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ
	
	&НаКлиенте
	Процедура СинхронизироватьСтрокиВКэше()
		
		Для каждого СтрокаТаблицыКонтрагентов Из ТаблицаКонтрагентов Цикл
			
			СтруктураСтроки=	Новый Структура;
			СтруктураСтроки.Вставить("ГУИД", 	СтрокаТаблицыКонтрагентов.ГУИД);
			СтруктураСтроки.Вставить("Пометка", СтрокаТаблицыКонтрагентов.Пометка);
			
			СинхронизироватьСтрокуВКэше(СтруктураСтроки);
			
		КонецЦикла;
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура СинхронизироватьСтрокуВКэше(СтруктураСтроки)
		
		НайденныеСтроки = ТаблицаКонтрагентовКэш.НайтиСтроки(Новый Структура("ГУИД", СтруктураСтроки.ГУИД));
		Для каждого НайденнаяСтрока Из НайденныеСтроки Цикл
			ЗаполнитьЗначенияСвойств(НайденнаяСтрока, СтруктураСтроки);
		КонецЦикла;
		
	КонецПроцедуры
	
	&НаСервереБезКонтекста
	Функция ПолучитьСписокРодителей(Родитель)
		
		МассивРодителей=	Новый Массив();
		
		Запрос=	Новый Запрос;
		Запрос.Текст=	
		"ВЫБРАТЬ
		|	Партнеры.Ссылка
		|ИЗ
		|	Справочник.Партнеры КАК Партнеры
		|ГДЕ
		|	ВЫБОР
		|			КОГДА &Родитель = ЗНАЧЕНИЕ(Справочник.Контрагенты.ПустаяСсылка)
		|				ТОГДА ИСТИНА
		|			ИНАЧЕ Партнеры.Ссылка В ИЕРАРХИИ (&Родитель)
		|		КОНЕЦ";
		Запрос.УстановитьПараметр("Родитель", Родитель);
		
		РезультатЗапроса=	Запрос.Выполнить();
		Выборка=			РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.Прямой);	
		
		Пока Выборка.Следующий() Цикл
			МассивРодителей.Добавить(Выборка.Ссылка);
		КонецЦикла;
		
		Возврат МассивРодителей;
		
	КонецФункции
	
	&НаСервереБезКонтекста
	Функция ПолучитьСписокКонтрагентовДляПроверки(ПоследняяСсылка, Знач Родитель, Знач МаркерКонфигурации)
		
		МассивИНН =	Новый Массив();
		
		Если ПоследняяСсылка = Неопределено Тогда
			Возврат МассивИНН;
		КонецЕсли;
		
		Запрос = Новый Запрос;
		
		Если МаркерКонфигурации = "УТ11" Тогда
			
			Запрос.Текст =
			"ВЫБРАТЬ ПЕРВЫЕ 50
			|	Контрагенты.Ссылка КАК Ссылка,
			|	Контрагенты.ИНН,
			|	Контрагенты.КодПоОКПО КАК Код,
			|	Контрагенты.Наименование,
			|	Контрагенты.КПП,
			|	Контрагенты.Партнер КАК Родитель
			|ИЗ
			|	Справочник.Контрагенты КАК Контрагенты
			|ГДЕ
			|	ВЫБОР
			|			КОГДА &ПоследняяСсылка = ЗНАЧЕНИЕ(Справочник.Контрагенты.ПустаяСсылка)
			|				ТОГДА ИСТИНА
			|			ИНАЧЕ Контрагенты.Ссылка > &ПоследняяСсылка
			|		КОНЕЦ
			|	И Контрагенты.Партнер В(&СписокРодителей)
			|
			|УПОРЯДОЧИТЬ ПО
			|	Ссылка";
				
			Запрос.УстановитьПараметр("СписокРодителей", ПолучитьСписокРодителей(Родитель));
		
		ИначеЕсли МаркерКонфигурации = "БП30" ИЛИ МаркерКонфигурации = "УНФ16" Тогда
		
			Запрос.Текст =
			"ВЫБРАТЬ ПЕРВЫЕ 50
			|	Контрагенты.Ссылка КАК Ссылка,
			|	Контрагенты.ИНН,
			|	Контрагенты.Код КАК Код,
			|	Контрагенты.Наименование,
			|	Контрагенты.КПП,
			|	Контрагенты.Родитель КАК Родитель
			|ИЗ
			|	Справочник.Контрагенты КАК Контрагенты
			|ГДЕ
			|	ВЫБОР
			|			КОГДА &ПоследняяСсылка = ЗНАЧЕНИЕ(Справочник.Контрагенты.ПустаяСсылка)
			|				ТОГДА ИСТИНА
			|			ИНАЧЕ Контрагенты.Ссылка > &ПоследняяСсылка
			|		КОНЕЦ
			|	И ВЫБОР
			|			КОГДА &Родитель = ЗНАЧЕНИЕ(Справочник.Контрагенты.ПустаяСсылка)
			|				ТОГДА ИСТИНА
			|			ИНАЧЕ Контрагенты.Родитель В ИЕРАРХИИ (&Родитель)
			|		КОНЕЦ
			|	И НЕ Контрагенты.ЭтоГруппа
			|
			|УПОРЯДОЧИТЬ ПО
			|	Ссылка";
				
			Запрос.УстановитьПараметр("Родитель", Родитель);
			
		ИначеЕсли МаркерКонфигурации = "БГУ20" Тогда
			
			Запрос.Текст =
			"ВЫБРАТЬ ПЕРВЫЕ 50
			|	Контрагенты.Ссылка КАК Ссылка,
			|	Контрагенты.ЮридическоеФизическоеЛицо.ИНН КАК ИНН,
			|	Контрагенты.Код КАК Код,
			|	Контрагенты.ЮридическоеФизическоеЛицо.Наименование КАК Наименование,
			|	ВЫБОР
			|		КОГДА Контрагенты.ЮридическоеФизическоеЛицо ССЫЛКА Справочник.ЮридическиеЛица
			|			ТОГДА Контрагенты.ЮридическоеФизическоеЛицо.КПП
			|		ИНАЧЕ """"
			|	КОНЕЦ КАК КПП,
			|	Контрагенты.Родитель КАК Родитель
			|ИЗ
			|	Справочник.Контрагенты КАК Контрагенты
			|ГДЕ
			|	ВЫБОР
			|			КОГДА &ПоследняяСсылка = ЗНАЧЕНИЕ(Справочник.Контрагенты.ПустаяСсылка)
			|				ТОГДА ИСТИНА
			|			ИНАЧЕ Контрагенты.Ссылка > &ПоследняяСсылка
			|		КОНЕЦ
			|	И ВЫБОР
			|			КОГДА &Родитель = ЗНАЧЕНИЕ(Справочник.Контрагенты.ПустаяСсылка)
			|				ТОГДА ИСТИНА
			|			ИНАЧЕ Контрагенты.Родитель В ИЕРАРХИИ (&Родитель)
			|		КОНЕЦ
			|	И НЕ Контрагенты.ЭтоГруппа
			|
			|УПОРЯДОЧИТЬ ПО
			|	Ссылка";
				
			Запрос.УстановитьПараметр("Родитель", Родитель);
			
		КонецЕсли;
		
		Запрос.УстановитьПараметр("ПоследняяСсылка", ПоследняяСсылка);
		
		
		РезультатЗапроса=	Запрос.Выполнить();
		
		Если РезультатЗапроса.Пустой() Тогда
			ПоследняяСсылка = Неопределено;
		Иначе
			
			ВыборкаРезультата =	РезультатЗапроса.Выбрать();
			Пока ВыборкаРезультата.Следующий() Цикл
				
				СтруктураЯчейки = Новый Структура;
				СтруктураЯчейки.Вставить("Ссылка", 			ВыборкаРезультата.Ссылка);
				СтруктураЯчейки.Вставить("ИНН", 			ВыборкаРезультата.ИНН);
				СтруктураЯчейки.Вставить("Код", 			ВыборкаРезультата.Код);
				СтруктураЯчейки.Вставить("Наименование", 	ВыборкаРезультата.Наименование);
				СтруктураЯчейки.Вставить("КПП", 			ВыборкаРезультата.КПП);
				СтруктураЯчейки.Вставить("Родитель", 		ВыборкаРезультата.Родитель);
				
				МассивИНН.Добавить(СтруктураЯчейки);
				
			КонецЦикла;
			
			ПоследняяСсылка = ВыборкаРезультата.Ссылка;
			
		КонецЕсли;
		
		Возврат МассивИНН;
		
	КонецФункции
	
	&НаСервереБезКонтекста
	Функция ПолучитьКоличествоОбрабатываемыхКонтрагентов(Знач Родитель, Знач МаркерКонфигурации)
		
		Запрос=	Новый Запрос;
		Если МаркерКонфигурации = "УТ11" Тогда
			
			Запрос.Текст=
				"ВЫБРАТЬ
				|	КОЛИЧЕСТВО(Контрагенты.Ссылка) КАК Количество
				|ИЗ
				|	Справочник.Контрагенты КАК Контрагенты
				|ГДЕ
				|	Контрагенты.Партнер В (&СписокРодителей)";
			
			Запрос.УстановитьПараметр("СписокРодителей", ПолучитьСписокРодителей(Родитель));
		
		ИначеЕсли МаркерКонфигурации = "БП30" ИЛИ МаркерКонфигурации = "БГУ20" ИЛИ МаркерКонфигурации = "УНФ16" Тогда
		
			Запрос.Текст=
				"ВЫБРАТЬ
				|	КОЛИЧЕСТВО(Контрагенты.Ссылка) КАК Количество
				|ИЗ
				|	Справочник.Контрагенты КАК Контрагенты
				|ГДЕ
				|	ВЫБОР
				|			КОГДА &Родитель = ЗНАЧЕНИЕ(Справочник.Контрагенты.ПустаяСсылка)
				|				ТОГДА ИСТИНА
				|			ИНАЧЕ Контрагенты.Родитель В ИЕРАРХИИ (&Родитель)
				|		КОНЕЦ
				|	И НЕ Контрагенты.ЭтоГруппа";
			
			Запрос.УстановитьПараметр("Родитель", Родитель);
			
		КонецЕсли;
		
		РезультатЗапроса= Запрос.Выполнить();
		
		Если РезультатЗапроса.Пустой() Тогда
			Возврат 0;
		Иначе
			Выборка= РезультатЗапроса.Выбрать();
			Выборка.Следующий();
			Возврат Выборка.Количество;
		КонецЕсли;
		
	КонецФункции
	
	&НаСервере
	Процедура УстановитьЗапросДереваРодителей()
		
		Если Объект.ПараметрыКлиентСервер.МаркерКонфигурации = "УТ11" Тогда
			
			// У платформы 8.3.6 не должно быть незаполненных источников данных в динамических списках 
			ДеревоРодителейУТ11.ОсновнаяТаблица 				= "Справочник.Партнеры";
			ДеревоРодителейУТ11.ДинамическоеСчитываниеДанных	= Истина;
			Элементы.ДеревоРодителейУТ11.Обновить();
			
		КонецЕсли;
		
	КонецПроцедуры
	
	&НаСервере
	Процедура ЗаполнитьСписокВыбораСтатусовВзаимоотношений()
		
		Для каждого Статус Из СписокСтатусов Цикл
			Элементы.СтатусВзаимоотношений.СписокВыбора.Добавить(Статус.Значение, Статус.Представление);
		КонецЦикла;
		
		Элементы.СтатусВзаимоотношений.СписокВыбора.Добавить("All", "Все статусы");
		
		СтатусВзаимоотношений=	"All";
		
	КонецПроцедуры
	
	&НаСервере
	Процедура ЗаполнитьСписки()
		
		УстановитьЗапросДереваРодителей();
		ЗаполнитьСписокВыбораСтатусовВзаимоотношений();
		
	КонецПроцедуры
	
	&НаКлиенте
	функция  ДопустимыйИНН(ИНН_Проверяемый)
		
		Проверка = (ИНН_Проверяемый);
		если (стрДлина(Проверка)<>10 и  стрДлина(Проверка)<>12) тогда 
			возврат ложь;
		ИначеЕсли лев(Проверка, 2)="00" тогда
			возврат ложь;
		КонецЕсли;
		
		для ц=0 по 9 цикл 
			симв = строка(ц);
			пока найти( Проверка, симв)>0 цикл 
				Проверка = стрЗаменить(Проверка, симв, "");
			КонецЦикла;	  
		Конеццикла;	
		
		возврат (проверка = "");
		
		
	КонецФункции
	
	&НаКлиенте
	Процедура ОбработатьМассивИНН(СтрокаИНН, МассивКонтрагентовДляПроверки)
		
		ТекстСостояния = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'Поиск контрагентов в базе %1'"), Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы);
		
		Для Каждого ЯчейкаМассива Из МассивКонтрагентовДляПроверки Цикл
			
			ОбработкаПрерыванияПользователя();
			
			Итерация = Итерация + 1;
			
			МетодКлиента("Модуль_Клиент", "ПоказатьСостояниеОбработкиСписка", ТекстСостояния, Итерация, КоличествоОбрабатываемыхКонтрагентов);
			
			НоваяСтрока = ТаблицаКонтрагентов.Добавить();
			
			ЗаполнитьЗначенияСвойств(НоваяСтрока, ЯчейкаМассива);
			
			НоваяСтрока.ГУИД		= НоваяСтрока.Ссылка.УникальныйИдентификатор();
			НоваяСтрока.ИНН			= СокрЛП(НоваяСтрока.ИНН);
			ИННКонтрагента			= НоваяСтрока.ИНН;
			НоваяСтрока.ИННВалидный	= ДопустимыйИНН(ИННКонтрагента);
			
			Если НоваяСтрока.ИННВалидный Тогда
				НоваяСтрока.СтатусРасшифровка	= "Загружается...";
				СтрокаИНН						= СтрокаИНН + ?(ПустаяСтрока(СтрокаИНН), ИННКонтрагента, "," + ИННКонтрагента);
			Иначе
				НоваяСтрока.СтатусРасшифровка	= "ИНН неверный";
				НоваяСтрока.ИННВалидный			= Ложь;
			КонецЕсли;
			
		КонецЦикла;
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ОбработатьИтемы(МассивИтемов, OrganizationInn)
		
		Для Каждого СтруктураИтема Из МассивИтемов Цикл
			
			ОбработкаПрерыванияПользователя();
			
			Если ЗначениеЗаполнено(СтруктураИтема.КПП) Тогда
				ПараметрыОтбора = Новый Структура("ИНН, КПП", СтруктураИтема.ИНН, СтруктураИтема.КПП);
			Иначе
				ПараметрыОтбора = Новый Структура("ИНН", СтруктураИтема.ИНН);
			КонецЕсли;
			
			НайденныеСтрокиКонтрагентов = ТаблицаКонтрагентов.НайтиСтроки(ПараметрыОтбора);
			
			МассивКодовКонтрагентов = Новый Массив;
			
			Для Каждого НайденнаяСтрока Из НайденныеСтрокиКонтрагентов Цикл
				
				Если НайденнаяСтрока.CounteragentID <> "" Тогда
					
					НайденныйКод = МассивКодовКонтрагентов.Найти(НайденнаяСтрока.Код);
					Если НайденныйКод <> Неопределено Тогда 
						Продолжить;
					КонецЕсли;
					
					МассивКодовКонтрагентов.Добавить(НайденнаяСтрока.Код);
					
					НоваяСтрока = ТаблицаКонтрагентов.Добавить();
										
					ЗаполнитьЗначенияСвойств(НоваяСтрока, НайденнаяСтрока, "Код, Наименование, ИНН, КПП, Ссылка, Родитель, ИННВалидный, ГУИД");
					
					Если НайденнаяСтрока.IsRoaming
						И НЕ СтруктураИтема.IsRoaming Тогда
						
						ДлинаПодстроки = 9;
						
						Если Прав(НайденнаяСтрока.Наименование, ДлинаПодстроки) = "(роуминг)" Тогда
							НоваяСтрока.Наименование = Лев(НайденнаяСтрока.Наименование, СтрДлина(НайденнаяСтрока.Наименование) - 9); 
						Иначе
							НоваяСтрока.Наименование = НайденнаяСтрока.Наименование;
						КонецЕсли;
											
					КонецЕсли; 
					
					НайденнаяСтрока = НоваяСтрока;
					
				КонецЕсли;
				
				СтатусВзаимоотношенийСКонтрагентом = "";
				
				Если СтруктураИтема.CounteragentIsNull Тогда
					НайденнаяСтрока.СтатусРасшифровка		= "Нет в " + Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы;
					НайденнаяСтрока.СтатусВзаимоотношений	= "Unknown";
				Иначе
					
					СтатусВзаимоотношенийСКонтрагентом = СтруктураИтема.СтатусВзаимоотношений;
					Если OrganizationInn = НайденнаяСтрока.ИНН Тогда 
						НайденнаяСтрока.МожноОтправитьПриглашение 	= Ложь;
						СтатусВзаимоотношенийСКонтрагентом 			= "IsOrganization"
					ИначеЕсли СтруктураИтема.IsLiquidated Тогда
						НайденнаяСтрока.МожноОтправитьПриглашение 	= Ложь;
						СтатусВзаимоотношенийСКонтрагентом 			= "Ликвидирован";
					ИначеЕсли НайденнаяСтрока.ИННВалидный
						И (СтатусВзаимоотношенийСКонтрагентом = "RejectsMe"
						ИЛИ СтатусВзаимоотношенийСКонтрагентом = "IsRejectedByMe" 
						ИЛИ СтатусВзаимоотношенийСКонтрагентом = "NotInCounteragentList") Тогда
						НайденнаяСтрока.МожноОтправитьПриглашение	= Истина;
						НайденнаяСтрока.Пометка						= ПометкаВсех;
					КонецЕсли;
					
					НайденнаяСтрока.СтатусРасшифровка		= РасшифровкаТекущегоСостоянияВзаимоотношений(СтатусВзаимоотношенийСКонтрагентом);
					НайденнаяСтрока.СтатусВзаимоотношений	= СтатусВзаимоотношенийСКонтрагентом;
					НайденнаяСтрока.CounteragentID			= СтруктураИтема.CounteragentId;
					НайденнаяСтрока.FnsParticipantId 		= СтруктураИтема.FnsParticipantId;
					НайденнаяСтрока.IsRoaming 				= СтруктураИтема.IsRoaming;
					
					Если СтруктураИтема.IsRoaming Тогда
						
						ДлинаПодстроки = 9;
						
						Если Прав(НайденнаяСтрока.Наименование, ДлинаПодстроки) = "(роуминг)" Тогда
							НайденнаяСтрока.Наименование = НайденнаяСтрока.Наименование;
						Иначе
							НайденнаяСтрока.Наименование = НайденнаяСтрока.Наименование + " (роуминг)";
						КонецЕсли;
																	
					КонецЕсли;
					
				КонецЕсли;
				
			КонецЦикла;
			
		КонецЦикла;
		
		ТаблицаКонтрагентов.Сортировать("Код, IsRoaming");
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ОбработатьCounteragentList()
		
		Попытка
			РезультатЗапроса = CounteragentList.Result;
		Исключение
			
			ПараметрыФормы = Новый Структура();
			ПараметрыФормы.Вставить("Заголовок", 		"Ошибка работы с модулем " + Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы);
			ПараметрыФормы.Вставить("ОписаниеОшибки", 	"Ошибка выполнения запроса");
			ПараметрыФормы.Вставить("Подробности", 		ОписаниеОшибки());
			
			МетодКлиента(,"ОткрытьФормуОбработкиМодально", "Форма_ВыводОшибки", ПараметрыФормы, ЭтаФорма);
			
			//останавливаем обработчик ожидания
			ПоследняяСсылка= Неопределено;
						
			Возврат;

		КонецПопытки;
		
		Если НЕ РезультатЗапроса = Неопределено Тогда
			
			МассивИтемов = Новый Массив();
			
			Для Индекс = 0 По РезультатЗапроса.Count - 1 Цикл
				
				ОбработкаПрерыванияПользователя();
				
				Item = РезультатЗапроса.GetItem(Индекс);
				
				Если Item.Counteragent = Неопределено Тогда
					CounteragentIsNull = Истина;
				Иначе
					CounteragentIsNull = Ложь; 
				КонецЕсли;
				
				КПП 				= "";
				IsRoaming 			= Ложь;
				IsLiquidated 		= Ложь;
				CounteragentID		= "";
				FnsParticipantId	= "";
				СтатусВзаимоотношений = "";
				
				Если НЕ CounteragentIsNull Тогда
					КПП 				= Item.Counteragent.kpp;
					IsRoaming 			= Item.Counteragent.IsRoaming;
					IsLiquidated 		= Item.Counteragent.IsLiquidated;
					CounteragentID 		= Item.Counteragent.Id;
					FnsParticipantId	= Item.Counteragent.FnsParticipantId;
					СтатусВзаимоотношений = Item.Counteragent.GetStatus();
				КонецЕсли;
								
				СтруктураИтема = Новый Структура;
				
				СтруктураИтема.Вставить("ИНН"					, Item.Inn);
				СтруктураИтема.Вставить("CounteragentIsNull"	, CounteragentIsNull);
				СтруктураИтема.Вставить("КПП"					, КПП);
				СтруктураИтема.Вставить("СтатусВзаимоотношений"	, СтатусВзаимоотношений);
				СтруктураИтема.Вставить("CounteragentID"		, CounteragentID);
				СтруктураИтема.Вставить("FnsParticipantId"		, FnsParticipantId);
				СтруктураИтема.Вставить("IsLiquidated"			, IsLiquidated);
				СтруктураИтема.Вставить("IsRoaming"				, IsRoaming);
				
				МассивИтемов.Добавить(СтруктураИтема);
				
			КонецЦикла;
			
			ОбработатьИтемы(МассивИтемов, Organization.Inn);
			
		КонецЕсли;
		
		CounteragentList = Неопределено;
		
	КонецПроцедуры
	
	&НаСервере
	Процедура ЗагрузитьТаблицуИзКэша()
		
		ТабКэш = РеквизитФормыВЗначение("ТаблицаКонтрагентовКэш");
		
		ТаблицаКонтрагентов.Очистить();
		Если НЕ СтатусВзаимоотношений = "All" Тогда
			НайденныеСтрокиКэша = ТабКэш.НайтиСтроки(Новый Структура("СтатусВзаимоотношений", СтатусВзаимоотношений));
			Для каждого НайденнаяСтрока Из НайденныеСтрокиКэша Цикл
				НоваяСтрока = ТаблицаКонтрагентов.Добавить();
				ЗаполнитьЗначенияСвойств(НоваяСтрока, НайденнаяСтрока);
			КонецЦикла;
		Иначе
			Для Каждого СтрокаКэша Из ТабКэш Цикл
				НоваяСтрока = ТаблицаКонтрагентов.Добавить();
				ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаКэша);
			КонецЦикла;
		КонецЕсли;
		
		Кэширование = Истина;
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ЗакэшироватьТаблицуКонтрагентов()
		
		ТаблицаКонтрагентовКэш.Очистить();
		Для Каждого СтрокаТаблицыКонтрагентов Из ТаблицаКонтрагентов Цикл
			НоваяСтрокаКэша = ТаблицаКонтрагентовКэш.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрокаКэша, СтрокаТаблицыКонтрагентов);
		КонецЦикла;
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ВыполнитьОтключениеОбработчика()
		
		ОтключитьОбработчикОжидания("ПодключаемыйОбработчикОбновитьСтатусРаботыСКА");
		ЗакэшироватьТаблицуКонтрагентов();
		ИнициированоОбновление=	Ложь;
		
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ЗаменитьСтатусЗагружаетсяНаСтатусНетВСервисе()
		
		СтатусОбновляется	 = "Загружается...";
		СтатусОператора		 = "Unknown";
		СтатусНетВСервисе	 = РасшифровкаТекущегоСостоянияВзаимоотношений(СтатусОператора);
		
		Для Каждого СтрокаТЧ Из ТаблицаКонтрагентов Цикл
			
			Если СтрокаТЧ.СтатусРасшифровка = СтатусОбновляется Тогда
				
				СтрокаТЧ.СтатусРасшифровка		= СтатусНетВСервисе;
				СтрокаТЧ.СтатусВзаимоотношений	= СтатусОператора;
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецПроцедуры
	
	&НаКлиенте
	Функция РасшифровкаТекущегоСостоянияВзаимоотношений(CurrentStatus) Экспорт
		
		НайденныйСтатус=	СписокСтатусов.НайтиПоЗначению(CurrentStatus);
		Если НЕ НайденныйСтатус = Неопределено Тогда
			Возврат НайденныйСтатус.Представление;
		Иначе
			Возврат "";
		КонецЕсли;
		
	КонецФункции
	
//} СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//{ ПОДКЛЮЧАЕМЫЕ ОБРАБОТЧИКИ

	&НаКлиенте
	Процедура ПодключаемыйОбработчикОбновитьСтатусРаботыСКА()
		
		Если CounteragentList = Неопределено Тогда
			
			СтрокаИНН =	"";
			
			ОбработкаПрерыванияПользователя();
			
			МассивКонтрагентовДляПроверки =	ПолучитьСписокКонтрагентовДляПроверки(ПоследняяСсылка, Родитель, Объект.ПараметрыКлиентСервер.МаркерКонфигурации);
			
			Если ИнициированоОбновление И НЕ ПоследняяСсылка = Неопределено Тогда
				ОбработатьМассивИНН(СтрокаИНН, МассивКонтрагентовДляПроверки);
			КонецЕсли;
				
			Если НЕ ПустаяСтрока(СтрокаИНН) Тогда
				CounteragentList = Organization.GetCounteragentListByInnList(СтрокаИНН);
			КонецЕсли;
			
		Иначе
			
			Если CounteragentList.IsCompleted Тогда
				ОбработатьCounteragentList();
			КонецЕсли;
			
		КонецЕсли;
		
		Если ПоследняяСсылка = Неопределено Тогда
			ВыполнитьОтключениеОбработчика();
			ЗаменитьСтатусЗагружаетсяНаСтатусНетВСервисе();
		Иначе
			ОтключитьОбработчикОжидания("ПодключаемыйОбработчикОбновитьСтатусРаботыСКА");
			ПодключитьОбработчикОжидания("ПодключаемыйОбработчикОбновитьСтатусРаботыСКА", 0.1, Истина);
		КонецЕсли;
		
	КонецПроцедуры

//} ПОДКЛЮЧАЕМЫЕ ОБРАБОТЧИКИ
////////////////////////////////////////////////////////////////////////////////