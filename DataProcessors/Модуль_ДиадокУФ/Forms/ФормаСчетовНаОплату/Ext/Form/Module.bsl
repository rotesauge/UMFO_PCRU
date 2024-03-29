﻿&НаКлиенте
Перем ЭДОбъект Экспорт;
&НаКлиенте
Перем Организация Экспорт;

#Область ПЕРМЕННЫЕ_ПЛАТФОРМЫ

&НаКлиенте
Перем Платформа Экспорт;

&НаСервере
Перем ОбработкаОбъект;

&НаКлиенте
Перем СчетаНаОплатуСервиса;

#КонецОбласти

#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ПЛАТФОРМЫ

&НаКлиенте
Функция МетодКлиента(ИмяМодуля= "", ИмяМетода, 
		Параметр0 = NULL, Параметр1 = NULL, Параметр2 = NULL, Параметр3 = NULL, Параметр4 = NULL,
		Параметр5 = NULL, Параметр6 = NULL, Параметр7 = NULL, Параметр8 = NULL, Параметр9 = NULL) Экспорт
	
	Возврат  Платформа.МетодКлиента(ИмяМодуля, ИмяМетода, 
	Параметр0, Параметр1, Параметр2, Параметр3, Параметр4,
	Параметр5, Параметр6, Параметр7, Параметр8, Параметр9);
	
КонецФункции

&НаКлиенте
Функция МетодСервераБезКонтекста(ИмяМодуля = "", ИмяМетода,
		Параметр0 = NULL, Параметр1 = NULL, Параметр2 = NULL, Параметр3 = NULL, Параметр4 = NULL, 
		Параметр5 = NULL, Параметр6 = NULL, Параметр7 = NULL, Параметр8 = NULL, Параметр9 = NULL) Экспорт
	
	Возврат Платформа.МетодСервераБезКонтекста(ИмяМодуля, ИмяМетода,
	Параметр0, Параметр1, Параметр2, Параметр3, Параметр4,
	Параметр5, Параметр6, Параметр7, Параметр8, Параметр9);
	
КонецФункции

&НаСервере
Функция МетодСервера(Знач ИмяМодуля = "", Знач ИмяМетода,
		Параметр0 = NULL, Параметр1 = NULL, Параметр2 = NULL, Параметр3 = NULL, Параметр4 = NULL, 
		Параметр5 = NULL, Параметр6 = NULL, Параметр7 = NULL, Параметр8 = NULL, Параметр9 = NULL) Экспорт
	
	Возврат ОбработкаОбъект().МетодСервера(ИмяМодуля, ИмяМетода, 
	Параметр0, Параметр1, Параметр2, Параметр3, Параметр4,
	Параметр5, Параметр6, Параметр7, Параметр8, Параметр9);
	
КонецФункции

&НаСервере
Функция ОбработкаОбъект() Экспорт
	
	Если ОбработкаОбъект = Неопределено Тогда
		
		СтруктураОбработки= ПолучитьИзВременногоХранилища(Объект.ПараметрыКлиентСервер.ВременноеХранилище.АдресОбработкаОбъект);
		
		Если СтруктураОбработки <> Неопределено Тогда
			ОбработкаОбъект = СтруктураОбработки.ОбработкаОбъект;
		КонецЕсли;
		
		Если ОбработкаОбъект = Неопределено Тогда
			ОбработкаОбъект = РеквизитФормыВЗначение("Объект");  
			АдресХранилища = Объект.ПараметрыКлиентСервер.ВременноеХранилище.АдресОбработкаОбъект;   

			ПоместитьВоВременноеХранилище(Новый Структура("ОбработкаОбъект", ОбработкаОбъект), АдресХранилища);
			
		Иначе
			ОбработкаОбъект.ПараметрыКлиентСервер = Объект.ПараметрыКлиентСервер;
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат ОбработкаОбъект;
	
КонецФункции

