﻿
&Вместо("БНФОПодготовитьДанныеРазделаНачисленКУплате")
Функция pcru_ex_БНФОПодготовитьДанныеРазделаНачисленКУплате(СтруктураПараметров)
УчетНДСПолученногоПоОтгрузке = БНФОУчетнаяПолитика.БНФОУчетНДСПолученногоПоОтгрузке(СтруктураПараметров.Организация, СтруктураПараметров.Дата);

	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	НДСНачисленныйОстатки.СчетФактура КАК СчетФактура,
	|	НДСНачисленныйОстатки.ВидЦенности КАК ВидЦенности,
	|	НДСНачисленныйОстатки.СтавкаНДС КАК СтавкаНДС,
	|	НДСНачисленныйОстатки.Покупатель КАК Покупатель,
	|	НДСНачисленныйОстатки.ДоговорКонтрагента КАК ДоговорКонтрагента,
	|	НДСНачисленныйОстатки.СчетФактура.Дата КАК СчетФактураДата,
	|	НДСНачисленныйОстатки.СуммаБезНДСОстаток КАК СуммаБезНДС,
	|	НДСНачисленныйОстатки.НДСОстаток КАК НДС,
	|	ВЫБОР
	|		КОГДА НДСНачисленныйОстатки.СуммаБезНДСОстаток < 0
	|				ИЛИ НДСНачисленныйОстатки.НДСОстаток < 0
	|			ТОГДА &СобытиеСкорректирован
	|		КОГДА НДСНачисленныйОстатки.ВидЦенности = ЗНАЧЕНИЕ(Перечисление.ВидыЦенностей.АвансыПолученные)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.СобытияПоНДСПродажи.ПолученАванс)
	|		КОГДА НДСНачисленныйОстатки.ВидНачисления = &НДСВидНачисленияНДСНачисленКУплате
	|			ТОГДА &СобытиеНДСНачисленКУплате
	|		КОГДА НДСНачисленныйОстатки.ВидНачисления = &НДСВидНачисленияНДСВосстановлен
	|			ТОГДА &СобытиеНДСВосстановлен
	|		ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.СобытияПоНДСПродажи.Реализация)
	|	КОНЕЦ КАК Событие,
	|	НДСНачисленныйОстатки.ДатаОплаты КАК ДатаОплаты,
	|	НДСНачисленныйОстатки.БНФОДокументОплаты КАК БНФОДокументОплаты,
	|	НДСНачисленныйОстатки.БНФОСчетУчетаНДС КАК БНФОСчетУчетаНДС,
	|	НДСНачисленныйОстатки.БНФОПорядокУчетаВРаспределенииНДС КАК БНФОПорядокУчетаВРаспределенииНДС,
	|	НДСНачисленныйОстатки.БНФОИсправленныйСчетФактура КАК БНФОИсправленныйСчетФактура,
	|	ВЫБОР
	|		КОГДА РеквизитыДокументов.ДатаРегистратора ЕСТЬ NULL
	|				ИЛИ КОНЕЦПЕРИОДА(&Период, КВАРТАЛ) = КОНЕЦПЕРИОДА(РеквизитыДокументов.ДатаРегистратора, КВАРТАЛ)
	|			ТОГДА ЛОЖЬ
	|		ИНАЧЕ ИСТИНА
	|	КОНЕЦ КАК ЗаписьДополнительногоЛиста,
	|	ВЫБОР
	|		КОГДА РеквизитыДокументов.ДатаРегистратора ЕСТЬ NULL
	|				ИЛИ КОНЕЦПЕРИОДА(&Период, КВАРТАЛ) = КОНЕЦПЕРИОДА(РеквизитыДокументов.ДатаРегистратора, КВАРТАЛ)
	|			ТОГДА ДАТАВРЕМЯ(1, 1, 1)
	|		ИНАЧЕ НАЧАЛОПЕРИОДА(РеквизитыДокументов.ДатаРегистратора, КВАРТАЛ)
	|	КОНЕЦ КАК КорректируемыйПериод
	|ИЗ
	|	РегистрНакопления.НДСНачисленный.Остатки(
	|			&КонецПериодаГраница,
	|			Организация = &Организация
	|				И ВидНачисления В (&НДСВидНачисленияНДС)) КАК НДСНачисленныйОстатки
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ДанныеПервичныхДокументов КАК РеквизитыДокументов
	|		ПО НДСНачисленныйОстатки.Организация = РеквизитыДокументов.Организация
	|			И НДСНачисленныйОстатки.СчетФактура = РеквизитыДокументов.Документ
	|ГДЕ
	|	НЕ(НДСНачисленныйОстатки.СуммаБезНДСОстаток = 0
	|				И НДСНачисленныйОстатки.НДСОстаток = 0) //и НДСНачисленныйОстатки.СтавкаНДС  =  &СтавкаНДС 
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	НДСсАвансовОстатки.СчетФактура,
	|	НДСсАвансовОстатки.ВидЦенности,
	|	НДСсАвансовОстатки.СтавкаНДС,
	|	НДСсАвансовОстатки.Покупатель,
	|	НДСсАвансовОстатки.ДоговорКонтрагента,
	|	НДСсАвансовОстатки.СчетФактура.Дата,
	|	НДСсАвансовОстатки.СуммаБезНДСОстаток,
	|	НДСсАвансовОстатки.НДСОстаток,
	|	ВЫБОР
	|		КОГДА НДСсАвансовОстатки.СуммаБезНДСОстаток < 0
	|				ИЛИ НДСсАвансовОстатки.НДСОстаток < 0
	|			ТОГДА &СобытиеСкорректирован
	|		ИНАЧЕ &СобытиеНДСНачисленКУплате
	|	КОНЕЦ,
	|	НДСсАвансовОстатки.БНФОДатаОплаты,
	|	НДСсАвансовОстатки.БНФОДокументОплаты,
	|	НДСсАвансовОстатки.БНФОСчетУчетаНДС,
	|	НЕОПРЕДЕЛЕНО,
	|	НЕОПРЕДЕЛЕНО,
	|	ЛОЖЬ,
	|	ДАТАВРЕМЯ(1, 1, 1)
	|ИЗ
	|	РегистрНакопления.НДСсАвансов.Остатки(
	|			&КонецПериодаГраница,
	|			Организация = &Организация
	|				И БНФОВидОтражения = ЗНАЧЕНИЕ(Перечисление.БНФОВидыОтраженияЗачтенногоНДССАвансов.КОтражениюВКнигеПродаж)) КАК НДСсАвансовОстатки
	|ГДЕ
	|	НЕ(НДСсАвансовОстатки.СуммаБезНДСОстаток = 0
	|				И НДСсАвансовОстатки.НДСОстаток = 0)  //и НДСсАвансовОстатки.СтавкаНДС =  &СтавкаНДС
	|
	|УПОРЯДОЧИТЬ ПО
	|	СчетФактураДата,
	|	СчетФактура";

	ВидыНачисленияНДС = Новый Массив;
	ВидыНачисленияНДС.Добавить(Перечисления.НДСВидНачисления.НДСНачисленКУплате);
	
	Если УчетНДСПолученногоПоОтгрузке Тогда
		ВидыНачисленияНДС.Добавить(Перечисления.НДСВидНачисления.РеализацияСНДС);
