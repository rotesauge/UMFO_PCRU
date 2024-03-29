﻿
Функция СведенияОВнешнейОбработке() Экспорт
 
	ПараметрыРегистрации = Новый Структура;
	МассивНазначений = Новый Массив;

	//	МассивНазначений.Добавить("подсистема.CRMИМАРКЕТИНГ"); //Указываем документ к которому делаем внешнюю печ. форму
	ПараметрыРегистрации.Вставить("Вид", "ДополнительныйОтчет"); //может быть - ПечатнаяФорма, ЗаполнениеОбъекта, ДополнительныйОтчет, СозданиеСвязанныхОбъектов... 
	ПараметрыРегистрации.Вставить("Наименование", "(ПрофиКредит) Отчет по статьям затрат (внешний)"); //имя под которым обработка будет зарегестрирована в справочнике внешних обработок
	ПараметрыРегистрации.Вставить("БезопасныйРежим",ИСТИНА);
	ПараметрыРегистрации.Вставить("Информация", "Внешний отчет по статьям затрат");
	ПараметрыРегистрации.Вставить("Версия", "1.0");    

	ТаблицаКоманд = ПолучитьТаблицуКоманд();
	ДобавитьКоманду(ТаблицаКоманд, "(ПрофиКредит) Отчет по статьям затрат", "ОтчетПоСтатьямЗатрат", "ОткрытиеФормы");
	ПараметрыРегистрации.Вставить("Команды", ТаблицаКоманд);

	Возврат ПараметрыРегистрации;
 
КонецФункции
 
Функция ПолучитьТаблицуКоманд()
	
	Команды = Новый ТаблицаЗначений;
	Команды.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));//как будет выглядеть описание печ.формы для пользователя
	Команды.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Строка")); //имя макета печ.формы
	Команды.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка")); //ВызовСерверногоМетода
	Команды.Колонки.Добавить("ПоказыватьОповещение", Новый ОписаниеТипов("Булево"));
	Команды.Колонки.Добавить("Модификатор", Новый ОписаниеТипов("Строка"));

	Возврат Команды;
КонецФункции
 
Процедура ДобавитьКоманду(ТаблицаКоманд, Представление, Идентификатор, Использование, ПоказыватьОповещение = Ложь, Модификатор = "")
 
	НоваяКоманда = ТаблицаКоманд.Добавить();
	НоваяКоманда.Представление = Представление;  
	НоваяКоманда.Идентификатор = Идентификатор;
	НоваяКоманда.Использование = Использование;
	НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение;
	НоваяКоманда.Модификатор = Модификатор;
 
КонецПроцедуры

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	ПараметрДанных= КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("ВидОперации");
    ПараметрДанных.Значение = Перечисления.ВидыОперацийСписаниеДенежныхСредств.ПереводНаДругойСчет;
	ПараметрДанных.Использование=Истина;
	
	
	ПараметрДанных= КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("СчетБанк");
    ПараметрДанных.Значение = ЭтотОбъект.Счет;//Справочники.БНФОСчетаАналитическогоУчета.НайтиПоКоду("2050181000000000000400000");
    ПараметрДанных.Использование=Истина;
	
	       
	ПараметрДанных= КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("Дата1");
    ПараметрДанных.Значение = НачалоДня(ЭтотОбъект.Дата1);
	ПараметрДанных.Использование=Истина;
	
	
	ПараметрДанных= КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("Дата2");
    ПараметрДанных.Значение  = КонецДня(ЭтотОбъект.Дата2);
    ПараметрДанных.Использование=Истина;
	
	ПараметрДанных= КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("СтатьяРасходов");
    ПараметрДанных.Значение = ЭтотОбъект.СтатьяРасходов;
	ПараметрДанных.Использование=Истина;
	
	
	ПараметрДанных= КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("ТипЗатрат");
    ПараметрДанных.Значение  = ЭтотОбъект.ТипЗатрат;
    ПараметрДанных.Использование=Истина;
	

	
КонецПроцедуры