&НаКлиенте
Функция ОсновнаяФорма(ТекущийВладелецФормы)
	
	Если ТекущийВладелецФормы = Неопределено Тогда
		Возврат Неопределено
	ИначеЕсли Прав(ТекущийВладелецФормы.ИмяФормы, 14) = "Форма_Основная" Тогда
		Возврат ТекущийВладелецФормы;
	Иначе
		Возврат ОсновнаяФорма(ТекущийВладелецФормы.ВладелецФормы);
	КонецЕсли;
	
КонецФункции


&НаСервере
Процедура ПлатформаПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Свойство("ОбъектПараметрыКлиентСервер", Объект.ПараметрыКлиентСервер);
	
КонецПроцедуры

&НаКлиенте
Процедура ПлатформаПриОткрытии(Отказ)
	
	ОсновнаяФорма = ОсновнаяФорма(ВладелецФормы);
	
	Если ОсновнаяФорма <> Неопределено Тогда
		Платформа = ОсновнаяФорма.Платформа;
	КонецЕсли;
		
	Платформа.ПриОткрытииФормыОбработки(ЭтаФорма, Отказ);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ПлатформаПриСозданииНаСервере(Отказ, СтандартнаяОбработка);

	Картинки = МетодСервера(, "ЭДО_БиблиотекаКартинок");

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ПлатформаПриОткрытии(Отказ);
	
	ЗаполнитьОнлайнСчетаПоОрганизациям();
	
	HTMLСписокОнлайнСчетов();

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура HTMLДокументПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	
	СтандартнаяОбработка 	= Ложь;
	АдресСсылки 			= Неопределено;
	
	Если НЕ ДанныеСобытия.Свойство("href", АдресСсылки) Тогда  
		Возврат;
	КонецЕсли;
	
	Если Найти(АдресСсылки, "ОбработчикОткрытьОнлайнЧат") > 0 Тогда
		
		МетодКлиента("Модуль_Клиент", "ОткрытьОнлайнЧат");
		
	ИначеЕсли Найти(АдресСсылки, "ОбработчикОтправитьEmail") > 0 Тогда
		
		МетодКлиента("Модуль_Клиент", "НаписатьПисьмоВТехПоддержку");
		
	ИначеЕсли Найти(АдресСсылки, ПрефиксОповещенияСохранитьФайОнлайнСчетаНаДиск()) > 0 Тогда
		
		ПараметрыСкачивания = РазложитьПараметрыСсылкиНаСкачивание(АдресСсылки);
		
		СохранитьФайлОнлайнСчетаНаДиск(	ПараметрыСкачивания.СсылкаНаФайл, 
										ПараметрыСкачивания.НомерСчета, 
										ПараметрыСкачивания.АвторизационныйТокен); 
		
	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОткрытьФормуВыводаОшибки(Результат, ЗакрытьФорму = Ложь, ИмяОбработчика = Неопределено, ПараметрыОбработчика = Неопределено) Экспорт
	
	ПараметрыФормы = Новый Структура;
	
	Если Результат.Свойство("Заголовок") Тогда
		ПараметрыФормы.Вставить("Заголовок", Результат.Заголовок);
	Иначе
		ПараметрыФормы.Вставить("Заголовок", "Ошибка работы с модулем " + Платформа.ПараметрыКлиент.СловарьWL.НаименованиеСистемы);
	КонецЕсли;
	
	ПараметрыФормы.Вставить("ОписаниеОшибки", Результат.ОписаниеОшибки);
	ПараметрыФормы.Вставить("Подробности"	, Результат.Подробности);
	
	Если ИмяОбработчика = Неопределено Тогда
		ИмяОбработчика = "ОбработчикОткрытияФормыОшибки";
		ПараметрыОбработчика = ЗакрытьФорму;
	КонецЕсли;
	
	МетодКлиента(, "ОткрытьФормуОбработкиМодально", "Форма_ВыводОшибки", ПараметрыФормы, ЭтаФорма, ИмяОбработчика, ПараметрыОбработчика);
	
