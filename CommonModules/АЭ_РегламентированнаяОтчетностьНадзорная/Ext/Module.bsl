﻿
&Вместо("ФинНормативы_РассчитатьПоказательМФО")
Функция pcru_ex_ФинНормативы_РассчитатьПоказательМФО(СтруктураРасчета, ИмяПоказателя, ЗаполнятьРасчитанныеПоказатели)
	// Вставить содержимое метода.
	Результат = ПродолжитьВызов(СтруктураРасчета, ИмяПоказателя, ЗаполнятьРасчитанныеПоказатели);
	
	Если ИмяПоказателя = "Зс" Тогда
		Если СтруктураРасчета.Свойство("ДанныеРасшифровки") Тогда
			Если СтруктураРасчета.ДанныеРасшифровки.Свойство(ИмяПоказателя) Тогда
				Если СтруктураРасчета.ДанныеРасшифровки.Зс.Свойство("ОстаточнаяСтоимостьПривлеченнойЗадолженности") Тогда
					СуммаПоказателя = 0;
					Для Каждого Строка Из СтруктураРасчета.ДанныеРасшифровки.Зс.ОстаточнаяСтоимостьПривлеченнойЗадолженности Цикл
						Если ЗначениеЗаполнено(Строка.Займ) Тогда
							КурсНаДату = РаботаСКурсамиВалют.ПолучитьКурсВалюты(Строка.Займ.Валюта, СтруктураРасчета.ДатаРасчета);
							Курс		= КурсНаДату.Курс;
							Кратность	= КурсНаДату.Кратность;
							Строка.Сумма = Строка.Сумма * Курс * Кратность;
							СуммаПоказателя = СуммаПоказателя + Строка.Сумма;
						КонецЕсли;
					КонецЦикла;
					
					Для Каждого Строка Из СтруктураРасчета.ДанныеРасшифровки.Зс.ОстаточнаяСтоимостьПривлеченнойЗадолженности Цикл
						Если ЗначениеЗаполнено(Строка.Займ) Тогда
							Продолжить;
						Иначе
							Строка.Сумма = СуммаПоказателя;
						КонецЕсли;
					КонецЦикла;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		
		МассивПоказателей = Новый Массив;
		МассивПоказателей.Добавить(ИмяПоказателя);
		МассивПоказателей.Добавить("ОстаточнаяСтоимостьПривлеченнойЗадолженности");
		Для Каждого Показатель Из МассивПоказателей Цикл
			Если СтруктураРасчета.РассчитанныеПоказатели.Свойство(Показатель) Тогда
				СтруктураРасчета.РассчитанныеПоказатели.Удалить(Показатель);
				СтруктураРасчета.РассчитанныеПоказатели.Вставить(Показатель, СуммаПоказателя);
			КонецЕсли;
		КонецЦикла;		
		
		Для Каждого Строка Из СтруктураРасчета.ТаблицаРасшифровки Цикл
			Если Строка.ИмяПоказателя <> ИмяПоказателя ИЛИ Строка.Сумма = 0 Тогда
				Продолжить;
			КонецЕсли;
			
			Если Строка.НаименованиеСлагаемого = "Основной долг по кредитам (займам) (учредителей)" Тогда
				Строка.Сумма = СуммаПоказателя;
			КонецЕсли;
		КонецЦикла;
		
		Если СуммаПоказателя = Неопределено Тогда
			СуммаПоказателя = 0;
		КонецЕсли;
		
		Результат = СуммаПоказателя;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции
