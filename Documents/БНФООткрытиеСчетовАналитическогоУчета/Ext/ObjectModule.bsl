﻿
&Вместо("ЗаписатьАналитическиеПризнакиСчетов")
Процедура pcru_ex_ЗаписатьАналитическиеПризнакиСчетов(ПараметрыПроведения, Отказ)
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	#Область КлючеваяАналитика
	
	КоличествоИспользуемыхКлючевыхАналитик = БНФОПроцедурыРасширеннойАналитикиПовтИсп.ПолучитьКоличествоИспользуемыхАналитик();
	
	// Ключевая аналитика.
	НаборЗаписей = РегистрыСведений.БНФОСоответствиеСчетовАналитическогоУчетаИАналитики.СоздатьНаборЗаписей();
	ТаблицаСчетов = НаборЗаписей.ВыгрузитьКолонки();
	
	// Заполним параметры получения ключа аналитики.
	ПараметрыАналитики = Новый Структура;
	Для Счетчик = 1 По КоличествоИспользуемыхКлючевыхАналитик Цикл
		ПараметрыАналитики.Вставить("Аналитика" + Формат(Счетчик, "ЧГ=0"));
	КонецЦикла;   
	
	ВидыАналитикТаблица = ПараметрыПроведения.ВидыАналитик;
	ВидыАналитикТаблица.Индексы.Добавить("КлючСтроки");
	ОтборСтруктура = Новый Структура("КлючСтроки", 0);
	
	ТаблицаАналитикПараметровОткрытия 	= ПолучитьТаблицуАналитикПараметровОткрытия(ПараметрыПроведения.СчетаУчета);
	ТаблицаКлючейАналитик				= Справочники.БНФОКлючиАналитикиУчетаПараметровОткрытия.КлючиАналитикиУчетаПараметровОткрытияСчетовАналитическогоУчетаТаблицыСчетов(ТаблицаАналитикПараметровОткрытия);	
	
	СоответствиеКлючейАналитикиПараметровОткрытия = Новый Соответствие;
	
	ИспользоватьПодразделенияВСчетахУчета = ПолучитьФункциональнуюОпцию("БНФОИспользоватьПодразделенияВСчетахУчета");
	Если НЕ ИспользоватьПодразделенияВСчетахУчета Тогда
		СтруктурнаяЕдиница = Организация;
	Иначе
		СтруктурнаяЕдиница = ?(ЗначениеЗаполнено(Подразделение), Подразделение, Организация);
	КонецЕсли;
	
	МассивСчетов = Новый Массив;
	// Заполним таблицу используемых счетов.
	Для каждого СтрокаСчетУчета из ПараметрыПроведения.СчетаУчета Цикл
		Если МассивСчетов.Найти(СтрокаСчетУчета.СчетАналитическогоУчета.Код) <> Неопределено Тогда
			 Продолжить;
		КонецЕсли; ;
		МассивСчетов.Добавить(СтрокаСчетУчета.СчетАналитическогоУчета.Код);
		
		Если НЕ СтрокаСчетУчета.ОткрыватьСчет Тогда
			Продолжить; 
		КонецЕсли;
		
		
		АналитикаПараметровОткрытияСтруктура = Новый Структура("ВидСчетаУчета, ГруппаФинансовогоУчета, Валюта, ПризнакДоверительногоУправления");
		АналитикаПараметровОткрытияСтруктура.ВидСчетаУчета						= СтрокаСчетУчета.ВидСчетаУчета;
		АналитикаПараметровОткрытияСтруктура.ГруппаФинансовогоУчета				= ?(ЗначениеЗаполнено(СтрокаСчетУчета.ГруппаФинансовогоУчета), СтрокаСчетУчета.ГруппаФинансовогоУчета, ГруппаФинансовогоУчета);
		АналитикаПараметровОткрытияСтруктура.Валюта								= СтрокаСчетУчета.ВалютаСчетаАналитическогоУчета;
		АналитикаПараметровОткрытияСтруктура.ПризнакДоверительногоУправления	= ПризнакДоверительногоУправления;
		
		НайденныеСтроки = ТаблицаКлючейАналитик.НайтиСтроки(АналитикаПараметровОткрытияСтруктура);
		АналитикаПараметровОткрытия = НайденныеСтроки[0].КлючАналитики;
		
		
		ТаблицаСчетовСтруктура = Новый Структура("АналитикаПараметровОткрытия");
		НайденныеСтроки = ТаблицаСчетов.НайтиСтроки(ТаблицаСчетовСтруктура);
		
			
			НоваяЗапись = ТаблицаСчетов.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяЗапись, СтрокаСчетУчета);
			
			НоваяЗапись.СтруктурнаяЕдиница = СтруктурнаяЕдиница;
			
			
			НоваяЗапись.АналитикаПараметровОткрытия = АналитикаПараметровОткрытия;
			
			СоответствиеКлючейАналитикиПараметровОткрытия.Вставить(АналитикаПараметровОткрытия, АналитикаПараметровОткрытияСтруктура);
			
			ОтборСтруктура.КлючСтроки = СтрокаСчетУчета.КлючСтроки;
			ТекущиеВидыАналитик = ВидыАналитикТаблица.НайтиСтроки(ОтборСтруктура);
			
			КоличествоТекущиеВидыАналитик = ТекущиеВидыАналитик.Количество();
			
			Для Счетчик = 1 По КоличествоИспользуемыхКлючевыхАналитик Цикл
				
				Если Счетчик <= КоличествоТекущиеВидыАналитик Тогда
					ПараметрыАналитики["Аналитика" + Формат(Счетчик, "ЧГ=0")] = ТекущиеВидыАналитик[Счетчик-1].ЗначениеАналитики;
				Иначе
					ПараметрыАналитики["Аналитика" + Формат(Счетчик, "ЧГ=0")] = Неопределено;
				КонецЕсли;
				
			КонецЦикла;                                   
			
			НоваяЗапись.Аналитика = БНФОПроцедурыРасширеннойАналитики.ЗначениеКлючаАналитики(ПараметрыАналитики, "БНФОАналитикаСчетовАналитическогоУчета", "БНФОКлючиАналитикиУчетаСчетовАналитическогоУчета");
			
			НоваяЗапись.Документ = ЭтотОбъект.Ссылка;
			
		
	КонецЦикла;   
	
	
	Попытка
		НаборЗаписей.Загрузить(ТаблицаСчетов);     
		НаборЗаписей.Записать(Ложь);
	Исключение
		ШаблонСообщения = НСтр("ru = 'Не удалось сохранить настройку счетов:
		|%1'");
		ОписаниеОшибок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонСообщения, ОписаниеОшибки());
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ОписаниеОшибок, , , , Отказ);
		Возврат;
	КонецПопытки;                                             
	
	#КонецОбласти
	
	#Область ОсновнаяАналитика
	
	СохранитьДанныеАналитики();
	
	#КонецОбласти
	
	#Область ПарныеСчета
	
	ТаблицаАналитикПараметровОткрытия 	= ПолучитьТаблицуАналитикПараметровОткрытия(ПараметрыПроведения.СчетаУчета);
	ТаблицаКлючейАналитик				= Справочники.БНФОКлючиАналитикиУчетаПараметровОткрытия.КлючиАналитикиУчетаПараметровОткрытияСчетовАналитическогоУчетаТаблицыСчетов(ТаблицаАналитикПараметровОткрытия);	
	Реквизиты = ПараметрыПроведения.Реквизиты[0];	
	
	// Установим парные счета.
	НаборЗаписей = РегистрыСведений.БНФОПарныеСчетаАналитическогоУчета.СоздатьНаборЗаписей();
	
	Для каждого СтрокаТаблицы из ТаблицаСчетов Цикл
		
		ПарныеАктивныеВидыСчетовРеглУчета = БНФОПроцедурыРасширеннойАналитикиПовтИсп.ПарныеАктивныеВидыСчетовРеглУчета();
		
		ПарныйВидУчетаПассивный = ПарныеАктивныеВидыСчетовРеглУчета.Получить(СтрокаТаблицы.ВидСчетаУчета);
		
		Если ПарныйВидУчетаПассивный <> Неопределено Тогда
			
			// Убираем запись дублей в регистр
			СтрокаТаблицыПроверка = ТаблицаСчетов.Найти(СтрокаТаблицы.СчетАналитическогоУчета);
			Если ТаблицаСчетов.Индекс(СтрокаТаблицыПроверка) < ТаблицаСчетов.Индекс(СтрокаТаблицы) Тогда
				Продолжить;
			КонецЕсли;
			
			АналитикаПараметровОткрытияСтруктура = СоответствиеКлючейАналитикиПараметровОткрытия.Получить(СтрокаТаблицы.АналитикаПараметровОткрытия);
			ОтборАналитикаПараметровОткрытияСтруктура = Новый Структура("ВидСчетаУчета, ГруппаФинансовогоУчета, Валюта, ПризнакДоверительногоУправления");
			ЗаполнитьЗначенияСвойств(ОтборАналитикаПараметровОткрытияСтруктура, АналитикаПараметровОткрытияСтруктура);
			
			ОтборАналитикаПараметровОткрытияСтруктура.ВидСчетаУчета = ПарныйВидУчетаПассивный; // поиск по парному виду счета учета
			
			ТекущаяГруппаФинансовогоУчета = АналитикаПараметровОткрытияСтруктура.ГруппаФинансовогоУчета;
			ТекущаяГруппаФинансовогоУчета = ?(ЗначениеЗаполнено(ТекущаяГруппаФинансовогоУчета), ТекущаяГруппаФинансовогоУчета, Реквизиты.ГруппаФинансовогоУчета);
			
			// Если присутствуют парные символы ОФР, выполним поиск по парной группе финансового учета.
			Если ТипЗнч(ТекущаяГруппаФинансовогоУчета) = Тип("СправочникСсылка.БНФОГруппыФинансовогоУчетаДоходовРасходов") Тогда
				
				ПарнаяТекущаяГруппаФинансовогоУчета = БНФОБухгалтерскийУчетВызовСервераПовтИсп.ПолучитьПарнуюГруппуУчетаДоходовИРасходов(Неопределено ,ТекущаяГруппаФинансовогоУчета);
				
				Если ЗначениеЗаполнено(ПарнаяТекущаяГруппаФинансовогоУчета) Тогда
					ОтборАналитикаПараметровОткрытияСтруктура.ГруппаФинансовогоУчета = ПарнаяТекущаяГруппаФинансовогоУчета;
				КонецЕсли;				
				
			КонецЕсли;
			
			НайденныеСтроки = ТаблицаКлючейАналитик.НайтиСтроки(ОтборАналитикаПараметровОткрытияСтруктура);
			АналитикаПараметровОткрытияПарногоСчета = НайденныеСтроки[0].КлючАналитики;
			
			ОтборПарныхСчетов = Новый Структура("СтруктурнаяЕдиница, Аналитика, АналитикаПараметровОткрытия");
			ЗаполнитьЗначенияСвойств(ОтборПарныхСчетов, СтрокаТаблицы);
			ОтборПарныхСчетов.АналитикаПараметровОткрытия = АналитикаПараметровОткрытияПарногоСчета;
			
			СтрокиПарныхСчетов = ТаблицаСчетов.НайтиСтроки(ОтборПарныхСчетов);
			Если СтрокиПарныхСчетов.Количество() Тогда
				
				СчетАктивныйВладелец = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(СтрокаТаблицы.СчетАналитическогоУчета, "Владелец");
				
				НоваяЗапись = НаборЗаписей.Добавить();
				НоваяЗапись.Организация = Организация;
				НоваяЗапись.СчетАктивный = СтрокаТаблицы.СчетАналитическогоУчета;
				НоваяЗапись.СчетПассивный = СтрокиПарныхСчетов[0].СчетАналитическогоУчета; 
				НоваяЗапись.СворачиватьВзаиморасчеты = БНФОБухгалтерскийУчетВызовСервераПовтИсп.ПолучитьПризнакСверткиВзаиморасчетовДляСчета(СчетАктивныйВладелец);
				НоваяЗапись.Документ = Ссылка;
				
			КонецЕсли;   
		КонецЕсли;       
	КонецЦикла;
	
	Попытка
		НаборЗаписей.Записать(Ложь);
	Исключение
		ШаблонСообщения = НСтр("ru = 'Не удалось сохранить настройку счетов:
		|%1'");
		ОписаниеОшибок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонСообщения, ОписаниеОшибки());
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ОписаниеОшибок, , , , Отказ);
		Возврат;
	КонецПопытки;
	
	#КонецОбласти                             
	
	#Область СчетаСПОД
	
	// Установим счета доходов/расходов и СПОД.
	НаборЗаписей = РегистрыСведений.БНФОСоответствиеСчетовСПОД.СоздатьНаборЗаписей();
	
	ТаблицаАналитикПараметровОткрытия    = ПолучитьТаблицуАналитикПараметровОткрытия(ПараметрыПроведения.СчетаУчета);
	ТаблицаКлючейАналитик            = Справочники.БНФОКлючиАналитикиУчетаПараметровОткрытия.КлючиАналитикиУчетаПараметровОткрытияСчетовАналитическогоУчетаТаблицыСчетов(ТаблицаАналитикПараметровОткрытия);   
	
	СвязанныеСПОД = Перечисления.БНФОВидыСчетовРеглУчета.СвязанныеСПОДВидыСчетовРеглУчета();
	
	Для каждого СтрокаТаблицы из ТаблицаСчетов Цикл
		
		ВидСчетаУчетаСПОД = СвязанныеСПОД.Получить(СтрокаТаблицы.ВидСчетаУчета);
		
		Если ВидСчетаУчетаСПОД <> Неопределено Тогда
			
			АналитикаПараметровОткрытияСтруктура = СоответствиеКлючейАналитикиПараметровОткрытия.Получить(СтрокаТаблицы.АналитикаПараметровОткрытия);
			ОтборАналитикаПараметровОткрытияСтруктура = Новый Структура("ВидСчетаУчета, ГруппаФинансовогоУчета, Валюта, ПризнакДоверительногоУправления");
			ЗаполнитьЗначенияСвойств(ОтборАналитикаПараметровОткрытияСтруктура, АналитикаПараметровОткрытияСтруктура);
			ОтборАналитикаПараметровОткрытияСтруктура.ВидСчетаУчета = ВидСчетаУчетаСПОД;
			
			НайденныеСтроки = ТаблицаКлючейАналитик.НайтиСтроки(ОтборАналитикаПараметровОткрытияСтруктура);
			
			Если НайденныеСтроки.Количество() = 0 Тогда
				Продолжить;
			КонецЕсли;
			
			АналитикаПараметровОткрытияПарногоСчета = НайденныеСтроки[0].КлючАналитики;
			
			ОтборПарныхСчетовСПОД = Новый Структура("СтруктурнаяЕдиница, Аналитика, АналитикаПараметровОткрытия");
			ЗаполнитьЗначенияСвойств(ОтборПарныхСчетовСПОД, СтрокаТаблицы);
			ОтборПарныхСчетовСПОД.АналитикаПараметровОткрытия = АналитикаПараметровОткрытияПарногоСчета;
			
			СтрокиПарныхСчетовСПОД = ТаблицаСчетов.НайтиСтроки(ОтборПарныхСчетовСПОД);
			Если СтрокиПарныхСчетовСПОД.Количество() Тогда
				
				НоваяЗапись = НаборЗаписей.Добавить();
				НоваяЗапись.Организация = Организация;
				НоваяЗапись.СчетДоходовРасходов = СтрокаТаблицы.СчетАналитическогоУчета;
				НоваяЗапись.СчетСПОД = СтрокиПарныхСчетовСПОД[0].СчетАналитическогоУчета; 
				НоваяЗапись.Документ = Ссылка;
				
			КонецЕсли;   
			
		КонецЕсли;       
		
	КонецЦикла;
	
	Попытка
		НаборЗаписей.Записать(Ложь);
	Исключение
		ШаблонСообщения = НСтр("ru = 'Не удалось сохранить настройку счетов:
		|%1'");
		ОписаниеОшибок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонСообщения, ОписаниеОшибки());
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ОписаниеОшибок, , , , Отказ);
		Возврат;
	КонецПопытки;              
	
	#КонецОбласти
	
	// {Исключить ПРОФ}
	#Область СведенияПоСрокамЗакрытия
	
	НаборЗаписей = РегистрыСведений.БНФОСрокиСчетовАналитическогоУчета.СоздатьНаборЗаписей();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	СчетаУчета.СчетУчета,
	|	СчетаУчета.СчетАналитическогоУчета,
	|	СчетаУчета.ДатаОткрытия
	|ПОМЕСТИТЬ ВТ_СчетаУчета
	|ИЗ
	|	&СчетаУчета КАК СчетаУчета
	|ГДЕ
	|	СчетаУчета.ОткрыватьСчет
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	СчетаУчета.СчетУчета,
	|	СчетаУчета.СчетАналитическогоУчета,
	|	СчетаУчета.ДатаОткрытия,
	|	ЕСТЬNULL(НастройкиЗакрытияСчетовАналитическогоУчета.ПолитикаЗакрытия, НастройкиЗакрытияСчетовАналитическогоУчетаПоВсемОрганизациям.ПолитикаЗакрытия) КАК ПолитикаЗакрытия
	|ПОМЕСТИТЬ ВТ_ПолитикиЗакрытия
	|ИЗ
	|	ВТ_СчетаУчета КАК СчетаУчета
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.БНФОНастройкиЗакрытияСчетовАналитическогоУчета КАК НастройкиЗакрытияСчетовАналитическогоУчета
	|		ПО СчетаУчета.СчетУчета = НастройкиЗакрытияСчетовАналитическогоУчета.Счет
	|			И (НастройкиЗакрытияСчетовАналитическогоУчета.Организация = &Организация)
	|			И (НЕ НастройкиЗакрытияСчетовАналитическогоУчета.ПолитикаЗакрытия.Недействителен)
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.БНФОНастройкиЗакрытияСчетовАналитическогоУчета КАК НастройкиЗакрытияСчетовАналитическогоУчетаПоВсемОрганизациям
	|		ПО СчетаУчета.СчетУчета = НастройкиЗакрытияСчетовАналитическогоУчетаПоВсемОрганизациям.Счет
	|			И (НастройкиЗакрытияСчетовАналитическогоУчетаПоВсемОрганизациям.Организация = ЗНАЧЕНИЕ(Справочник.Организации.ПустаяСсылка))
	|			И (НЕ НастройкиЗакрытияСчетовАналитическогоУчетаПоВсемОрганизациям.ПолитикаЗакрытия.Недействителен)
	|ГДЕ
	|	НЕ ЕСТЬNULL(НастройкиЗакрытияСчетовАналитическогоУчета.ПолитикаЗакрытия, НастройкиЗакрытияСчетовАналитическогоУчетаПоВсемОрганизациям.ПолитикаЗакрытия) ЕСТЬ NULL 
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПолитикиЗакрытия.СчетУчета,
	|	ПолитикиЗакрытия.СчетАналитическогоУчета,
	|	ПолитикиЗакрытия.ДатаОткрытия,
	|	ДОБАВИТЬКДАТЕ(ДОБАВИТЬКДАТЕ(ПолитикиЗакрытия.ДатаОткрытия, МЕСЯЦ, ПолитикиЗакрытия.ПолитикаЗакрытия.ПериодДействияСчета), ДЕНЬ, -1) КАК СрокДействия,
	|	ПолитикиЗакрытия.ПолитикаЗакрытия,
	|	&ДокументОткрытия КАК Документ
	|ИЗ
	|	ВТ_ПолитикиЗакрытия КАК ПолитикиЗакрытия";
	
	Запрос.УстановитьПараметр("Организация",		Организация);
	Запрос.УстановитьПараметр("СчетаУчета",	 		ПараметрыПроведения.СчетаУчета);
	Запрос.УстановитьПараметр("ДокументОткрытия",	Ссылка);
	
	ТаблицаЗаписей = Запрос.Выполнить().Выгрузить();
	
	Попытка
		НаборЗаписей.Загрузить(ТаблицаЗаписей);     
		НаборЗаписей.Записать(Ложь);
	Исключение
		ШаблонСообщения = НСтр("ru = 'Не удалось записать регистр ""Сроки счетов аналитического учета"":
		|%1'");
		ОписаниеОшибок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонСообщения, ОписаниеОшибки());
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ОписаниеОшибок, , , , Отказ);
		Возврат;
	КонецПопытки;                                             
	
	#КонецОбласти
	// {/Исключить ПРОФ}
	