КонецПроцедуры     

&НаКлиенте
Процедура ОбработчикОткрытияФормыОшибки(РезультатВыбора, ЗакрытьФорму) Экспорт
	
	Если ЗакрытьФорму = Истина Тогда
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область РаботаСоСчетами

&НаКлиенте
Функция ПредставлениеСуммы(Сумма)
	Валюта = " руб.";
	Результат = Формат(Сумма, "ЧДЦ=2") + Валюта; 
	Возврат Результат;
КонецФункции

&НаКлиенте
Функция ПредставлениеСчета(Номер)
	Префикс = "Счет № ";
	Результат = Префикс + Номер; 
	Возврат Результат;
КонецФункции

&НаКлиенте
Функция ПредставлениеОплаченногоПериода(ДатаОкончания)
	Результат = "";	
	Если ЗначениеЗаполнено(ДатаОкончания) Тогда
		Префикс = "Оплаченный период заканчивается ";
		Результат = Префикс + Формат(ДатаОкончания, "ДФ='д ММММ'"); 
	КонецЕсли;
	Возврат Результат;
КонецФункции  

&НаКлиенте
Функция ПредставлениеОповещенияОСкачивании(АдресФайла, НомерСчета, BoxID)
	Префикс = ПрефиксОповещенияСохранитьФайОнлайнСчетаНаДиск();
	Результат = Префикс + АдресФайла + "&" + НомерСчета + "&" + BoxID; 
	Возврат Результат;
КонецФункции

&НаКлиенте
Функция ПрефиксОповещенияСохранитьФайОнлайнСчетаНаДиск() 
	Возврат "Оповещение:СохранитьФайлОнлайнСчетаНаДиск?";
КонецФункции

&НаКлиенте
Функция ПредставлениеОповещенияОткрытьОнлайнЧат()
	Результат = "Оповещение:ОбработчикОткрытьОнлайнЧат"; 
	Возврат Результат;
КонецФункции

&НаКлиенте
Функция ПредставлениеОповещенияОтправитьEmail()
	Результат = "Оповещение:ОбработчикОтправитьEmail"; 
	Возврат Результат;
КонецФункции

&НаКлиенте
Процедура HTMLСписокОнлайнСчетов()
	
	HTMLДокумент = ИнициализироватьHTMLДокумент();
	
	Для каждого Организация Из СчетаНаОплатуСервиса Цикл
		
		ДополнитьHTMLДокументСчетамиОрганизации(HTMLДокумент, Организация);
		
	КонецЦикла;
	
	HTMLДокумент = HTMLДокумент + ПодвалДокумента(); 
	
КонецПроцедуры

&НаКлиенте
Функция ИнициализироватьHTMLДокумент()
	Результат = 
	
	"<html><head> " 
	+ ТаблицаСтилей() + "
	|</head>
	|<body>
	|	<p class=head>Мы подготовили документы. Скачайте и оплатите счет</p>"
	+ ШапкаТаблицы();
	
	Возврат Результат;
КонецФункции

