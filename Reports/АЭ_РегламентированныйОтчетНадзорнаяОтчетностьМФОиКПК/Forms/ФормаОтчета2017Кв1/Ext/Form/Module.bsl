﻿
&НаКлиенте
Процедура pcru_ex_pcru_ЗагрузкаИтоговПоЗаймамВместо(Команда)
	
	тДиалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	тДиалог.Фильтр = "MS Office Excel|*.xls;*.xlsx|Все файлы (*.*)|*.*";
	тДиалог.ИндексФильтра = 1;
	тДиалог.МножественныйВыбор = Ложь;
	тДиалог.Показать(Новый ОписаниеОповещения("ВыборФайлаПоказатьОбработка", ЭтотОбъект));

КонецПроцедуры

&НаКлиенте
Процедура ВыборФайлаПоказатьОбработка(ВыбранныеФайлы, ДопПараметры) Экспорт
	Если ВыбранныеФайлы = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ВыбранныйФайл = ВыбранныеФайлы[0];	
	Попытка 
		КомОбъект = ПолучитьCOMобъект("","Excel.Application");
	Исключение
		Сообщить("Excel Application не создан!!");
		Возврат;
	КонецПопытки;

	Попытка
		КомОбъект.workbooks.open(ВыбранныйФайл, 1);
	Исключение
		Сообщить("Файл перемещен или удален!");
		Возврат;
	КонецПопытки;
	
	
	ОчиститьНаСервере("ОД_Раздел4");
	RowCount = КомОбъект.ActiveSheet.UsedRange.Rows.Count();
	ИндексСтрока = 13;
	ИндексНачалаПропуска = 11;
	

	Пока ИндексСтрока <= RowCount Цикл
		Состояние("Загрузка данных в отчет из файла", RowCount / 100 * ИндексСтрока);
		
		Если КомОбъект.ActiveSheet.Cells(ИндексСтрока, 3).Value = "" ИЛИ КомОбъект.ActiveSheet.Cells(ИндексСтрока, 3).Value = Неопределено Тогда
			Прервать;
		КонецЕсли;
		
		Для ИндексСтолбец = 3 По 17 Цикл
			//П000100100303 П000100100304 ... П000100100310  и  П000100100311 П000100100312 ... П000100100317
			//П000100100403
			Ячейка = "П00010010" + Прав("0" + Строка(ИндексСтрока - 10), 2) + Прав("0" + Строка(ИндексСтолбец), 2);
			Попытка
			ЭтотОбъект.СтруктураДанныхОД_Раздел4[Ячейка] = Число(КомОбъект.ActiveSheet.Cells(ИндексСтрока, ИндексСтолбец).Value) * 1000;
			Исключение
            КонецПопытки;
		КонецЦикла;
		
		ИндексСтрока = ИндексСтрока + 1;		
		Если ИндексСтрока = ИндексНачалаПропуска + 6 Тогда
			ИндексНачалаПропуска = ИндексНачалаПропуска + 6;
			ИндексСтрока = ИндексСтрока + 2;
		КонецЕсли;	
	КонецЦикла;
	
	ВывестиМакетВТаблДокНаСервере("ОД_Раздел4");
	РасчетНаСервере("ОД_Раздел4");

	КомОбъект.workbooks.Close();
	КомОбъект.quit();
	
	Состояние("Загрузка завершена");
	Модифицированность = Истина;
	
КонецПроцедуры