КонецПроцедуры

//&Вместо("ПередЗаписью")
//Процедура pcru_ex_ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
//	
//	Если ОбменДанными.Загрузка Тогда
//		Возврат;
//	КонецЕсли;	
//	
//	Для каждого СтрокаСчетУчета ИЗ СчетаУчета Цикл
//		Если НЕ ЗначениеЗаполнено(СтрокаСчетУчета.ДатаОткрытия) Тогда 		 		
//			СтрокаСчетУчета.ДатаОткрытия = Дата;
//		КонецЕсли;	
//	КонецЦикла;
//	
//	Если НЕ ПолучитьФункциональнуюОпцию("БНФОИспользоватьПризнакДоверительногоУправления") Тогда
//		ПризнакДоверительногоУправления = Неопределено;	
//	КонецЕсли;
//	
//	Если РежимЗаписи = РежимЗаписиДокумента.Проведение 
//		И НЕ ДополнительныеСвойства.Свойство("ПропуститьФормированиеСчетовАналитическогоУчета") Тогда
//		
//		//	СоздатьСчетаАналитическогоУчета(Отказ);
//		//	Если НЕ Отказ Тогда
//		ДополнительныеСвойства.Вставить("ПропуститьФормированиеСчетовАналитическогоУчета");
//		//	КонецЕсли;
//		
//	КонецЕсли;
//	
//	ПредставлениеГруппыФинансовогоУчета = Документы.БНФООткрытиеСчетовАналитическогоУчета.ПолучитьТекстГруппыФинансовогоУчета(ЭтотОбъект);
//	
//	// Начало изменений (Аудит-Эскорт, НСВ, 18.01.2017) >>
//	АЭ_СинхронизироватьПометкуУдаленияЛицевыхСчетов(Отказ);
//	// Конец изменений (Аудит-Эскорт, НСВ, 18.01.2017) <<
//	
//КонецПроцедуры

////&Вместо("ЗаписатьАналитическиеПризнакиСчетов")
//Процедура pcru_ex_ЗаписатьАналитическиеПризнакиСчетов(ПараметрыПроведения, Отказ)
//	
//	Если Отказ Тогда
//		Возврат;
//	КонецЕсли;
//	
//	#Область КлючеваяАналитика
//	
//	КоличествоИспользуемыхКлючевыхАналитик = БНФОПроцедурыРасширеннойАналитикиПовтИсп.ПолучитьКоличествоИспользуемыхАналитик();
//	
//	// Ключевая аналитика.
//	НаборЗаписей = РегистрыСведений.БНФОСоответствиеСчетовАналитическогоУчетаИАналитики.СоздатьНаборЗаписей();
//	ТаблицаСчетов = НаборЗаписей.ВыгрузитьКолонки();
//	
//	// Заполним параметры получения ключа аналитики.
//	ПараметрыАналитики = Новый Структура;
//	Для Счетчик = 1 По КоличествоИспользуемыхКлючевыхАналитик Цикл
//		ПараметрыАналитики.Вставить("Аналитика" + Формат(Счетчик, "ЧГ=0"));
//	КонецЦикла;   
//	
//	ВидыАналитикТаблица = ПараметрыПроведения.ВидыАналитик;
//	ВидыАналитикТаблица.Индексы.Добавить("КлючСтроки");
//	ОтборСтруктура = Новый Структура("КлючСтроки", 0);
//	
//	ТаблицаАналитикПараметровОткрытия 	= ПолучитьТаблицуАналитикПараметровОткрытия(ПараметрыПроведения.СчетаУчета);
//	ТаблицаКлючейАналитик				= Справочники.БНФОКлючиАналитикиУчетаПараметровОткрытия.КлючиАналитикиУчетаПараметровОткрытияСчетовАналитическогоУчетаТаблицыСчетов(ТаблицаАналитикПараметровОткрытия);	
//	
//	СоответствиеКлючейАналитикиПараметровОткрытия = Новый Соответствие;
//	
//	ИспользоватьПодразделенияВСчетахУчета = ПолучитьФункциональнуюОпцию("БНФОИспользоватьПодразделенияВСчетахУчета");
//	Если НЕ ИспользоватьПодразделенияВСчетахУчета Тогда
//		СтруктурнаяЕдиница = Организация;
//	Иначе
//		СтруктурнаяЕдиница = ?(ЗначениеЗаполнено(Подразделение), Подразделение, Организация);
//	КонецЕсли;
//	
//	// Заполним таблицу используемых счетов.
//	Для каждого СтрокаСчетУчета из ПараметрыПроведения.СчетаУчета Цикл
//		
//		Если НЕ СтрокаСчетУчета.ОткрыватьСчет Тогда
//			Продолжить; 
//		КонецЕсли;
//		
//		НоваяЗапись = ТаблицаСчетов.Добавить();
//		ЗаполнитьЗначенияСвойств(НоваяЗапись, СтрокаСчетУчета);
//		
//		НоваяЗапись.СтруктурнаяЕдиница = СтруктурнаяЕдиница;
//		
//		АналитикаПараметровОткрытияСтруктура = Новый Структура("ВидСчетаУчета, ГруппаФинансовогоУчета, Валюта, ПризнакДоверительногоУправления");
//		АналитикаПараметровОткрытияСтруктура.ВидСчетаУчета						= СтрокаСчетУчета.ВидСчетаУчета;
//		АналитикаПараметровОткрытияСтруктура.ГруппаФинансовогоУчета				= ?(ЗначениеЗаполнено(СтрокаСчетУчета.ГруппаФинансовогоУчета), СтрокаСчетУчета.ГруппаФинансовогоУчета, ГруппаФинансовогоУчета);
//		АналитикаПараметровОткрытияСтруктура.Валюта								= СтрокаСчетУчета.ВалютаСчетаАналитическогоУчета;
//		АналитикаПараметровОткрытияСтруктура.ПризнакДоверительногоУправления	= ПризнакДоверительногоУправления;
//		
//		НайденныеСтроки = ТаблицаКлючейАналитик.НайтиСтроки(АналитикаПараметровОткрытияСтруктура);
//		//+asevryugin@PCRU.LOCAL, 2020-09-23 09:56:25
//		Если НайденныеСтроки.Количество() = 0 Тогда
//			Возврат;
//		КонецЕсли;
//		//+/asevryugin@PCRU.LOCAL, 2020-09-23 09:56:25
//		
//		АналитикаПараметровОткрытия = НайденныеСтроки[0].КлючАналитики;
//		
//		НоваяЗапись.АналитикаПараметровОткрытия = АналитикаПараметровОткрытия;
//		
//		СоответствиеКлючейАналитикиПараметровОткрытия.Вставить(АналитикаПараметровОткрытия, АналитикаПараметровОткрытияСтруктура);
//		
//		ОтборСтруктура.КлючСтроки = СтрокаСчетУчета.КлючСтроки;
//		ТекущиеВидыАналитик = ВидыАналитикТаблица.НайтиСтроки(ОтборСтруктура);
//		
//		КоличествоТекущиеВидыАналитик = ТекущиеВидыАналитик.Количество();
//		
//		Для Счетчик = 1 По КоличествоИспользуемыхКлючевыхАналитик Цикл
//			
//			Если Счетчик <= КоличествоТекущиеВидыАналитик Тогда
//				ПараметрыАналитики["Аналитика" + Формат(Счетчик, "ЧГ=0")] = ТекущиеВидыАналитик[Счетчик-1].ЗначениеАналитики;
//			Иначе
//				ПараметрыАналитики["Аналитика" + Формат(Счетчик, "ЧГ=0")] = Неопределено;
//			КонецЕсли;
//			
//		КонецЦикла;                                   
//		
//		НоваяЗапись.Аналитика = БНФОПроцедурыРасширеннойАналитики.ЗначениеКлючаАналитики(ПараметрыАналитики, "БНФОАналитикаСчетовАналитическогоУчета", "БНФОКлючиАналитикиУчетаСчетовАналитическогоУчета");
//		
//		НоваяЗапись.Документ = ЭтотОбъект.Ссылка;
//		
//	КонецЦикла;   
//	
//	Попытка
//		НаборЗаписей.Загрузить(ТаблицаСчетов);     
//		НаборЗаписей.Записать(Ложь);
//	Исключение
//		ШаблонСообщения = НСтр("ru = 'Не удалось сохранить настройку счетов:
//		|%1'");
//		ОписаниеОшибок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонСообщения, ОписаниеОшибки());
//		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ОписаниеОшибок, , , , Отказ);
//		Возврат;
//	КонецПопытки;                                             
//	
//	#КонецОбласти
//	
//	#Область ОсновнаяАналитика
//	
//	СохранитьДанныеАналитики();
//	
//	#КонецОбласти
//	
//	#Область ПарныеСчета
//	
//	ТаблицаАналитикПараметровОткрытия 	= ПолучитьТаблицуАналитикПараметровОткрытия(ПараметрыПроведения.СчетаУчета);
//	ТаблицаКлючейАналитик				= Справочники.БНФОКлючиАналитикиУчетаПараметровОткрытия.КлючиАналитикиУчетаПараметровОткрытияСчетовАналитическогоУчетаТаблицыСчетов(ТаблицаАналитикПараметровОткрытия);	
//	Реквизиты = ПараметрыПроведения.Реквизиты[0];	
//	
//	// Установим парные счета.
//	НаборЗаписей = РегистрыСведений.БНФОПарныеСчетаАналитическогоУчета.СоздатьНаборЗаписей();
//	
//	Для каждого СтрокаТаблицы из ТаблицаСчетов Цикл
//		
//		ПарныеАктивныеВидыСчетовРеглУчета = БНФОПроцедурыРасширеннойАналитикиПовтИсп.ПарныеАктивныеВидыСчетовРеглУчета();
//		
//		ПарныйВидУчетаПассивный = ПарныеАктивныеВидыСчетовРеглУчета.Получить(СтрокаТаблицы.ВидСчетаУчета);
//		
//		Если ПарныйВидУчетаПассивный <> Неопределено Тогда
//			
//			// Убираем запись дублей в регистр
//			СтрокаТаблицыПроверка = ТаблицаСчетов.Найти(СтрокаТаблицы.СчетАналитическогоУчета);
//			Если ТаблицаСчетов.Индекс(СтрокаТаблицыПроверка) < ТаблицаСчетов.Индекс(СтрокаТаблицы) Тогда
//				Продолжить;
//			КонецЕсли;
//			
//			АналитикаПараметровОткрытияСтруктура = СоответствиеКлючейАналитикиПараметровОткрытия.Получить(СтрокаТаблицы.АналитикаПараметровОткрытия);
//			ОтборАналитикаПараметровОткрытияСтруктура = Новый Структура("ВидСчетаУчета, ГруппаФинансовогоУчета, Валюта, ПризнакДоверительногоУправления");
//			ЗаполнитьЗначенияСвойств(ОтборАналитикаПараметровОткрытияСтруктура, АналитикаПараметровОткрытияСтруктура);
//			
//			ОтборАналитикаПараметровОткрытияСтруктура.ВидСчетаУчета = ПарныйВидУчетаПассивный; // поиск по парному виду счета учета
//			
//			ТекущаяГруппаФинансовогоУчета = АналитикаПараметровОткрытияСтруктура.ГруппаФинансовогоУчета;
//			ТекущаяГруппаФинансовогоУчета = ?(ЗначениеЗаполнено(ТекущаяГруппаФинансовогоУчета), ТекущаяГруппаФинансовогоУчета, Реквизиты.ГруппаФинансовогоУчета);
//			
//			// Если присутствуют парные символы ОФР, выполним поиск по парной группе финансового учета.
//			Если ТипЗнч(ТекущаяГруппаФинансовогоУчета) = Тип("СправочникСсылка.БНФОГруппыФинансовогоУчетаДоходовРасходов") Тогда
//				
//				ПарнаяТекущаяГруппаФинансовогоУчета = БНФОБухгалтерскийУчетВызовСервераПовтИсп.ПолучитьПарнуюГруппуУчетаДоходовИРасходов(Неопределено ,ТекущаяГруппаФинансовогоУчета);
//				
//				Если ЗначениеЗаполнено(ПарнаяТекущаяГруппаФинансовогоУчета) Тогда
//					ОтборАналитикаПараметровОткрытияСтруктура.ГруппаФинансовогоУчета = ПарнаяТекущаяГруппаФинансовогоУчета;
//				КонецЕсли;				
//				
//			КонецЕсли;
//			
//			НайденныеСтроки = ТаблицаКлючейАналитик.НайтиСтроки(ОтборАналитикаПараметровОткрытияСтруктура);
//			АналитикаПараметровОткрытияПарногоСчета = НайденныеСтроки[0].КлючАналитики;
//			
//			ОтборПарныхСчетов = Новый Структура("СтруктурнаяЕдиница, Аналитика, АналитикаПараметровОткрытия");
//			ЗаполнитьЗначенияСвойств(ОтборПарныхСчетов, СтрокаТаблицы);
//			ОтборПарныхСчетов.АналитикаПараметровОткрытия = АналитикаПараметровОткрытияПарногоСчета;
//			
//			СтрокиПарныхСчетов = ТаблицаСчетов.НайтиСтроки(ОтборПарныхСчетов);
//			Если СтрокиПарныхСчетов.Количество() Тогда
//				
//				СчетАктивныйВладелец = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(СтрокаТаблицы.СчетАналитическогоУчета, "Владелец");
//				
//				НоваяЗапись = НаборЗаписей.Добавить();
//				НоваяЗапись.Организация = Организация;
//				НоваяЗапись.СчетАктивный = СтрокаТаблицы.СчетАналитическогоУчета;
//				НоваяЗапись.СчетПассивный = СтрокиПарныхСчетов[0].СчетАналитическогоУчета; 
//				НоваяЗапись.СворачиватьВзаиморасчеты = БНФОБухгалтерскийУчетВызовСервераПовтИсп.ПолучитьПризнакСверткиВзаиморасчетовДляСчета(СчетАктивныйВладелец);
//				НоваяЗапись.Документ = Ссылка;
//				
//			КонецЕсли;   
//		КонецЕсли;       
//	КонецЦикла;
//	
//	Попытка
//		НаборЗаписей.Записать(Ложь);
//	Исключение
//		ШаблонСообщения = НСтр("ru = 'Не удалось сохранить настройку счетов:
//		|%1'");
//		ОписаниеОшибок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонСообщения, ОписаниеОшибки());
//		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ОписаниеОшибок, , , , Отказ);
//		Возврат;
//	КонецПопытки;
//	
//	#КонецОбласти                             
//	
//	#Область СчетаСПОД
//	
//	// Установим счета доходов/расходов и СПОД.
//	НаборЗаписей = РегистрыСведений.БНФОСоответствиеСчетовСПОД.СоздатьНаборЗаписей();
//	
//	ТаблицаАналитикПараметровОткрытия    = ПолучитьТаблицуАналитикПараметровОткрытия(ПараметрыПроведения.СчетаУчета);
//	ТаблицаКлючейАналитик            = Справочники.БНФОКлючиАналитикиУчетаПараметровОткрытия.КлючиАналитикиУчетаПараметровОткрытияСчетовАналитическогоУчетаТаблицыСчетов(ТаблицаАналитикПараметровОткрытия);   
//	
//	СвязанныеСПОД = Перечисления.БНФОВидыСчетовРеглУчета.СвязанныеСПОДВидыСчетовРеглУчета();
//	
//	Для каждого СтрокаТаблицы из ТаблицаСчетов Цикл
//		
//		ВидСчетаУчетаСПОД = СвязанныеСПОД.Получить(СтрокаТаблицы.ВидСчетаУчета);
//		
//		Если ВидСчетаУчетаСПОД <> Неопределено Тогда
//			
//			АналитикаПараметровОткрытияСтруктура = СоответствиеКлючейАналитикиПараметровОткрытия.Получить(СтрокаТаблицы.АналитикаПараметровОткрытия);
//			ОтборАналитикаПараметровОткрытияСтруктура = Новый Структура("ВидСчетаУчета, ГруппаФинансовогоУчета, Валюта, ПризнакДоверительногоУправления");
//			ЗаполнитьЗначенияСвойств(ОтборАналитикаПараметровОткрытияСтруктура, АналитикаПараметровОткрытияСтруктура);
//			ОтборАналитикаПараметровОткрытияСтруктура.ВидСчетаУчета = ВидСчетаУчетаСПОД;
//			
//			НайденныеСтроки = ТаблицаКлючейАналитик.НайтиСтроки(ОтборАналитикаПараметровОткрытияСтруктура);
//			
//			Если НайденныеСтроки.Количество() = 0 Тогда
//				Продолжить;
//			КонецЕсли;
//			
//			АналитикаПараметровОткрытияПарногоСчета = НайденныеСтроки[0].КлючАналитики;
//			
//			ОтборПарныхСчетовСПОД = Новый Структура("СтруктурнаяЕдиница, Аналитика, АналитикаПараметровОткрытия");
//			ЗаполнитьЗначенияСвойств(ОтборПарныхСчетовСПОД, СтрокаТаблицы);
//			ОтборПарныхСчетовСПОД.АналитикаПараметровОткрытия = АналитикаПараметровОткрытияПарногоСчета;
//			
//			СтрокиПарныхСчетовСПОД = ТаблицаСчетов.НайтиСтроки(ОтборПарныхСчетовСПОД);
//			Если СтрокиПарныхСчетовСПОД.Количество() Тогда
//				
//				НоваяЗапись = НаборЗаписей.Добавить();
//				НоваяЗапись.Организация = Организация;
//				НоваяЗапись.СчетДоходовРасходов = СтрокаТаблицы.СчетАналитическогоУчета;
//				НоваяЗапись.СчетСПОД = СтрокиПарныхСчетовСПОД[0].СчетАналитическогоУчета; 
//				НоваяЗапись.Документ = Ссылка;
//				
//			КонецЕсли;   
//			
//		КонецЕсли;       
//		
//	КонецЦикла;
//	
//	Попытка
//		НаборЗаписей.Записать(Ложь);
//	Исключение
//		ШаблонСообщения = НСтр("ru = 'Не удалось сохранить настройку счетов:
//		|%1'");
//		ОписаниеОшибок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонСообщения, ОписаниеОшибки());
//		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ОписаниеОшибок, , , , Отказ);
//		Возврат;
//	КонецПопытки;              
//	
//	#КонецОбласти
//	
//	// {Исключить ПРОФ}
//	#Область СведенияПоСрокамЗакрытия
//	
//	НаборЗаписей = РегистрыСведений.БНФОСрокиСчетовАналитическогоУчета.СоздатьНаборЗаписей();
//	
//	Запрос = Новый Запрос;
//	Запрос.Текст = 
//	"ВЫБРАТЬ
//	|	СчетаУчета.СчетУчета,
//	|	СчетаУчета.СчетАналитическогоУчета,
//	|	СчетаУчета.ДатаОткрытия
//	|ПОМЕСТИТЬ ВТ_СчетаУчета
//	|ИЗ
//	|	&СчетаУчета КАК СчетаУчета
//	|ГДЕ
//	|	СчетаУчета.ОткрыватьСчет
//	|;
//	|
//	|////////////////////////////////////////////////////////////////////////////////
//	|ВЫБРАТЬ РАЗЛИЧНЫЕ
//	|	СчетаУчета.СчетУчета,
//	|	СчетаУчета.СчетАналитическогоУчета,
//	|	СчетаУчета.ДатаОткрытия,
//	|	ЕСТЬNULL(НастройкиЗакрытияСчетовАналитическогоУчета.ПолитикаЗакрытия, НастройкиЗакрытияСчетовАналитическогоУчетаПоВсемОрганизациям.ПолитикаЗакрытия) КАК ПолитикаЗакрытия
//	|ПОМЕСТИТЬ ВТ_ПолитикиЗакрытия
//	|ИЗ
//	|	ВТ_СчетаУчета КАК СчетаУчета
//	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.БНФОНастройкиЗакрытияСчетовАналитическогоУчета КАК НастройкиЗакрытияСчетовАналитическогоУчета
//	|		ПО СчетаУчета.СчетУчета = НастройкиЗакрытияСчетовАналитическогоУчета.Счет
//	|			И (НастройкиЗакрытияСчетовАналитическогоУчета.Организация = &Организация)
//	|			И (НЕ НастройкиЗакрытияСчетовАналитическогоУчета.ПолитикаЗакрытия.Недействителен)
//	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.БНФОНастройкиЗакрытияСчетовАналитическогоУчета КАК НастройкиЗакрытияСчетовАналитическогоУчетаПоВсемОрганизациям
//	|		ПО СчетаУчета.СчетУчета = НастройкиЗакрытияСчетовАналитическогоУчетаПоВсемОрганизациям.Счет
//	|			И (НастройкиЗакрытияСчетовАналитическогоУчетаПоВсемОрганизациям.Организация = ЗНАЧЕНИЕ(Справочник.Организации.ПустаяСсылка))
//	|			И (НЕ НастройкиЗакрытияСчетовАналитическогоУчетаПоВсемОрганизациям.ПолитикаЗакрытия.Недействителен)
//	|ГДЕ
//	|	НЕ ЕСТЬNULL(НастройкиЗакрытияСчетовАналитическогоУчета.ПолитикаЗакрытия, НастройкиЗакрытияСчетовАналитическогоУчетаПоВсемОрганизациям.ПолитикаЗакрытия) ЕСТЬ NULL 
//	|;
//	|
//	|////////////////////////////////////////////////////////////////////////////////
//	|ВЫБРАТЬ
//	|	ПолитикиЗакрытия.СчетУчета,
//	|	ПолитикиЗакрытия.СчетАналитическогоУчета,
//	|	ПолитикиЗакрытия.ДатаОткрытия,
//	|	ДОБАВИТЬКДАТЕ(ДОБАВИТЬКДАТЕ(ПолитикиЗакрытия.ДатаОткрытия, МЕСЯЦ, ПолитикиЗакрытия.ПолитикаЗакрытия.ПериодДействияСчета), ДЕНЬ, -1) КАК СрокДействия,
//	|	ПолитикиЗакрытия.ПолитикаЗакрытия,
//	|	&ДокументОткрытия КАК Документ
//	|ИЗ
//	|	ВТ_ПолитикиЗакрытия КАК ПолитикиЗакрытия";
//	
//	Запрос.УстановитьПараметр("Организация",		Организация);
//	Запрос.УстановитьПараметр("СчетаУчета",	 		ПараметрыПроведения.СчетаУчета);
//	Запрос.УстановитьПараметр("ДокументОткрытия",	Ссылка);
//	
//	ТаблицаЗаписей = Запрос.Выполнить().Выгрузить();
//	
//	Попытка
//		НаборЗаписей.Загрузить(ТаблицаЗаписей);     
//		НаборЗаписей.Записать(Ложь);
//	Исключение
//		ШаблонСообщения = НСтр("ru = 'Не удалось записать регистр ""Сроки счетов аналитического учета"":
//		|%1'");
//		ОписаниеОшибок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонСообщения, ОписаниеОшибки());
//		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ОписаниеОшибок, , , , Отказ);
//		Возврат;
//	КонецПопытки;                                             
//	
//	#КонецОбласти
//	// {/Исключить ПРОФ}
//	
//КонецПроцедуры