&НаКлиенте
Процедура ДополнитьHTMLДокументСчетамиОрганизации(HTMLДокумент, Организация) 
	
	Для Каждого ИнформацияПоСчету Из Организация.МассивСчетов Цикл
		
		HTMLДокумент = HTMLДокумент + СтрокаСчетаHTML(	Организация, 
														ИнформацияПоСчету.Номер, 
														ИнформацияПоСчету.Сумма, 
														ИнформацияПоСчету.СсылкаНаФайл);
		
		ДобавитьТарифныеПланыHTML(	HTMLДокумент, 
									ИнформацияПоСчету.ТарифныеПланы);
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Функция ШапкаТаблицы()
	
	Результат = "
	|	<table>
	|	<tr class=head>
	|		<td class=head width=270>Организация</TD>
	|		<td class=head width=370 style=""padding-left: 20px"">Счет и тарифный план</TD>
	|		<td class=head width=120 style=""text-align: center"">Сумма</TD>
	|		<td class=head></TD>
	|	</tr>"; 
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция ПодвалДокумента()
	
	Результат = "
	|</table>
	|<div class=footer>
	|	<nobr><a class=support href=" + ПредставлениеОповещенияОтправитьEmail() + "><img class=support src=""data:image/png;base64," + КартинкаEmailBase64() + """>Написать письмо в техподдержку</a><nobr>
	|	<nobr><a class=support href=" + ПредставлениеОповещенияОткрытьОнлайнЧат() + "><img class=support src=""data:image/png;base64," + КартинкаОнлайнКонсультантBase64() + """>Задать вопрос онлайн-консультанту</a><nobr>
	|</div>
	|</body></html>";
	
	Возврат Результат;  
	
КонецФункции

&НаКлиенте
Процедура ДобавитьТарифныеПланыHTML(HTMLДокумент, 
									ТарифныеПланы)
	Для Каждого ТарифныйПлан Из ТарифныеПланы Цикл 
		HTMLДокумент = HTMLДокумент + СтрокаТарифногоПланаHTML(ТарифныйПлан.Name);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Функция СтрокаСчетаHTML(Организация, 
						НомерСчета, 
						Сумма, 
						СсылкаНаФайл)
	Результат = " 
	|<tr class=invoice>
	|	<td class=invoice>"				+ СокрЛП(Организация.Наименование) +	"</TD>
	|	<td class=invoicenumber >"		+ ПредставлениеСчета(НомерСчета) + 	"</TD>
	|	<td class=invoiceprice >"		+ ПредставлениеСуммы(Сумма) +		"</TD>
	|	<td class=invoice><a href="""	+ ПредставлениеОповещенияОСкачивании(СсылкаНаФайл, НомерСчета, Организация.BoxID) + """><img class=invoice alt=""Скачать"" src=""data:image/png;base64," + КартинкаСкачатьBase64() + """>Скачать</a></TD>
	|</tr>";
	
	Возврат Результат; 
	
КонецФункции

&НаКлиенте
Функция СтрокаТарифногоПланаHTML(ТарифныйПлан)
	Результат = "
	|<tr class=plan> 
	|	<td class=invoice></TD>
	|	<TD class=invoicenumber> ● " + ТарифныйПлан + " </TD>
	|</tr>";
	Возврат Результат;
КонецФункции

&НаКлиенте
Функция КартинкаСкачатьBase64()
	ДвоичныеДанныеКартинки = Картинки.КартинкаСкачать.ПолучитьДвоичныеДанные();
	Base64СтрокаКартинки = Base64Строка(ДвоичныеДанныеКартинки);
	Возврат Base64СтрокаКартинки;
КонецФункции

&НаКлиенте
Функция КартинкаОнлайнКонсультантBase64()
	ДвоичныеДанныеКартинки = Картинки.КартинкаОнлайнКонсультант.ПолучитьДвоичныеДанные();
	Base64СтрокаКартинки = Base64Строка(ДвоичныеДанныеКартинки);
	Возврат Base64СтрокаКартинки;
КонецФункции

&НаКлиенте
Функция КартинкаEmailBase64()
	ДвоичныеДанныеКартинки = Картинки.КартинкаEmail.ПолучитьДвоичныеДанные();
	Base64СтрокаКартинки = Base64Строка(ДвоичныеДанныеКартинки);
	Возврат Base64СтрокаКартинки;
КонецФункции

