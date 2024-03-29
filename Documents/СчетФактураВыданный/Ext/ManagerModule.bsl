﻿
&Вместо("ТекстЗапросаНомераДокументовОплаты")
Функция pcru_ex_ТекстЗапросаНомераДокументовОплаты(НомераТаблиц, ПараметрыПроведения, Реквизиты)
	
	Попытка
		Продавец =Реквизиты.Продавец
	Исключение
	  Продавец  = Неопределено;
	КонецПопытки;
		
	Если НЕ Реквизиты.ПравилаПостановления735 
		ИЛИ Реквизиты.ВидСчетаФактуры = Перечисления.ВидСчетаФактурыВыставленного.НаАванс 
		ИЛИ Реквизиты.ВидСчетаФактуры = Перечисления.ВидСчетаФактурыВыставленного.НалоговыйАгент 
		ИЛИ ЗначениеЗаполнено(Продавец) Тогда
		ПараметрыПроведения.Вставить("ВТ_ЗаписиКнигиПродажПредварительная", Неопределено);
		ПараметрыПроведения.Вставить("ВТ_ЗаписиКнигиПродаж",    			Неопределено);
		ПараметрыПроведения.Вставить("ТаблицаНомеровДокументовОплаты",    	Неопределено);
		Возврат "";
	КонецЕсли;
	
	НомераТаблиц.Вставить("ВТ_ЗаписиКнигиПродажПредварительная", НомераТаблиц.Количество());
	НомераТаблиц.Вставить("ВТ_ЗаписиКнигиПродаж", НомераТаблиц.Количество());
	НомераТаблиц.Вставить("ТаблицаНомеровДокументовОплаты", НомераТаблиц.Количество());
	
	ТекстЗапроса =  
	"ВЫБРАТЬ
	|	НДСЗаписиКнигиПродаж.Организация,
	|	НДСЗаписиКнигиПродаж.СчетФактура,
	|	НДСЗаписиКнигиПродаж.Покупатель,
	|	&Ссылка КАК СчетФактураДокумент,
	|	НДСЗаписиКнигиПродаж.СтавкаНДС,
	|	НДСЗаписиКнигиПродаж.ВидЦенности,
	|	НДСЗаписиКнигиПродаж.ДатаОплаты,
	|	НДСЗаписиКнигиПродаж.ДокументОплаты,
	|	НДСЗаписиКнигиПродаж.Событие,
	|	НДСЗаписиКнигиПродаж.ДатаСобытия,
	|	НДСЗаписиКнигиПродаж.ДоговорКонтрагента,
	|	НДСЗаписиКнигиПродаж.ЗаписьДополнительногоЛиста,
	|	НДСЗаписиКнигиПродаж.КорректируемыйПериод,
	|	НДСЗаписиКнигиПродаж.СторнирующаяЗаписьДопЛиста,
	|	НДСЗаписиКнигиПродаж.ИсправленныйСчетФактура
	|ПОМЕСТИТЬ ВТ_ЗаписиКнигиПродажПредварительная
	|ИЗ
	|	РегистрНакопления.НДСЗаписиКнигиПродаж КАК НДСЗаписиКнигиПродаж
	|ГДЕ
	|	НДСЗаписиКнигиПродаж.СчетФактура = &ДокументОснование
	|	И НДСЗаписиКнигиПродаж.Активность
	|	И НДСЗаписиКнигиПродаж.Регистратор = &ДокументОснование
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	НДСЗаписиКнигиПродаж.Организация,
	|	НДСЗаписиКнигиПродаж.СчетФактура,
	|	НДСЗаписиКнигиПродаж.Покупатель,
	|	НДСЗаписиКнигиПродаж.СчетФактура,
	|	НДСЗаписиКнигиПродаж.СтавкаНДС,
	|	НДСЗаписиКнигиПродаж.ВидЦенности,
	|	НДСЗаписиКнигиПродаж.ДатаОплаты,
	|	НДСЗаписиКнигиПродаж.ДокументОплаты,
	|	НДСЗаписиКнигиПродаж.Событие,
	|	НДСЗаписиКнигиПродаж.ДатаСобытия,
	|	НДСЗаписиКнигиПродаж.ДоговорКонтрагента,
	|	НДСЗаписиКнигиПродаж.ЗаписьДополнительногоЛиста,
	|	НДСЗаписиКнигиПродаж.КорректируемыйПериод,
	|	НДСЗаписиКнигиПродаж.СторнирующаяЗаписьДопЛиста,
	|	НДСЗаписиКнигиПродаж.ИсправленныйСчетФактура
	|ИЗ
	|	РегистрНакопления.НДСЗаписиКнигиПродаж КАК НДСЗаписиКнигиПродаж
	|ГДЕ
	|	НДСЗаписиКнигиПродаж.СчетФактура = &Ссылка
	|	И НДСЗаписиКнигиПродаж.Активность
	|	И НДСЗаписиКнигиПродаж.Регистратор = &ДокументОснование
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ ПЕРВЫЕ 1
	|	ВТ_ЗаписиКнигиПродажПредварительная.Организация,
	|	ВТ_ЗаписиКнигиПродажПредварительная.СчетФактура,
	|	ВТ_ЗаписиКнигиПродажПредварительная.Покупатель,
	|	ВТ_ЗаписиКнигиПродажПредварительная.СчетФактураДокумент,
	|	ВТ_ЗаписиКнигиПродажПредварительная.СтавкаНДС,
	|	ВТ_ЗаписиКнигиПродажПредварительная.ВидЦенности,
	|	ВТ_ЗаписиКнигиПродажПредварительная.ДатаОплаты,
	|	ВТ_ЗаписиКнигиПродажПредварительная.ДокументОплаты,
	|	ВТ_ЗаписиКнигиПродажПредварительная.Событие,
	|	ВТ_ЗаписиКнигиПродажПредварительная.ДатаСобытия,
	|	ВТ_ЗаписиКнигиПродажПредварительная.ДоговорКонтрагента,
	|	ВТ_ЗаписиКнигиПродажПредварительная.ЗаписьДополнительногоЛиста,
	|	ВТ_ЗаписиКнигиПродажПредварительная.КорректируемыйПериод,
	|	ВТ_ЗаписиКнигиПродажПредварительная.СторнирующаяЗаписьДопЛиста,
	|	ВТ_ЗаписиКнигиПродажПредварительная.ИсправленныйСчетФактура
	|ПОМЕСТИТЬ ВТ_ЗаписиКнигиПродаж
	|ИЗ
	|	ВТ_ЗаписиКнигиПродажПредварительная КАК ВТ_ЗаписиКнигиПродажПредварительная
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	СчетФактураВыданныйПлатежноРасчетныеДокументы.ДатаДокумента КАК ДатаДокументаОплаты,
	|	СчетФактураВыданныйПлатежноРасчетныеДокументы.НомерДокумента КАК НомерДокументаОплаты,
	|	ВТ_ЗаписиКнигиПродаж.Организация КАК Организация,
	|	ВТ_ЗаписиКнигиПродаж.СчетФактура КАК СчетФактура,
	|	&Период КАК Период,
	|	ВТ_ЗаписиКнигиПродаж.Покупатель КАК Покупатель,
	|	ВТ_ЗаписиКнигиПродаж.СтавкаНДС,
	|	ВТ_ЗаписиКнигиПродаж.ВидЦенности,
	|	ВТ_ЗаписиКнигиПродаж.ДатаОплаты,
	|	ВТ_ЗаписиКнигиПродаж.ДокументОплаты,
	|	ВТ_ЗаписиКнигиПродаж.Событие,
	|	ВТ_ЗаписиКнигиПродаж.ДатаСобытия,
	|	ВТ_ЗаписиКнигиПродаж.ДоговорКонтрагента,
	|	ВТ_ЗаписиКнигиПродаж.ЗаписьДополнительногоЛиста,
	|	ВТ_ЗаписиКнигиПродаж.КорректируемыйПериод,
	|	ВТ_ЗаписиКнигиПродаж.СторнирующаяЗаписьДопЛиста,
	|	ВТ_ЗаписиКнигиПродаж.ИсправленныйСчетФактура
	|ИЗ
	|	ВТ_ЗаписиКнигиПродаж КАК ВТ_ЗаписиКнигиПродаж
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.СчетФактураВыданный.ПлатежноРасчетныеДокументы КАК СчетФактураВыданныйПлатежноРасчетныеДокументы
	|		ПО ВТ_ЗаписиКнигиПродаж.СчетФактураДокумент = СчетФактураВыданныйПлатежноРасчетныеДокументы.Ссылка
	|ГДЕ
	|	СчетФактураВыданныйПлатежноРасчетныеДокументы.Ссылка = &Ссылка";
	
	Возврат ТекстЗапроса + ОбщегоНазначенияБПВызовСервера.ТекстРазделителяЗапросовПакета();

КонецФункции