//		ВидыНачисленияНДС.Добавить(Перечисления.НДСВидНачисления.РеализацияБезНДС);
		ВидыНачисленияНДС.Добавить(Перечисления.НДСВидНачисления.НДСВосстановлен);
	КонецЕсли;
	
//	Запрос.УстановитьПараметр("СтавкаНДС",  						 Перечисления.СтавкиНДС.НДС18);
    Запрос.УстановитьПараметр("Организация",  						 СтруктураПараметров.Организация);
	Запрос.УстановитьПараметр("Период", 			     			 СтруктураПараметров.Дата);
	Запрос.УстановитьПараметр("КонецПериодаГраница", 			     Новый Граница(КонецДня(СтруктураПараметров.Дата),ВидГраницы.Включая));
	Запрос.УстановитьПараметр("НДСВидНачисленияНДСНачисленКУплате",  Перечисления.НДСВидНачисления.НДСНачисленКУплате);
	Запрос.УстановитьПараметр("НДСВидНачисленияНДСВосстановлен",  	 Перечисления.НДСВидНачисления.НДСВосстановлен);
	Запрос.УстановитьПараметр("НДСВидНачисленияНДС",  				 ВидыНачисленияНДС);
	Запрос.УстановитьПараметр("СобытиеНДСНачисленКУплате", 		 	 Перечисления.СобытияПоНДСПродажи.НДСНачисленКУплате);
	Запрос.УстановитьПараметр("СобытиеНДСВосстановлен", 		 	 Перечисления.СобытияПоНДСПродажи.ВосстановлениеНДС);
	Запрос.УстановитьПараметр("СобытиеСкорректирован", 			 	 Перечисления.СобытияПоНДСПродажи.НДССкорректирован);
	Запрос.УстановитьПараметр("ВидЦенностиСуммыСвязанныеСРасчетами", Перечисления.ВидыЦенностей.СуммыСвязанныеСРасчетамиПоОплате);
	Запрос.УстановитьПараметр("ПустаяДата", '00010101');

	Возврат Запрос.Выполнить().Выгрузить();
	
	
//	Результат = ПродолжитьВызов(СтруктураПараметров);
//	Возврат Результат;
КонецФункции
