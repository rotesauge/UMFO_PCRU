﻿
&После("ПередЗаписью")
Процедура pcru_ex_ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	
	Если ЭтотОбъект.СчетОрганизации.НомерСчета = "40702810400000000944" Тогда
		ЭтотОбъект.СчетБанк   = Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("2050181000000000000500000");
	КонецЕсли;
	
	Если ЭтотОбъект.СчетОрганизации.НомерСчета = "40702810603300479930" Тогда
		ЭтотОбъект.СчетБанк   = Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("2050181000000000000100000");
	КонецЕсли;
	
	Если ЭтотОбъект.СчетОрганизации.НомерСчета = "40702810703200479930" Тогда
		ЭтотОбъект.СчетБанк   = Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("2050181000000000000200000");
	КонецЕсли;
	
	Если ЭтотОбъект.СчетОрганизации.НомерСчета = "40702810803100479930" Тогда
		ЭтотОбъект.СчетБанк   = Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("2050181000000000000300000");
	КонецЕсли;
	
	Если ЭтотОбъект.СчетОрганизации.НомерСчета = "40702810903000479930" Тогда
		ЭтотОбъект.СчетБанк   = Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("2050181000000000000400000");
	КонецЕсли;
	
	Если ЭтотОбъект.СчетОрганизации.НомерСчета = "40702978803000479930" Тогда
		ЭтотОбъект.СчетБанк   = Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("2050197800000000000100000");
	КонецЕсли;
	
	
	Если СтрЧислоВхождений(ЭтотОбъект.НазначениеПлатежа,"@@") > 0 Тогда
		Возврат;
	КонецЕсли; 
	
	Если ЭтотОбъект.СчетОрганизации.НомерСчета = "40702810703200479930" или ЭтотОбъект.СчетОрганизации.НомерСчета = "40702810803100479930" Тогда
		ЭтотОбъект.СтатьяДвиженияДенежныхСредств  = Справочники.СтатьиДвиженияДенежныхСредств.НайтиПоКоду("00-000037");
		ЭтотОбъект.ВидОперации	=  Перечисления.ВидыОперацийПоступлениеДенежныхСредств.ПрочееПоступление;
		//		Если ЗначениеЗаполнено(ЭтотОбъект.Контрагент)  Тогда
		Если ЭтотОбъект.Контрагент.Наименование <> "КИВИ Банк (акционерное общество)" 
			и ЭтотОбъект.Контрагент.Наименование <> "МОСКОВСКИЙ КЛИРИНГОВЫЙ ЦЕНТР НКО (АО)" Тогда
			ЭтотОбъект.СчетУчетаРасчетовСКонтрагентом  = Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("4742281000000000000100000");
		КонецЕсли;
		//		КонецЕсли; 
		ЭтотОбъект.ПодразделениеОрганизации  = Справочники.ПодразделенияОрганизаций.НайтиПоКоду("000000003");
	КонецЕсли; 
	
	
	Если ЭтотОбъект.СчетОрганизации.НомерСчета = "40702810703200479930" Тогда
		//	Если ЗначениеЗаполнено(ЭтотОбъект.Контрагент)  Тогда
		Если ЭтотОбъект.Контрагент.ИНН = "3123011520" Тогда
			ЭтотОбъект.ВидОперации	=  Перечисления.ВидыОперацийПоступлениеДенежныхСредств.ПрочееПоступление;
			ЭтотОбъект.СчетУчетаРасчетовСКонтрагентом  = Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("6032281000000000007890000");
			ЭтотОбъект.БНФОСубконтоКт1 = ЭтотОбъект.Контрагент;
			ЭтотОбъект.БНФОСубконтоКт2 = Справочники.ДоговорыКонтрагентов.НайтиПоКоду("00-000781");
		КонецЕсли; 
		Если  ЭтотОбъект.Контрагент.ИНН = "7707033412" Тогда
			ЭтотОбъект.ВидОперации	=  Перечисления.ВидыОперацийПоступлениеДенежныхСредств.ПрочееПоступление;
			ЭтотОбъект.СчетУчетаРасчетовСКонтрагентом  = Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("6032281000000000000060000");//6031281000000069400000000");
			ЭтотОбъект.БНФОСубконтоКт1 = ЭтотОбъект.Контрагент;
			ЭтотОбъект.БНФОСубконтоКт2 = Справочники.ДоговорыКонтрагентов.НайтиПоКоду("000000277");
		КонецЕсли; 
		//	КонецЕсли;
	КонецЕсли; 
	
	
	
	//
	//Если ЭтотОбъект.ВидОперации =  Перечисления.ВидыОперацийПоступлениеДенежныхСредств.ПереводСДругогоСчета Тогда
	//	ЭтотОбъект.СтатьяДвиженияДенежныхСредств  = СправочникЫи.СтатьиДвиженияДенежныхСредств.НайтиПоКоду("00-000043");
	//КонецЕсли; 
	
	
	//Если  СтрЧислоВхождений(Врег(ЭтотОбъект.НазначениеПлатежа),"ДОЛГ")>0 или СтрЧислоВхождений(Врег(ЭтотОбъект.НазначениеПлатежа),"ВЗЫСК")>0 Тогда
	//Если  СтрЧислоВхождений(Врег(ЭтотОбъект.НазначениеПлатежа),"МОНОЛИТ")>0 Тогда "ВСЕ НА МЕДУЗУ!!"  
	Если ЭтотОбъект.СчетОрганизации.НомерСчета = "40702810803100479930"  Тогда
		ЭтотОбъект.СтатьяДвиженияДенежныхСредств  = Справочники.СтатьиДвиженияДенежныхСредств.НайтиПоКоду("00-000047");
	КонецЕсли; 
	
	
	
	//40702810603300479930
	Если ЭтотОбъект.СчетОрганизации.НомерСчета = "40702810603300479930"  Тогда
		
		Если СтрЧислоВхождений(ЭтотОбъект.НазначениеПлатежа,"ВОЗВРАТ СРЕДСТВ ПО ПРИЧИНЕ")>0 Тогда
			ЭтотОбъект.ВидОперации	=  Перечисления.ВидыОперацийПоступлениеДенежныхСредств.ПрочееПоступление;
			ЭтотОбъект.СтатьяДвиженияДенежныхСредств  = Справочники.СтатьиДвиженияДенежныхСредств.НайтиПоКоду("00-000037");
		КонецЕсли;
	КонецЕсли;
	
	Если (СтрЧислоВхождений(ЭтотОбъект.НазначениеПлатежа,"ВОЗВРАТ")>0 или СтрЧислоВхождений(ЭтотОбъект.НазначениеПлатежа,"озврат")>0) и
		(СтрЧислоВхождений(ЭтотОбъект.НазначениеПлатежа,"ПП")>0 или СтрЧислоВхождений(ЭтотОбъект.НазначениеПлатежа,"ПЛАТ.ПОР.")>0) Тогда
		
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ
		|	СписаниеСРасчетногоСчета.Ссылка КАК Ссылка
		|ИЗ
		|	Документ.СписаниеСРасчетногоСчета КАК СписаниеСРасчетногоСчета
		|ГДЕ
		|	СписаниеСРасчетногоСчета.НомерВходящегоДокумента = &НомерВходящегоДокумента";
		Запрос.УстановитьПараметр("НомерВходящегоДокумента",ЭтотОбъект.НомерВходящегоДокумента);
		Результат = Запрос.Выполнить();
		Выборка = Результат.Выбрать();
		Рез = Неопределено;
		Пока Выборка.Следующий() Цикл
			Рез = Выборка.Ссылка;
		КонецЦикла;
		//Рез = pcru_УМФО.НайтиСписаниеВСтроке(ЭтотОбъект.НазначениеПлатежа);
		
		Если ЗначениеЗаполнено(Рез) Тогда
			Если Рез.РасшифровкаПлатежа.Количество() = 0 Тогда
				ЭтотОбъект.ВидОперации	=  Перечисления.ВидыОперацийПоступлениеДенежныхСредств.ПрочееПоступление;
				ЭтотОбъект.РасшифровкаПлатежа.Очистить();
				ЭтотОбъект.СчетУчетаРасчетовСКонтрагентом = Рез.СчетУчетаРасчетовСКонтрагентом;
				ЭтотОбъект.СтатьяДвиженияДенежныхСредств  = Рез.СтатьяДвиженияДенежныхСредств;
				
				
				//СтрокаРасшифровки = ЭтотОбъект.РасшифровкаПлатежа.Добавить();
				////  СтрокаРасшифровки.ДоговорКонтрагента = НовДогСС;
				//СтрокаРасшифровки.СпособПогашенияЗадолженности = Перечисления.СпособыПогашенияЗадолженности.Автоматически; 
				////	СтрокаРасшифровки.Сделка =
				//СтрокаРасшифровки.СуммаПлатежа = Рез.СуммаДокумента;
				//СтрокаРасшифровки.КурсВзаиморасчетов = 1;
				//СтрокаРасшифровки.СуммаВзаиморасчетов=  Рез.СуммаДокумента;
				////СтрокаРасшифровки.СтавкаНДС =
				////СтрокаРасшифровки.СуммаНДС =
				//СтрокаРасшифровки.СтатьяДвиженияДенежныхСредств  = Справочники.СтатьиДвиженияДенежныхСредств.НайтиПоКоду("00-000037");
				//СтрокаРасшифровки.СчетУчетаРасчетовСКонтрагентом = Рез.СчетУчетаРасчетовСКонтрагентом;
				//СтрокаРасшифровки.СчетУчетаРасчетовПоАвансам     = Рез.СчетУчетаРасчетовСКонтрагентом;
				//СтрокаРасшифровки.КратностьВзаиморасчетов = 1;
				////СтрокаРасшифровки.РасходыУСН =
				////СтрокаРасшифровки.НДСУСН =
				//		СтрокаРасшифровки.РаспределятьРасходыУСН = Ложь;
				//		СтрокаРасшифровки.ВидПлатежаПоКредитамЗаймам =  Перечисления.ВидыПлатежейПоКредитамЗаймам.ПогашениеДолга;
				//НовУслСС  = Справочники.БНФОДоговорыКредитовИДепозитов.НайтиПоРеквизиту("Номер",НомерДоговора);
				//СтрокаРасшифровки.БНФОДоговорКредитаДепозита = ДанныеДляЗаполнения.БНФОДоговорКредитаДепозита;		
				
			иначе
				
				ЭтотОбъект.СчетУчетаРасчетовСКонтрагентом = Рез.СчетУчетаРасчетовСКонтрагентом;
				ЭтотОбъект.СтатьяДвиженияДенежныхСредств  = Рез.СтатьяДвиженияДенежныхСредств;
				
				ДанныеДляЗаполнения =  Рез.РасшифровкаПлатежа[0];
				ЭтотОбъект.ВидОперации	=  Перечисления.ВидыОперацийПоступлениеДенежныхСредств.ВозвратЗаймаКонтрагентом;
				ЭтотОбъект.РасшифровкаПлатежа.Очистить();
				СтрокаРасшифровки = ЭтотОбъект.РасшифровкаПлатежа.Добавить();
				//  СтрокаРасшифровки.ДоговорКонтрагента = НовДогСС;
				СтрокаРасшифровки.СпособПогашенияЗадолженности = Перечисления.СпособыПогашенияЗадолженности.Автоматически; 
				//	СтрокаРасшифровки.Сделка =
				СтрокаРасшифровки.СуммаПлатежа = ДанныеДляЗаполнения.СуммаПлатежа;
				СтрокаРасшифровки.КурсВзаиморасчетов = 1;
				СтрокаРасшифровки.СуммаВзаиморасчетов=  ДанныеДляЗаполнения.СуммаПлатежа;
				//СтрокаРасшифровки.СтавкаНДС =
				//СтрокаРасшифровки.СуммаНДС =
				СтрокаРасшифровки.СтатьяДвиженияДенежныхСредств  = Справочники.СтатьиДвиженияДенежныхСредств.НайтиПоКоду("00-000037");
				Если ЗначениеЗаполнено(ДанныеДляЗаполнения.СчетУчетаРасчетовСКонтрагентом)  Тогда
					СтрокаРасшифровки.СчетУчетаРасчетовСКонтрагентом = ДанныеДляЗаполнения.СчетУчетаРасчетовСКонтрагентом;
				иначе 
					СтрокаРасшифровки.СчетУчетаРасчетовСКонтрагентом = ЭтотОбъект.СчетУчетаРасчетовСКонтрагентом;
				КонецЕсли; 
				СтрокаРасшифровки.БНФОВидПлатежаПоКредитамЗаймам   = Перечисления.ВидыПлатежейПоКредитамЗаймам.БНФОПрочее;
				
				СтрокаРасшифровки.СчетУчетаРасчетовПоАвансам     = ДанныеДляЗаполнения.СчетУчетаРасчетовПоАвансам;
				СтрокаРасшифровки.КратностьВзаиморасчетов = 1;
				//СтрокаРасшифровки.РасходыУСН =
				//СтрокаРасшифровки.НДСУСН =
				//	СтрокаРасшифровки.РаспределятьРасходыУСН = Ложь;
				//	СтрокаРасшифровки.ВидПлатежаПоКредитамЗаймам =  Перечисления.ВидыПлатежейПоКредитамЗаймам.ПогашениеДолга;
				//НовУслСС  = Справочники.БНФОДоговорыКредитовИДепозитов.НайтиПоРеквизиту("Номер",НомерДоговора);
				СтрокаРасшифровки.БНФОДоговорКредитаДепозита = ДанныеДляЗаполнения.БНФОДоговорКредитаДепозита;	
			КонецЕсли; 
			
		КонецЕсли; 
		
		Если не ЗначениеЗаполнено(ЭтотОбъект.Контрагент)  Тогда
			ЭтотОбъект.Контрагент = Справочники.Контрагенты.НайтиПоНаименованию("Физ лицо");
		КонецЕсли;
		
	КонецЕсли;
	
	//++ Севрюгин А.А  26.02.2020 10:50:11   DEV1C-304
	Если ЭтотОбъект.СчетОрганизации.НомерСчета = "40701810355000000143"  Тогда
		Если СтрЧислоВхождений(ЭтотОбъект.НазначениеПлатежа,"//Приложение//Займы")>0 Тогда
			ЭтотОбъект.ВидОперации	=  Перечисления.ВидыОперацийПоступлениеДенежныхСредств.ПрочееПоступление;
			ЭтотОбъект.СчетУчетаРасчетовСКонтрагентом  = Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("6032281000000000002000000");
			ЭтотОбъект.СтатьяДвиженияДенежныхСредств  = Справочники.СтатьиДвиженияДенежныхСредств.НайтиПоКоду("00-000037");
			ЭтотОбъект.Контрагент = Справочники.Контрагенты.НайтиПоКоду("00-000020");
		КонецЕсли;
	КонецЕсли; 
	//-- Севрюгин А.А  26.02.2020 10:50:11 Администратор
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	Если СтрЧислоВхождений(ЭтотОбъект.НазначениеПлатежа,"Зачисление процентов, начисленных на остаток на счете")>0 Тогда
		ЭтотОбъект.ВидОперации	=  Перечисления.ВидыОперацийПоступлениеДенежныхСредств.ПрочееПоступление;
		//Если ЭтотОбъект.СчетОрганизации.НомерСчета = "40702810603300479930" Тогда	
		//	СчетАналитическогоУчетаРассч = Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("2050781000000000000300000");
		//ИНачеЕсли ЭтотОбъект.СчетОрганизации.НомерСчета = "40702810703200479930" Тогда	
		//	СчетАналитическогоУчетаРассч = Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("2050781000000000000200000");
		//ИНачеЕсли ЭтотОбъект.СчетОрганизации.НомерСчета = "40702810803100479930" Тогда	
		//	СчетАналитическогоУчетаРассч = Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("2050781000000000000100000");
		//ИНаче	
		//	СчетАналитическогоУчетаРассч = Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("2050781000000000000000000");
		//КонецЕсли;
		ЭтотОбъект.СчетУчетаРасчетовСКонтрагентом  = Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("7100181000311200000000024");
		//ЭтотОбъект.СчетБанк = СчетАналитическогоУчетаРассч;
		ЭтотОбъект.СтатьяДвиженияДенежныхСредств =  Справочники.СтатьиДвиженияДенежныхСредств.НайтиПоКоду("00-000044");
		ЭтотОбъект.БНФОСубконтоКт1  = Справочники.ПрочиеДоходыИРасходы.НайтиПоКоду("00-000233");
		ЭтотОбъект.БНФОСубконтоКт2  = Справочники.БНФОСубконто.НайтиПоКоду("000000092");
	КонецЕсли;
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
КонецПроцедуры

&Перед("ОбработкаПроведения")
Процедура pcru_ex_ОбработкаПроведения(Отказ, РежимПроведения)
	Если НЕ ЗначениеЗаполнено(ЭтотОбъект.СчетУчетаРасчетовСКонтрагентом) Тогда
		Отказ = Истина;
		Для каждого СтрокаРасшифровки Из ЭтотОбъект.РасшифровкаПлатежа Цикл
			Если ЗначениеЗаполнено(СтрокаРасшифровки.СчетУчетаРасчетовСКонтрагентом) Тогда
				Отказ = Ложь;
			Иначе
				Отказ = Истина;
			КонецЕсли;
		КонецЦикла; 
	КонецЕсли;
КонецПроцедуры


&После("ОбработкаПроведения")
Процедура pcru_ex_ОбработкаПроведенияПосле(Отказ, РежимПроведения)
	Если СтрЧислоВхождений(ЭтотОбъект.НазначениеПлатежа,"Зачисление процентов, начисленных на остаток на счете")>0 Тогда
		ДвиженияБ = ЭтотОбъект.Движения.БНФОБанковский;
		Сод = ДвиженияБ[0].Содержание;
		ДвиженияБ.Очистить();
		
		//	Если ДвиженияБ.Количество() = 1  Тогда
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
		Если ЭтотОбъект.СчетОрганизации.НомерСчета = "40702810603300479930" Тогда	
			СчетАналитическогоУчетаРассч = Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("2050781000000000000300000");
		ИНачеЕсли ЭтотОбъект.СчетОрганизации.НомерСчета = "40702810703200479930" Тогда	
			СчетАналитическогоУчетаРассч = Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("2050781000000000000200000");
		ИНачеЕсли ЭтотОбъект.СчетОрганизации.НомерСчета = "40702810803100479930" Тогда	
			СчетАналитическогоУчетаРассч = Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("2050781000000000000100000");
		ИНаче	
			СчетАналитическогоУчетаРассч = Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("2050781000000000000000000");
		КонецЕсли;
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
		Строка = ДвиженияБ.Добавить();
		Строка.Активность = 	Истина;
		Строка.ВалютаДт	= ЭтотОбъект.ВалютаДокумента;
		Строка.ВалютаКт	= ЭтотОбъект.ВалютаДокумента;
		Строка.ВалютнаяСуммаДт	= ЭтотОбъект.СуммаДокумента;//51 066,07
		Строка.ВалютнаяСуммаКт	= ЭтотОбъект.СуммаДокумента;//51 066,07
		Строка.НеКорректироватьСтоимостьАвтоматически =	Ложь;
		Строка.НомерМемориальногоОрдера	= ЭтотОбъект.Номер;
		Строка.Организация = 	ЭтотОбъект.Организация;
		Строка.Ответственный = 	ЭтотОбъект.Ответственный;
		Строка.Период	= ЭтотОбъект.Дата;
		Строка.ПодразделениеДт	= ЭтотОбъект.ПодразделениеОрганизации;
		Строка.ПодразделениеКт	= ЭтотОбъект.ПодразделениеОрганизации;
		Строка.Регистратор	=ЭтотОбъект.Ссылка;
		Строка.СПОД= Ложь;
		Строка.Содержание	= Сод;
		Строка.Сумма	= ЭтотОбъект.СуммаДокумента;
		Строка.СуммаНУКт	= ЭтотОбъект.СуммаДокумента;
		Строка.СчетАналитическогоУчетаДт	= ЭтотОбъект.СчетБанк;
		Строка.СчетАналитическогоУчетаКт	= СчетАналитическогоУчетаРассч;
		Строка.СчетДт =	Строка.СчетАналитическогоУчетаДт.Владелец;
		Строка.СчетКт =	СчетАналитическогоУчетаРассч.Владелец;
		БНФОБухгалтерскийУчет.УстановитьСубконто(Строка.СчетДт, Строка.СубконтоДт, 1,ЭтотОбъект.СчетОрганизации); 
		БНФОБухгалтерскийУчет.УстановитьСубконто(Строка.СчетДт, Строка.СубконтоДт, 2, Справочники.СтатьиДвиженияДенежныхСредств.НайтиПоКоду("00-000044")); 
		БНФОБухгалтерскийУчет.УстановитьСубконто(Строка.СчетКт, Строка.СубконтоКт, 1, ЭтотОбъект.СчетОрганизации); 
		БНФОБухгалтерскийУчет.УстановитьСубконто(Строка.СчетКт, Строка.СубконтоКт, 2, Справочники.СтатьиДвиженияДенежныхСредств.НайтиПоКоду("00-000044")); 
		
		
		Строка2 = ДвиженияБ.Добавить();
		Строка2.Активность = 	Истина;
		Строка2.ВалютаДт	= ЭтотОбъект.ВалютаДокумента;
		Строка2.ВалютнаяСуммаДт	= ЭтотОбъект.СуммаДокумента;
		Строка2.НеКорректироватьСтоимостьАвтоматически =	Ложь;
		Строка2.НомерМемориальногоОрдера	= ЭтотОбъект.Номер;
		Строка2.Организация = 	ЭтотОбъект.Организация;
		Строка2.Ответственный = 	ЭтотОбъект.Ответственный;
		Строка2.Период	= ЭтотОбъект.Дата;
		Строка2.ПодразделениеДт	= ЭтотОбъект.ПодразделениеОрганизации;
		Строка2.ПодразделениеКт	= ЭтотОбъект.ПодразделениеОрганизации;
		Строка2.Регистратор	= ЭтотОбъект.Ссылка;
		Строка2.СПОД= Ложь;
		Строка2.Содержание	= Сод;
		Строка2.Сумма	= ЭтотОбъект.СуммаДокумента;
		Строка2.СуммаНУКт	= ЭтотОбъект.СуммаДокумента;
		
		
		Строка2.СчетАналитическогоУчетаДт	= СчетАналитическогоУчетаРассч;
		Строка2.СчетАналитическогоУчетаКт	 = Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("7100181000311200000000024");
		
		
		
		Строка2.СчетДт	= Строка2.СчетАналитическогоУчетаДт.Владелец;
		Строка2.СчетКт	= Строка2.СчетАналитическогоУчетаКт.Владелец;		
		
		БНФОБухгалтерскийУчет.УстановитьСубконто(Строка2.СчетДт, Строка2.СубконтоДт,  1, ЭтотОбъект.СчетОрганизации); 
		БНФОБухгалтерскийУчет.УстановитьСубконто(Строка2.СчетДт, Строка2.СубконтоДт, 2, Справочники.СтатьиДвиженияДенежныхСредств.НайтиПоКоду("00-000044")); 
		
		
		БНФОБухгалтерскийУчет.УстановитьСубконто(Строка2.СчетКт, Строка2.СубконтоКт, ПланыВидовХарактеристик.БНФОВидыСубконтоБанковские.ПрочиеДоходыИРасходы, Справочники.ПрочиеДоходыИРасходы.НайтиПоКоду("00-000233")); 
		БНФОБухгалтерскийУчет.УстановитьСубконто(Строка2.СчетКт, Строка2.СубконтоКт, 2, Справочники.БНФОСубконто.НайтиПоКоду("000000092"));
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
		ДвиженияБ.Записать();
	КонецЕсли;
КонецПроцедуры


&Перед("ПередЗаписью")
Процедура pcru_ex_ПередЗаписью1(Отказ, РежимЗаписи, РежимПроведения)
	//pcru_ex_ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
КонецПроцедуры
