﻿
//Процедура ЭтоИсходящееПроверкаУсловия(ТочкаМаршрутаБизнесПроцесса, Результат)
//	Если ЭтотОбъект.ТипСообщения=Перечисления.ОбменДаннымиТипыСообщений.Исходящее Тогда
//	    Результат=Истина;	
//	Иначе
//	    Результат=Ложь;	
//	КонецЕсли;	
//КонецПроцедуры

//Процедура ОтправитьДанныеПроверкаУсловия(ТочкаМаршрутаБизнесПроцесса, Результат)
//	Результат=((НЕ ЭтотОбъект.ВидСообщения.ОтправитьДанные.Пустая()) И (НЕ ЭтотОбъект.ЕстьОшибка));
//КонецПроцедуры

//Процедура НуженXMLПроверкаУсловия(ТочкаМаршрутаБизнесПроцесса, Результат)
//	Результат=ЭтотОбъект.ВидСообщения.НуженXML;
//КонецПроцедуры

//Процедура ПередЗаписью(Отказ)
//	Если ЭтотОбъект.Пользователь.Пустая() Тогда
//		ЭтотОбъект.Пользователь=ПараметрыСеанса.ТекущийПользователь;
//	КонецЕсли;	
//	Если ЭтотОбъект.Завершен И (ЭтотОбъект.ДатаЗавершения=Дата(1,1,1)) Тогда
//	   ЭтотОбъект.ДатаЗавершения=ТекущаяДата();	
//   КонецЕсли;	
//   ПередЗаписью1(Отказ);
//КонецПроцедуры

//Процедура ПередЗаписью1(Отказ)
//	Если ЭтотОбъект.ЭтоНовый() Тогда
//		ЭтотОбъект.ДатаСоздания=ТекущаяДата();
//	КонецЕсли;	
//	//Если ВремяОбращения=Дата('00010101') Тогда
//	//	ВремяОбращения=ТекущаяДата();
//	//Иначе	
//	//	ВремяОбращения=ТекущаяДата()+600;
//	//КонецЕсли;	
//КонецПроцедуры

//Процедура ПриВыполнении(Отказ)
//	Попытка
//		Запрос = Новый запрос;
//		Запрос.Текст="
//		|SELECT  ТипСообщения, ВидСообщения
//		|FROM БизнесПроцесс.ОбменДанными
//		|WHERE ССылка=&СсылкаНаБП 
//		|";
//		Запрос.УстановитьПараметр("ССылкаНаБП",ЭтотОбъект.БизнесПроцесс);
//		выб = Запрос.Выполнить().Выбрать();
//		Если Выб.Следующий() Тогда
//			Если Выб.ТипСообщения <> Перечисления.ОбменДаннымиТипыСообщений.Входящее Тогда
//				Возврат;
//			КонецЕсли;
//			обВидСообщенияОбмен = Выб.ВидСообщения;
//		Иначе
//			ВызватьИсключение "Не выбран БП обмен данными в задаче "+ Строка(ЭтотОбъект);
//		КонецЕсли;
//		Если ЭтотОбъект.ТочкаМаршрута = БизнесПроцессы.ОбменДанными.ТочкиМаршрута.ОбработкаXML Тогда
//			Ошибка =  "";
//			Если Не Задачи.спринтВходящие.спринтЗавершениеОбработки(ЭтотОбъект.БизнесПроцесс, Выб.ВидСообщения, Ошибка) Тогда
//				ВызватьИсключение "Не создано подтверждение обработки спринт входящие" + Символы.ПС + Ошибка;
//			КонецЕсли;
//		ИначеЕсли ЭтотОбъект.ТочкаМаршрута = БизнесПроцессы.ОбменДанными.ТочкиМаршрута.ОтправкаПодтверждения Тогда
//			Запрос=Новый Запрос;
//			Запрос.Текст = "
//			|SELECT  Top 1 т1.ССылка,
//			|	т1.Отправитель,
//			|	т1.Выполнена,
//			|	т2.УведомлятьОбОбработке,
//			|	т1.ИДИсходящего
//			|FROM  Задача.спринтВходящие т1,
//			|	Справочник.спринтВидыСообщений т2
//			|WHERE т1.УИД = &УИД
//			|	AND т1.ВидСообщения = т2.ССылка
//			|	
//			|";
//			Запрос.УстановитьПараметр("УИД", ЭтотОбъект.БизнесПроцесс.УникальныйИдентификатор());
//			Выб = Запрос.Выполнить().Выбрать();
//			Если Выб.Следующий() Тогда
//				Если Выб.УведомлятьОбОбработке тогда
//					Ошибка = "";
//					СозданоПодтверждение  = Задачи.спринтВходящие.СоздатьПодтверждениеОбработки(Выб.Ссылка, Выб.Отправитель, Ошибка, ЭтотОбъект.БизнесПроцесс.ВидСообщения);
//					Если СозданоПодтверждение Тогда
//						Задачи.спринтИсходящие.спринтОтправитьHTTPЗапрос(Справочники.спринтВидыСообщений.стандартПодтверждение);
//					Иначе
//						ВызватьИсключение Ошибка;
//					КонецЕсли;
//				КонецЕсли;
//			Иначе
//				//Если срСпринт.спринтВключенНовыйОбмен(обВидСообщенияОбмен) Тогда
//					ВызватьИсключение "При отправке подтверждения Не найдена задача спринт входящие по УИД " +Строка(ЭтотОбъект.БизнесПроцесс.УникальныйИдентификатор())+ "для объекта " + Строка(ЭтотОбъект);
//				//КонецЕсли;
//			КонецЕсли;
//		Иначе
//			Возврат;
//		КонецЕсли;
//	Исключение
//		//НаСервере.ОтправитьЕМайл("","Ошибка завершения выполнения задачи спринт входящие",ОписаниеОшибки());
//		//Если срСпринт.спринтВключенНовыйОбмен(обВидСообщенияОбмен) Тогда
//			//Отказ = Истина;
//		//КонецЕсли;
//	КонецПопытки;
//КонецПроцедуры