&НаКлиенте
Функция ТаблицаСтилей() 
	
	Стили = "
	|	<style type=text/css>
	|		body {font-family: Segoe UI}
	|		table {width: 100%; overflow: visible; border-collapse: collapse}
	|		p.head {font-SIZE: 14pt; color: #808080}
	|		tr.head {font-SIZE: 11pt; color: #808080}
	|		td.head {padding-bottom: 5px; border-bottom: #959595 1px solid}
	|		tr.invoice {font-SIZE: 11pt; vertical-align: top; color: #000000}
	|		td.invoice {padding-top: 10px}
	|		td.invoicenumber {padding-top: 10px; padding-left: 20px}
	|		td.invoiceprice {padding-top: 10px; text-align: center}
	|		img.invoice {border: 0; vertical-align: bottom}
	|		tr.plan {font-SIZE: 11pt; vertical-align: top; color: #808080}
	|		div.footer {position: absolute; bottom: 0; width: 100%; margin-bottom: 10px; font-SIZE: 11pt; text-align: center}
	|		img.support {border: 0; margin-right: 3px; vertical-align: bottom}
	|		a.support {margin-right: 10px}
	|	</style>";
	
	Возврат Стили;
	
КонецФункции

&НаКлиенте
Функция РазложитьПараметрыСсылкиНаСкачивание(АдресСсылки)
	
	Результат = ПараметрыСсылки_НовыйКонтракт(); 
	
	АдресСсылки = СтрЗаменить(АдресСсылки, ПрефиксОповещенияСохранитьФайОнлайнСчетаНаДиск(), "");
	
	МассивПараметров = МетодКлиента("Модуль_Клиент", "Преобразование_СтрокуВМассивСлов", АдресСсылки, "&");
	
	АктуальноеКоличествоПараметров = 3;
	
	Если НЕ МассивПараметров = Неопределено
		И МассивПараметров.Количество() = АктуальноеКоличествоПараметров Тогда 
		
		Результат.СсылкаНаФайл 	= МассивПараметров[0];
		Результат.НомерСчета 	= МассивПараметров[1];
		BoxID 					= МассивПараметров[2];
		
		Если ЗначениеЗаполнено(BoxID) Тогда 
			Результат.АвторизационныйТокен = Платформа.ПараметрыКлиент.КонтекстРаботаССерверомДиадок.DiadocConnection.Token;
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Результат;
КонецФункции  

&НаКлиенте
Функция ПараметрыСсылки_НовыйКонтракт() 
	
	Результат = Новый Структура;
	
	Результат.Вставить("СсылкаНаФайл", "");
	Результат.Вставить("НомерСчета", "");
	Результат.Вставить("АвторизационныйТокен", "");
	
	Возврат Результат;  
	
КонецФункции

&НаКлиенте
Процедура СохранитьФайлОнлайнСчетаНаДиск(СсылкаНаФайл, НомерСчета, АвторизационныйТокен) Экспорт 
	
	Попытка	 
		
		ФайлСчета = МетодКлиента("Модуль_Клиент", "Kontur_API_GetPortalBillsContent", СсылкаНаФайл,АвторизационныйТокен);
		
		ИмяВременногоФайла = ПолучитьИмяВременногоФайла("pdf");
		
		ФайлСчета.Записать(ИмяВременногоФайла);
		
		ИмяФайла 			= "Счет № " + НомерСчета + ".pdf";
		ЗаголовокДиалога 	= НСтр("ru = 'Сохранение счета'");
		ФильтрДиалога		= НСтр("ru = 'Документ PDF (*.pdf)|*.pdf'");
		
		МетодКлиента("Модуль_Клиент", "СохранитьФайл", ИмяФайла, ИмяВременногоФайла, ЗаголовокДиалога, ФильтрДиалога);
		
		УдалитьФайлы(ИмяВременногоФайла); 
		
	Исключение
		
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("ОписаниеОшибки", НСтр("ru = 'Документ не был сохранен. Проверьте каталог, куда сохраняете документ и соединение с интернетом'"));
		ПараметрыФормы.Вставить("Подробности"	, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		
		ОткрытьФормуВыводаОшибки(ПараметрыФормы);
		
	КонецПопытки;
	
КонецПроцедуры 

&НаКлиенте
Процедура ЗаполнитьОнлайнСчетаПоОрганизациям()
	
	СчетаНаОплатуСервиса = Новый Массив;
	
	КонтекстДиадока = Платформа.ПараметрыКлиент.КонтекстДиадока;
	
	Для каждого ЭлементКонтекста Из КонтекстДиадока Цикл

		Если ЭлементКонтекста.ЗаблокированаПоAPI Тогда 
			Продолжить;
		КонецЕсли;
		
		Token 								= ЭлементКонтекста.Connection.Token;
		AccountID 							= МетодКлиента("Модуль_Клиент", "ИдентификаторЛицевогоСчетаДиадок", ЭлементКонтекста.BoxId, Token);
		
		СтруктураОрганизации 				= Новый Структура("Наименование, BoxId, МассивСчетов");
		СтруктураОрганизации.Наименование 	= ЭлементКонтекста.ДанныеОрганизации.Name;
		СтруктураОрганизации.BoxId 			= ЭлементКонтекста.BoxId; 
		СтруктураОрганизации.МассивСчетов	= СчетаНаОплатуСервиса(AccountID, Token);
		
		Если ЗначениеЗаполнено(СтруктураОрганизации.МассивСчетов) Тогда
			СчетаНаОплатуСервиса.Добавить(СтруктураОрганизации);
		КонецЕсли; 
		
	КонецЦикла;
	
КонецПроцедуры  

&НаКлиенте
Функция СчетаНаОплатуСервиса(AccountId, АвторизационныйТокен)
	Результат = Новый Массив;
	
	ОтветСервиса = МетодКлиента("Модуль_Клиент", "Kontur_API_GetPortalBills", AccountId, АвторизационныйТокен);
	
	РазобранныйОтвет = ЗначениеИзСтрокиJSON(ОтветСервиса);
	
	Если РазобранныйОтвет = Неопределено Тогда 
		РазобранныйОтвет = Результат;
	КонецЕсли;
	
	Для каждого Предложение Из РазобранныйОтвет Цикл
		
		МассивСчетов = МетодКлиента("Модуль_Клиент", "СвойствоСтруктуры", Предложение, "bills");
		
		Для Каждого Счет Из МассивСчетов Цикл
			СтруктураСчета = Счета_НовыйКонтракт();
			
			СтруктураСчета.Номер				= Счет.billNumber;
			СтруктураСчета.Сумма				= Счет.amount;
			СтруктураСчета.ТарифныеПланы		= Счет.tariffsDetails;	
			СтруктураСчета.СсылкаНаФайл			= Предложение.offerId + "/bills/" + Счет.billId + "/pdf";
			СтруктураСчета.ИДЛицевогоСчета		= AccountId;
			СтруктураСчета.ИДТарифа				= Счет.billId;
			
			Результат.Добавить(СтруктураСчета); 
		КонецЦикла;
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

&НаКлиенте
Функция ЗначениеИзСтрокиJSON(СтрокаJSON)
	
	Чтение = Новый ЧтениеJSON;
	Чтение.УстановитьСтроку(СтрокаJSON);
	
	Результат = ПрочитатьJSON(Чтение);
	
	Чтение.Закрыть();
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция Счета_НовыйКонтракт()
	
	Результат = Новый Структура;
	
	Результат.Вставить("BoxId", "");
	Результат.Вставить("Номер", "");
	Результат.Вставить("Сумма", "");
	Результат.Вставить("КодОшибки", "");
	Результат.Вставить("ТекстОшибки", "");
	Результат.Вставить("Организация", "");
	Результат.Вставить("ТарифныеПланы", "");
	Результат.Вставить("СсылкаНаФайл", "");
	Результат.Вставить("ДатаОкончанияПодписки", "");
	Результат.Вставить("ИДЛицевогоСчета", "");
	Результат.Вставить("ИДТарифа", "");
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти
