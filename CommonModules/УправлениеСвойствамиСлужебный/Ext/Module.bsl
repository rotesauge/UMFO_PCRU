﻿
&Вместо("ПолучитьОсновнойНаборСвойствДляОбъекта")
Функция pcru_ex_ПолучитьОсновнойНаборСвойствДляОбъекта(ВладелецСвойств)
	Если ОбщегоНазначения.ЗначениеСсылочногоТипа(ВладелецСвойств) Тогда
		Ссылка = ВладелецСвойств;
	Иначе
		Ссылка = ВладелецСвойств.Ссылка;
	КонецЕсли;
	
	МетаданныеОбъекта = Ссылка.Метаданные();
	ИмяОбъектаМетаданных = МетаданныеОбъекта.Имя;
	
	ВидОбъектаМетаданных = ОбщегоНазначения.ВидОбъектаПоСсылке(Ссылка);
	
	Если ВидОбъектаМетаданных = "Справочник" Или ВидОбъектаМетаданных = "ПланВидовХарактеристик" Тогда
		Если ОбщегоНазначения.ОбъектЯвляетсяГруппой(ВладелецСвойств) Тогда
			Возврат Неопределено;
		КонецЕсли;
	КонецЕсли;
	ИмяЭлемента = ВидОбъектаМетаданных + "_" + ИмяОбъектаМетаданных;
	ОсновнойНабор = УправлениеСвойствами.НаборСвойствПоИмени(ИмяЭлемента);
	
	//
	//Попытка   
	//	
	//	//Если ОсновнойНабор = Неопределено Тогда
	//	//	ОсновнойНабор = Справочники.НаборыДополнительныхРеквизитовИСведений.ПолучитьИмяПредопределенного[ИмяЭлемента];
	//	//КонецЕсли;
	//	//Возврат ОсновнойНабор;
	//	
	//Исключение
		Если ОсновнойНабор = Неопределено Тогда
			ОсновнойНабор = Справочники.НаборыДополнительныхРеквизитовИСведений.НайтиПоНаименованию(ИмяЭлемента);
		КонецЕсли;
		Возврат ОсновнойНабор;
		
		
	//КонецПопытки;	
	
	
	
КонецФункции
