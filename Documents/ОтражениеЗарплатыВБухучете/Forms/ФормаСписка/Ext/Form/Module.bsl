﻿
&НаКлиенте
Процедура pcru_ex_ЗагрузитьИзЗупПосле(Команда)
	pcru_ex_ЗУП.ЗагрузкаДокументовИзЗУП();
КонецПроцедуры

&НаКлиенте
Процедура pcru_ex_ПерезагрузитьИзЗупВместо(Команда)
	Если Элементы.Список.ТекущиеДанные <> Неопределено Тогда
		pcru_ex_ЗУП.ПереЗагрузкаОтраженияИзЗУП(Элементы.Список.ТекущиеДанные.Ссылка)
	КонецЕсли; 
КонецПроцедуры


&НаКлиенте
Процедура pcru_ex_ЗагрузитьИзЗупПоНовомуПосле(Команда)
	pcru_ex_ЗУП.ЗагрузкаДокументовИзЗУППоНовому();
	Элементы.Список.Обновить();
КонецПроцедуры

&НаКлиенте
Процедура pcru_ex_ПерезагрузитьИзЗупПоНовомуПосле(Команда)
	Если Элементы.Список.ТекущиеДанные <> Неопределено Тогда
		pcru_ex_ЗУП.ПереЗагрузкаОтраженияИзЗУППоНовому(Элементы.Список.ТекущиеДанные.Ссылка);
		Элементы.Список.Обновить();
	КонецЕсли; 
КонецПроцедуры