&НаСервере
&ИзменениеИКонтроль("СформироватьСоставПоказателей")
Процедура pcru_ex_СформироватьСоставПоказателей()

	ЭтотОбъект.ОкругляемыеПоказатели = Новый Структура;
	ЭтотОбъект.КодыПоказателейДляМнемокодов = Новый Структура;

	//
	ПолучитьСтруктуруМногострочныхЧастей();
	//

	ПолучитьТаблицуСоставаПоказателей();
	ТаблицаСоставПоказателей.Очистить();

	МакетСоставаПоказателей = ОбъектОтчета(ЭтотОбъект.ИмяФормы).ПолучитьМакет(НастройкиФормы.МакетСоставаПоказателей);
	МакетСоставаПоказателей.Вывести(ОбъектОтчета(ЭтотОбъект.ИмяФормы).ПолучитьМакет(НастройкиФормы.МакетСоставаПоказателей2));

	Для Каждого Отчет Из СтруктураОтчета Цикл

		ИмяСтраницы = Отчет.Значение.ИмяСтраницы;
		ИмяОбласти  = Отчет.Значение.ИмяСекцииПоказателей;

		ТекОбласть = МакетСоставаПоказателей.Области[ИмяОбласти];

		ЭтотОбъект["ТаблицаВариантыЗаполнения" + ИмяСтраницы].Добавить();

		ЭтотОбъект.ОкругляемыеПоказатели.Вставить(ИмяСтраницы, Новый Структура);

		ЭтотОбъект.КодыПоказателейДляМнемокодов.Вставить(ИмяСтраницы, Новый Соответствие);

		Для Ном = ТекОбласть.Верх По ТекОбласть.Низ Цикл
			// перебираем строки макета

			// Код показателя (по составу показателей) определяется по первой колонке макета
			КодПоказателя = СокрП(МакетСоставаПоказателей.Область(Ном, 1).Текст);

			Если КодПоказателя = "===" Тогда         // признак конечной строки
				Прервать;
			КонецЕсли;

			Если Лев(КодПоказателя, 2) = "//" Тогда  // пропускаем комментарии
				Продолжить;
			КонецЕсли;

			// код показателя по форме отчете (имя ячейки в полях табличного документа формы)
			КодПоказателяПоФорме = СокрЛП(МакетСоставаПоказателей.Область(Ном, 2).Текст);
			// признак многострочности определяется по третьей колонке макета
			ПризнМногострочность = СокрЛП(МакетСоставаПоказателей.Область(Ном, 3).Текст);
			// по четвертой колонке определяется тип данных реквизита
			ТипДанныхРеквизита   = СокрЛП(МакетСоставаПоказателей.Область(Ном, 4).Текст);
			// вариант заполнения ячейки определяется по колонке 6 макета
			стрВариантЗаполнения = СокрЛП(МакетСоставаПоказателей.Область(Ном, 6).Текст);
			// мнемокод показателя определяется по колонке 8 макета
			МнемокодПоказателя = СокрЛП(МакетСоставаПоказателей.Область(Ном, 8).Текст);

			#Вставка
			Если КодПоказателя = "П100100200103" ИЛИ КодПоказателя = "П100100200104" ИЛИ КодПоказателя = "П100100200106" ИЛИ КодПоказателя = "П100100200107" ИЛИ КодПоказателя = "П100100200108" ИЛИ КодПоказателя = "П000100100116" Тогда
				стрВариантЗаполнения = "3";
			КонецЕсли;
			#КонецВставки
			чВариантЗаполнения   = ? (ПустаяСтрока(стрВариантЗаполнения), 0, Число(стрВариантЗаполнения));

			// формируем таблицу значений, содержащей состав показателей отчета
			НоваяСтрока = ТаблицаСоставПоказателей.Добавить();
			НоваяСтрока.ИмяПоляТаблДокумента	= ИмяСтраницы;
			НоваяСтрока.КодПоказателяПоСоставу	= КодПоказателя;
			НоваяСтрока.КодПоказателяПоФорме	= КодПоказателяПоФорме;
			НоваяСтрока.ПризнМногострочности	= ПризнМногострочность;
			НоваяСтрока.ТипДанныхПоказателя		= ТипДанныхРеквизита;
			НоваяСтрока.МнемокодПоказателя		= МнемокодПоказателя;

			//Если чВариантЗаполнения <> 0 Тогда
			Если ЗначениеЗаполнено(КодПоказателя) Тогда
				НоваяСтрока = ЭтотОбъект["ТаблицаВариантыЗаполнения" + ИмяСтраницы][0].ТаблицаВариантовЗаполнения.Добавить();
				НоваяСтрока.КодПоказателя      = ? (Не ПустаяСтрока(КодПоказателяПоФорме), КодПоказателяПоФорме, КодПоказателя);
				НоваяСтрока.ВариантЗаполнения  = чВариантЗаполнения;								
			КонецЕсли;

			Если ТипДанныхРеквизита = "Е" И чВариантЗаполнения = 4 Тогда
				ЭтотОбъект.ОкругляемыеПоказатели[ИмяСтраницы].Вставить(КодПоказателя);
			КонецЕсли;

			Если ЗначениеЗаполнено(МнемокодПоказателя) Тогда
				ЭтотОбъект.КодыПоказателейДляМнемокодов[ИмяСтраницы].Вставить(МнемокодПоказателя, КодПоказателя);
			КонецЕсли;

		КонецЦикла;

		Если ЭтотОбъект["ТаблицаВариантыЗаполнения" + ИмяСтраницы][0].ТаблицаВариантовЗаполнения.Количество() > 0 Тогда

			мСтруктураВариантыЗаполнения.Вставить(ИмяСтраницы, ИмяСтраницы);
			мСтруктураВариантыЗаполненияЭталон.Вставить(ИмяСтраницы, ИмяСтраницы);

		Конецесли;

		//
		Для Каждого ЭлементСтруктуры Из СтруктураМногострочныхЧастей(ИмяСтраницы) Цикл			

			ПоказателиМСЧ = ЭлементСтруктуры.Значение.Состав;
			Если ПоказателиМСЧ.Количество() = 0 Тогда
				Продолжить;
			КонецЕсли;

			Для Каждого ЭлементСтруктурыПоказателя Из ПоказателиМСЧ[0] Цикл
				ОтборСтрок = Новый Структура("КодПоказателя", ЭлементСтруктурыПоказателя.Ключ);
				Строки = ЭтотОбъект["ТаблицаВариантыЗаполнения" + ИмяСтраницы][0].ТаблицаВариантовЗаполнения.НайтиСтроки(ОтборСтрок);				
				Если Строки.Количество() = 0 Тогда
					НоваяСтрока = ЭтотОбъект["ТаблицаВариантыЗаполнения" + ИмяСтраницы][0].ТаблицаВариантовЗаполнения.Добавить();
					НоваяСтрока.КодПоказателя      = ЭлементСтруктурыПоказателя.Ключ;
					НоваяСтрока.ВариантЗаполнения  = 0;
				КонецЕсли;
			КонецЦикла;			

		КонецЦикла;
		//

	КонецЦикла;

	СтруктураРеквизитовФормы.АдресВоВремХранилищеТаблицаСоставПоказателей
	= ПоместитьВоВременноеХранилище(ТаблицаСоставПоказателей, УникальныйИдентификатор);	

КонецПроцедуры
