﻿//Обмен С  Нав
&Вместо("ЗапуститьОбработкуОтветовЕГАИС")
Процедура pcru_ex_ЗапуститьОбработкуОтветовЕГАИС()
	 pcru_ex_РегламентныеОперации.ВыполнитьРегламентныеОперации();
	//Дата1 = НачалоМесяца(НачалоМесяца(ТекущаяДата())-1);
	//Дата2 = НачалоМесяца(ТекущаяДата())-1;
	//Кол_Дней =ДеньГода(Дата2) - ДеньГода(Дата1);
	//// Установим начало отсчета на день раньше
	//ТекДень = НачалоДня(Дата1)-1; 
	//// Формируем массив дат
	//Для I = 0 По Кол_Дней Цикл
	//	ТекДень =  КонецДня(Дата(КонецДня(ТекДень)+1));
	//	pcru_ex_NAV.Обмен(ТекДень,Ложь); 
	//КонецЦикла;	

КонецПроцедуры


Процедура _йц()

	

КонецПроцедуры

&Вместо("СверткаРегистраСоответствиеНоменклатурыЕГАИС")
Процедура pcru_ex_СверткаРегистраСоответствиеНоменклатурыЕГАИС()
	
	pcru_ex_РегламентныеОперации.ВыполнитьРегламентныеОперацииПрофикредит();
	
КонецПроцедуры
