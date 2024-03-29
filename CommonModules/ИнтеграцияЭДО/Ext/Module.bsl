﻿
//&Вместо("ВыполнитьКонтрольПроведенияУчетныхДокументов")
Процедура pcru_ex_ВыполнитьКонтрольПроведенияУчетныхДокументов(Знач ЭлектронныйДокумент)
		ОтключитьКонтрольПроведенияУчетныхДокументовЭД(ЭлектронныйДокумент);
	
	НаборУчетныхДокументов = УчетныеДокументыПоЭлектронномуДокументу(ЭлектронныйДокумент);
	
	НаКонтроль = Новый Массив;
	
	Для Каждого УчетныйДокумент Из НаборУчетныхДокументов Цикл
		
		Если ЭтоПроводимыйДокумент(УчетныйДокумент) Тогда
			//Проведен = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(УчетныйДокумент, "Проведен");
			//Если Не Проведен Тогда
				НаКонтроль.Добавить(УчетныйДокумент);
			//КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
	ВключитьКонтрольПроведенияУчетныхДокументов(ЭлектронныйДокумент, НаКонтроль);

КонецПроцедуры

// Возвращает учетные документы, связанные с переданным входящим электронным документом.
//
// Параметры:
//  ЭлектронныйДокумент - ДокументСсылка.ЭлектронныйДокументВходящий - электронный документ, по которому выполняется поиск.
//
// Возвращаемое значение:
//  Массив - найденные учетные документы.
//
Функция УчетныеДокументыПоЭлектронномуДокументу(Знач ЭлектронныйДокумент)
	
	Запрос = Новый Запрос;
	//Запрос.Текст =
	//"ВЫБРАТЬ РАЗЛИЧНЫЕ
	//|	Основания.ДокументОснование КАК УчетныйДокумент
	//|ИЗ
	//|	Документ.ЭлектронныйДокументВходящий.ДокументыОснования КАК Основания
	//|ГДЕ
	//|	Основания.Ссылка = &ЭлектронныйДокумент";
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	АктуальныеДокументыЭДО.ОбъектУчета КАК УчетныйДокумент
	|ИЗ
	|	РегистрСведений.УдалитьАктуальныеДокументыЭДО КАК АктуальныеДокументыЭДО
	|ГДЕ
	|	АктуальныеДокументыЭДО.ЭлектронныйДокумент = &ЭлектронныйДокумент";

	Запрос.УстановитьПараметр("ЭлектронныйДокумент", ЭлектронныйДокумент);
	
	УстановитьПривилегированныйРежим(Истина);
	Результат = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("УчетныйДокумент");
	УстановитьПривилегированныйРежим(Ложь);
	
	Возврат Результат;
	
КонецФункции

// Возвращает признак того, что объект является документом, поддерживающим проведение.
//
// Параметры:
//  Объект - Произвольный - объект, который нужно проверить.
//
// Возвращаемое значение:
//  Булево - Истина, если объект является документом с проведением. Иначе Ложь.
//
Функция ЭтоПроводимыйДокумент(Знач Объект)
	
	Попытка
		МетаданныеОбъекта = Объект.Метаданные();
	Исключение
		Возврат Ложь;
	КонецПопытки;
	
	Результат = Ложь;
	
	Если Метаданные.Документы.Содержит(МетаданныеОбъекта) Тогда
		Если МетаданныеОбъекта.Проведение = Метаданные.СвойстваОбъектов.Проведение.Разрешить Тогда
			Результат = Истина;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции
