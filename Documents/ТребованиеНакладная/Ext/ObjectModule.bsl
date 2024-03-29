﻿
&Вместо("ЗаполнитьПоДокументуОснованию")
Процедура pcru_ex_ЗаполнитьПоДокументуОснованию(Основание)
	Если ТипЗнч(Основание) = Тип("ДокументСсылка.ПоступлениеТоваровУслуг") Тогда
		
		// Заполним реквизиты из стандартного набора по документу основанию.
		ЗаполнениеДокументов.ЗаполнитьПоОснованию(ЭтотОбъект, Основание);
		
		мДокументОснование 		 = Основание;
		ПодразделениеОрганизации = Основание.ПодразделениеОрганизации;
		Если Основание.ВидОперации = Перечисления.ВидыОперацийПоступлениеТоваровУслуг.ВПереработку Тогда
			Контрагент = Основание.Контрагент;
			ИмяТаблицы	= "МатериалыЗаказчика";
		Иначе
			ИмяТаблицы	= "Материалы";
		КонецЕсли;
		
		ДанныеОбъекта = Новый Структура("Дата, Организация, Склад");
		ЗаполнитьЗначенияСвойств(ДанныеОбъекта, ЭтотОбъект);
		
		Для Каждого ТекСтрокаТовары Из Основание.Товары Цикл
			
			СтрокаТабличнойЧасти                  = ЭтотОбъект[ИмяТаблицы].Добавить();
			СтрокаТабличнойЧасти.Номенклатура     = ТекСтрокаТовары.Номенклатура;
			СтрокаТабличнойЧасти.Количество       = ТекСтрокаТовары.Количество;
			СтрокаТабличнойЧасти.ЕдиницаИзмерения = ТекСтрокаТовары.ЕдиницаИзмерения;
			СтрокаТабличнойЧасти.КоличествоМест   = ТекСтрокаТовары.КоличествоМест;
			СтрокаТабличнойЧасти.Коэффициент      = ТекСтрокаТовары.Коэффициент;
			//++ Севрюгин А.А
			СтрокаТабличнойЧасти.Счет             = ТекСтрокаТовары.СчетУчета;
			//-- Севрюгин А.А
			 
			
			Если ИмяТаблицы	= "Материалы" Тогда
				СтрокаТабличнойЧасти.ОтражениеВУСН = Перечисления.ОтражениеВУСН.Принимаются;
			КонецЕсли;
			
		КонецЦикла;
	ИначеЕсли ТипЗнч(Основание) = Тип("ДокументСсылка.АвансовыйОтчет") Тогда
		
		// Заполним реквизиты из стандартного набора по документу основанию.
		ЗаполнениеДокументов.ЗаполнитьПоОснованию(ЭтотОбъект, Основание);
		
		ПодразделениеОрганизации = Основание.ПодразделениеОрганизации;
		
		СписокНоменклатуры = Основание.Товары.ВыгрузитьКолонку("Номенклатура");
		ЕдиницыИзмерения = ОбщегоНазначения.ЗначениеРеквизитаОбъектов(СписокНоменклатуры, "ЕдиницаИзмерения");
		Для Каждого СтрокаОснования Из Основание.Товары Цикл
			
			НоваяСтрока                     = Материалы.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаОснования, "Номенклатура, Количество, НомерГТД, СтранаПроисхождения");
			НоваяСтрока.ЕдиницаИзмерения    = ЕдиницыИзмерения[СтрокаОснования.Номенклатура];
			НоваяСтрока.Коэффициент         = 1;
			НоваяСтрока.ОтражениеВУСН       = Перечисления.ОтражениеВУСН.Принимаются;
			
		КонецЦикла;
	ИначеЕсли ТипЗнч(Основание) = Тип("ДокументСсылка.ОтчетПроизводстваЗаСмену") Тогда
		
		// Заполним реквизиты из стандартного набора по документу основанию.
		ЗаполнениеДокументов.ЗаполнитьПоОснованию(ЭтотОбъект, Основание);

		СчетаУчетаЗатратВТаблице = Истина;
		
		// Подготовим исходные данные для заполнения табличной части
		МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
		Запрос = Новый Запрос();
		Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
		Запрос.Параметры.Вставить("Основание", Основание);
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	Хозрасчетный.Ссылка КАК Счет
		|ПОМЕСТИТЬ СчетаПроизводствоИзДавальческогоСырья
		|ИЗ
		|	ПланСчетов.Хозрасчетный КАК Хозрасчетный
		|ГДЕ
		|	Хозрасчетный.Ссылка В ИЕРАРХИИ (ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПроизводствоИзДавальческогоСырья))
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Счет
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВЫБОР
		|		КОГДА СчетаПроизводствоИзДавальческогоСырья.Счет ЕСТЬ NULL
		|			ТОГДА ЛОЖЬ
		|		ИНАЧЕ ИСТИНА
		|	КОНЕЦ КАК ПроизводствоИзМатериаловЗаказчика,
		|	ОтчетПроизводстваЗаСменуПродукция.НомерСтроки КАК НомерСтрокиВыпуск,
		|	ОтчетПроизводстваЗаСменуПродукция.Спецификация КАК Спецификация,
		|	ОтчетПроизводстваЗаСменуПродукция.Количество КАК КоличествоПродукции,
		|	ОтчетПроизводстваЗаСменуПродукция.Ссылка.ПодразделениеЗатрат КАК ПодразделениеЗатрат,
		|	ОтчетПроизводстваЗаСменуПродукция.НоменклатурнаяГруппа КАК НоменклатурнаяГруппа,
		|	ОтчетПроизводстваЗаСменуПродукция.Ссылка.СчетЗатрат КАК СчетЗатрат
		|ПОМЕСТИТЬ Выпуск
		|ИЗ
		|	Документ.ОтчетПроизводстваЗаСмену.Продукция КАК ОтчетПроизводстваЗаСменуПродукция
		|		ЛЕВОЕ СОЕДИНЕНИЕ СчетаПроизводствоИзДавальческогоСырья КАК СчетаПроизводствоИзДавальческогоСырья
		|		ПО ОтчетПроизводстваЗаСменуПродукция.Счет = СчетаПроизводствоИзДавальческогоСырья.Счет
		|ГДЕ
		|	ОтчетПроизводстваЗаСменуПродукция.Ссылка = &Основание
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ЛОЖЬ,
		|	ОтчетПроизводстваЗаСменуУслуги.НомерСтроки,
		|	ОтчетПроизводстваЗаСменуУслуги.Спецификация,
		|	ОтчетПроизводстваЗаСменуУслуги.Количество,
		|	ОтчетПроизводстваЗаСменуУслуги.Ссылка.ПодразделениеЗатрат,
		|	ОтчетПроизводстваЗаСменуУслуги.НоменклатурнаяГруппа,
		|	ОтчетПроизводстваЗаСменуУслуги.Ссылка.СчетЗатрат
		|ИЗ
		|	Документ.ОтчетПроизводстваЗаСмену.Услуги КАК ОтчетПроизводстваЗаСменуУслуги
		|ГДЕ
		|	ОтчетПроизводстваЗаСменуУслуги.Ссылка = &Основание
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Спецификация
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|УНИЧТОЖИТЬ СчетаПроизводствоИзДавальческогоСырья";
		
		Запрос.Выполнить();
		
		ЗаполнитьМатериалыПоДаннымОВыпуске(МенеджерВременныхТаблиц);
		
	ИначеЕсли ТипЗнч(Основание) = Тип("ДокументСсылка.АктОбОказанииПроизводственныхУслуг") Тогда
		
		// Заполним реквизиты из стандартного набора по документу основанию.
		ЗаполнениеДокументов.ЗаполнитьПоОснованию(ЭтотОбъект, Основание);

		СчетаУчетаЗатратВТаблице = Истина;
		
		// Подготовим исходные данные для заполнения табличной части
		МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
		Запрос = Новый Запрос();
		Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
		Запрос.Параметры.Вставить("Основание", Основание);
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЛОЖЬ КАК ПроизводствоИзМатериаловЗаказчика,
		|	АктОбОказанииПроизводственныхУслугУслуги.НомерСтроки КАК НомерСтрокиВыпуск,
		|	АктОбОказанииПроизводственныхУслугУслуги.Спецификация КАК Спецификация,
		|	АктОбОказанииПроизводственныхУслугУслуги.Количество КАК КоличествоПродукции,
		|	АктОбОказанииПроизводственныхУслугУслуги.Ссылка.ПодразделениеЗатрат КАК ПодразделениеЗатрат,
		|	АктОбОказанииПроизводственныхУслугУслуги.Ссылка.НоменклатурнаяГруппа КАК НоменклатурнаяГруппа,
		|	АктОбОказанииПроизводственныхУслугУслуги.Ссылка.СчетЗатрат КАК СчетЗатрат
		|ПОМЕСТИТЬ Выпуск
		|ИЗ
		|	Документ.АктОбОказанииПроизводственныхУслуг.Услуги КАК АктОбОказанииПроизводственныхУслугУслуги
		|ГДЕ
		|	АктОбОказанииПроизводственныхУслугУслуги.Ссылка = &Основание
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Спецификация";
		Запрос.Выполнить();
		
		ЗаполнитьМатериалыПоДаннымОВыпуске(МенеджерВременныхТаблиц);
		
	ИначеЕсли ТипЗнч(Основание) = Тип("ДокументСсылка.РеализацияУслугПоПереработке") Тогда
		// Заполнение шапки
		Комментарий        = Основание.Комментарий;
		Контрагент         = Основание.Контрагент;
		Организация        = Основание.Организация;
		мДокументОснование = Основание;
		ПодразделениеОрганизации = Основание.ПодразделениеОрганизации;
		Для Каждого ТекСтрокаМатериалыЗаказчика ИЗ Основание.МатериалыЗаказчика Цикл
			НоваяСтрока              = МатериалыЗаказчика.Добавить();
			НоваяСтрока.Количество   = ТекСтрокаМатериалыЗаказчика.Количество;
			НоваяСтрока.Номенклатура = ТекСтрокаМатериалыЗаказчика.Номенклатура;
			НоваяСтрока.СчетПередачи = ТекСтрокаМатериалыЗаказчика.СчетУчета;
		КонецЦикла;
		
	ИначеЕсли ТипЗнч(Основание) = Тип("ДокументСсылка.ПеремещениеТоваров") Тогда
		
		ЗаполнениеДокументов.ЗаполнитьПоОснованию(ЭтотОбъект, Основание);
		
		Склад                    = Основание.СкладПолучатель;
		ПодразделениеОрганизации = Основание.ПодразделениеПолучатель;
		
		Для Каждого СтрокаОснования Из Основание.Товары Цикл
			
			НоваяСтрока = Материалы.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаОснования, "Номенклатура, КоличествоМест, ЕдиницаИзмерения, Коэффициент, Количество");
			НоваяСтрока.ОтражениеВУСН = Перечисления.ОтражениеВУСН.Принимаются;
			
		КонецЦикла;
		
		// Не поддерживается перемещение материалов, принятых в переработку
		
	КонецЕсли;

	Если НЕ ЗначениеЗаполнено(Дата) Тогда
		Дата = НачалоДня(ТекущаяДатаСеанса());
	КонецЕсли;

	НДСвСтоимостиТоваров = Перечисления.ДействиеНДСВСтоимостиТоваров.НеИзменять;
	ДляСписанияНДСИспользоватьСчетИАналитикуУчетаЗатрат = Ложь;
	Ответственный = Пользователи.ТекущийПользователь();

КонецПроцедуры

