﻿
//&Вместо("ОткрытьЛицевыеСчетаПоОбъектамАналитик")
Процедура pcru_ex_ОткрытьЛицевыеСчетаПоОбъектамАналитик(СтруктураПараметров, Отказ, РежимЗагрузи)

	Период = НачалоДня(СтруктураПараметров.Дата);
	Организация = СтруктураПараметров.Организация;

	Если Не АЭ_ОбщегоНазначенияВызовСервераПовтИсп.ВедетсяУчетНФО(Организация, Период) Тогда
		Возврат;
	КонецЕсли;

	ОписаниеМетаданныхДокумента = АЭ_РегламентированныйУчет.ПолучитьОписаниеМетаданныхДокумента(СтруктураПараметров.ДокументОснование);

	Если Не РежимЗагрузи И НЕ АктуализироватьДанныеРеглУчета(СтруктураПараметров, ОписаниеМетаданныхДокумента) Тогда
		Возврат;
	КонецЕсли;

	ИспользоватьОбщийСчет = АЭ_ЗаймыВызовСервераПовтИсп.ИспользоватьОбщийСчетАналитическогоУчетаЗаймов(Организация,
	ОписаниеМетаданныхДокумента.МетаданныеИмя, Период); 

	Если ИспользоватьОбщийСчет Тогда

		// Запись в регистр		
		Запрос = Новый Запрос;
		Запрос.Текст =
		"ВЫБРАТЬ
		|	АЭ_ВидыЗаймовРегламентированныйУчет.Организация КАК Организация,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.ГруппаСчетаЗайма КАК ГруппаСчетаЗайма,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.СчетУчетаОсновногоДолга КАК СчетУчетаОсновногоДолга,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.СчетУчетаНачисленияПроцентов КАК СчетУчетаНачисленияПроцентов,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.СчетУчетаРасчетовПоПроцентам КАК СчетУчетаРасчетовПоПроцентам,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.СчетУчетаРасчетовПоПрочимРасходам КАК СчетУчетаРасчетовПоПрочимРасходам,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.СчетУчетаНачисленияПрочихДоходов КАК СчетУчетаНачисленияПрочихДоходов,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.СчетУчетаРасчетовПоПрочимДоходам КАК СчетУчетаРасчетовПоПрочимДоходам,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.СчетУчетаКорректировокУвеличение КАК СчетУчетаКорректировокУвеличение,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.СчетУчетаКорректировокУменьшение КАК СчетУчетаКорректировокУменьшение,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.СчетУчетаРезервовПодОбесценение КАК СчетУчетаРезервовПодОбесценение,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.СчетУчетаПогашенияИмуществом КАК СчетУчетаПогашенияИмуществом,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.СчетУчетаВыбытия КАК СчетУчетаВыбытия,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.СчетУчетаНоминальнойСтоимостиПриобретенныхЗаймов КАК СчетУчетаНоминальнойСтоимостиПриобретенныхЗаймов,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.СчетУчетаТекущихРасчетовАктивный КАК СчетУчетаТребованийПоПрочимФинансовымОперациям,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.СчетУчетаТекущихРасчетовПассивный КАК СчетУчетаОбязательствПоПрочимФинансовымОперациям,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.СчетУчетаПрочихРасчетовАктивный КАК СчетУчетаРасчетовСПрочимиДебиторами,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.СчетУчетаПрочихРасчетовПассивный КАК СчетУчетаРасчетовСПрочимиКредиторами,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.СчетУчетаРезервовПодОбесценениеПерваяГруппаНеКредитноОбесцененные КАК СчетУчетаРезервовПодОбесценениеПерваяГруппаНеКредитноОбесцененные,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.СчетУчетаРезервовПодОбесценениеВтораяГруппаНеКредитноОбесцененные КАК СчетУчетаРезервовПодОбесценениеВтораяГруппаНеКредитноОбесцененные,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.СчетУчетаРезервовПодОбесценениеВтораяГруппаКредитноОбесцененные КАК СчетУчетаРезервовПодОбесценениеВтораяГруппаКредитноОбесцененные,
		|	АЭ_ВидыЗаймовРегламентированныйУчет.СчетУчетаРезервовПодОбесценениеТретьяГруппаКредитноОбесцененные КАК СчетУчетаРезервовПодОбесценениеТретьяГруппаКредитноОбесцененные
		|ИЗ
		|	РегистрСведений.АЭ_ВидыЗаймовРегламентированныйУчет КАК АЭ_ВидыЗаймовРегламентированныйУчет
		|ГДЕ
		|	АЭ_ВидыЗаймовРегламентированныйУчет.Организация = &Организация
		|	И АЭ_ВидыЗаймовРегламентированныйУчет.ГруппаСчетаЗайма = &ВидЗаймаБУ";

		Запрос.УстановитьПараметр("Организация", СтруктураПараметров.Организация);
		Запрос.УстановитьПараметр("ВидЗаймаБУ",  СтруктураПараметров.ВидЗаймаБУ);

		Выборка = Запрос.Выполнить().Выбрать();
		Если Выборка.Следующий() Тогда

			// Регистр по займам
			МенеджерЗаписи = РегистрыСведений[ОписаниеМетаданныхДокумента.РегистрРеглУчетЗаймов].СоздатьМенеджерЗаписи();
			ЗаполнитьЗначенияСвойств(МенеджерЗаписи, Выборка);
			ЗаполнитьЗначенияСвойств(МенеджерЗаписи, СтруктураПараметров);
			Попытка
				МенеджерЗаписи.Записать(Истина);
			Исключение
				// Не удалось записать запись
			КонецПопытки;

			// Регистр по договорам
			Если ЗначениеЗаполнено(СтруктураПараметров.ДоговорКонтрагента) Тогда

				СчетУчетаПоДоговору = ПолучитьЛицевыеСчетаПоДоговоруКонтрагента(СтруктураПараметров.Организация, СтруктураПараметров.Контрагент,
				СтруктураПараметров.ДоговорКонтрагента);

				МенеджерЗаписи = РегистрыСведений.АЭ_РегламентированныйУчетСчетовРасчетовДоговоровКонтрагентов.СоздатьМенеджерЗаписи();
				ЗаполнитьЗначенияСвойств(МенеджерЗаписи, СтруктураПараметров);
				ЗаполнитьЗначенияСвойств(МенеджерЗаписи, СчетУчетаПоДоговору); // Предыдущие счета
				ЗаполнитьЗначенияСвойств(МенеджерЗаписи, Выборка); // Новые счета
				Попытка
					МенеджерЗаписи.Записать(Истина);
				Исключение
					// Не удалось записать запись
				КонецПопытки;

			КонецЕсли;
		Иначе
			// Не заполнены настройки учетной политики
			ТекстСообщения = СтрШаблон(НСтр("ru = 'По документу ""%1"" не удалось открыть счета аналитического учета, так как в регистре ""Настройка отражения займов"" не заполнены счета аналитического учета по орагнизации ""%2"" и группе займа ""%3""'"),
			СтруктураПараметров.ДокументОснование,СтруктураПараметров.Организация, СтруктураПараметров.ВидЗаймаБУ);

			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, СтруктураПараметров.ДокументОснование);
			Возврат;

		КонецЕсли;

	Иначе

		ДокументОткрытияСАУ = Документы.БНФООткрытиеСчетовАналитическогоУчета.СоздатьДокумент();

		ПараметрыОткрытияЛС = ПолучитьСтруктуруПараметровСозданияДокумента(ДокументОткрытияСАУ);
		ПодготовитьДокументОткрытияСчетовАналитик(СтруктураПараметров, ДокументОткрытияСАУ);

		Если Не ЗначениеЗаполнено(ДокументОткрытияСАУ.ГруппаФинансовогоУчета)
			И ДокументОткрытияСАУ.ДополнительныеГруппыФинансовогоУчета.Количество() = 0 Тогда 

			ТекстСообщения = НСтр("ru = 'Документ ""Открытие счетов аналитического учета"" не создан. Не найдено ни одной группы финансового учета!'");

			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
			Возврат;

		КонецЕсли;

		Если РежимЗагрузи Тогда
			ОсновнаяТаблицаИспользуемыхСчетов = АЭ_ЗаймыПовтИсп.ПолучитьПараметрыОткрытияСчета(ДокументОткрытияСАУ.Организация, ДокументОткрытияСАУ.ГруппаФинансовогоУчета);
		Иначе
			ОсновнаяТаблицаИспользуемыхСчетов = БНФОСчетаУчетаВДокументах.ПолучитьПараметрыОткрытияСчета(ДокументОткрытияСАУ.Организация, ДокументОткрытияСАУ.ГруппаФинансовогоУчета);
		КонецЕсли;

		МассивГруппФинансовогоУчета = Новый Массив;

		Для каждого СтрокаИспользуемыйСчет Из ОсновнаяТаблицаИспользуемыхСчетов Цикл
			НоваяСтрокаИспользуемыхСчетов = ПараметрыОткрытияЛС.ТаблицаИспользуемыхСчетов.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрокаИспользуемыхСчетов, СтрокаИспользуемыйСчет);
			НоваяСтрокаИспользуемыхСчетов.ГруппаФинансовогоУчета = ДокументОткрытияСАУ.ГруппаФинансовогоУчета;
			МассивГруппФинансовогоУчета.Добавить(ДокументОткрытияСАУ.ГруппаФинансовогоУчета);
		КонецЦикла;

		ДополнитьГруппыФинансовогоУчетаПарнымиСимволамиОФР(ДокументОткрытияСАУ, ПараметрыОткрытияЛС);
		ОчиститьДанныеДокумента(ДокументОткрытияСАУ, ПараметрыОткрытияЛС);

		ОбновитьТаблицуПараметровСчетов(ДокументОткрытияСАУ, ПараметрыОткрытияЛС, РежимЗагрузи);
		ЗаполнитьСчетаУчетаПоУмолчанию(ДокументОткрытияСАУ, ПараметрыОткрытияЛС);

		СоответствиеСтрокТабличныхЧастей = Новый Соответствие;
		Для Каждого СтрокаСчет Из ДокументОткрытияСАУ.СчетаУчета Цикл 
			СоответствиеСтрокТабличныхЧастей[СтрокаСчет.КлючСтроки] = СтрокаСчет;
		КонецЦикла;

		Для Каждого СтрокаВидАналитики Из ДокументОткрытияСАУ.ВидыАналитик Цикл 
			Если СтрокаВидАналитики.ВидАналитики.ТипЗначения.СодержитТип(Тип("СправочникСсылка.Контрагенты")) Тогда 
				СтрокаВидАналитики.ЗначениеАналитики = СтруктураПараметров.Контрагент;
			ИначеЕсли СтрокаВидАналитики.ВидАналитики.ТипЗначения.СодержитТип(Тип("СправочникСсылка.ДоговорыКонтрагентов")) Тогда  
				СтрокаВидАналитики.ЗначениеАналитики = СтруктураПараметров.ДоговорКонтрагента;
			ИначеЕсли СтрокаВидАналитики.ВидАналитики.ТипЗначения.СодержитТип(Тип("СправочникСсылка.БНФОДоговорыКредитовИДепозитов")) Тогда  
				СтрокаВидАналитики.ЗначениеАналитики = СтруктураПараметров.ДоговорКредитаДепозита;
			ИначеЕсли СтрокаВидАналитики.ВидАналитики.ТипЗначения.СодержитТип(Тип("ПеречислениеСсылка.АЭ_ГруппыРезервовПодОбесценение")) Тогда  

				СтрокаВидАналитики.ЗначениеАналитики = Перечисления.АЭ_ГруппыРезервовПодОбесценение.ПустаяСсылка();

				СтрокаСчетаУчета =  СоответствиеСтрокТабличныхЧастей.Получить(СтрокаВидАналитики.КлючСтроки);
				Если СтрокаСчетаУчета <> Неопределено Тогда
					ГФУПоСтрокеСчетаУчета = СтрокаСчетаУчета.ГруппаФинансовогоУчета;
					Если СтруктураПараметров.Свойство("ГФУРОПерваяГруппаНеКредитноОбесцененные")
						И СтруктураПараметров.ГФУРОПерваяГруппаНеКредитноОбесцененные = ГФУПоСтрокеСчетаУчета Тогда
						СтрокаВидАналитики.ЗначениеАналитики = Перечисления.АЭ_ГруппыРезервовПодОбесценение.ПерваяГруппаНеКредитноОбесцененные;	
					ИначеЕсли СтруктураПараметров.Свойство("ГФУРОВтораяГруппаНеКредитноОбесцененные")
						И СтруктураПараметров.ГФУРОВтораяГруппаНеКредитноОбесцененные = ГФУПоСтрокеСчетаУчета Тогда
						СтрокаВидАналитики.ЗначениеАналитики = Перечисления.АЭ_ГруппыРезервовПодОбесценение.ВтораяГруппаНеКредитноОбесцененные;		
					ИначеЕсли СтруктураПараметров.Свойство("ГФУРОВтораяГруппаКредитноОбесцененные")
						И СтруктураПараметров.ГФУРОВтораяГруппаКредитноОбесцененные = ГФУПоСтрокеСчетаУчета Тогда
						СтрокаВидАналитики.ЗначениеАналитики = Перечисления.АЭ_ГруппыРезервовПодОбесценение.ВтораяГруппаКредитноОбесцененные;	
					ИначеЕсли СтруктураПараметров.Свойство("ГФУРОТретьяГруппаКредитноОбесцененные")
						И СтруктураПараметров.ГФУРОТретьяГруппаКредитноОбесцененные = ГФУПоСтрокеСчетаУчета Тогда
						СтрокаВидАналитики.ЗначениеАналитики = Перечисления.АЭ_ГруппыРезервовПодОбесценение.ТретьяГруппаКредитноОбесцененныеПриНачальномПризнании;		
					КонецЕсли;

				КонецЕсли;

			КонецЕсли;

		КонецЦикла;

		// Наименование Л/С
		СтруктураЗаполнения	= Документы.БНФООткрытиеСчетовАналитическогоУчета.ПолучитьОписаниеСтруктурыПараметровОткрытия();
		Для Каждого СтрокаСчет Из ДокументОткрытияСАУ.СчетаУчета Цикл 
			ЗаполнитьЗначенияСвойств(СтруктураЗаполнения, СтрокаСчет,
			"ШаблонОткрытия, ВидСчетаУчета, СчетУчета, СчетАналитическогоУчета, 
			|Код, Наименование, КлючСтроки");

			СтрокаСчет.Наименование	= Документы.БНФООткрытиеСчетовАналитическогоУчета.ПолучитьНаименованиеСчета(ДокументОткрытияСАУ, СтруктураЗаполнения, ДокументОткрытияСАУ.ГруппаФинансовогоУчета);

		КонецЦикла;

		Попытка
	    ДокументОткрытияСАУ.Записать(РежимЗаписиДокумента.Проведение);
 		Исключение
		КонецПопытки; 

	КонецЕсли;

КонецПроцедуры
