:: Отключение отображения вывода скрипта в консоли
@echo off

:: Отправить в файл директиву С компилятору о включении заголовочного файла
:: только один раз
echo #pragma once > %1

:: Запись полученного дефайна во временный файл 
call :git_info_define > temp.txt
:: Чтение из файла в переменную (без временного файла у меня не получилось,
:: да костыль, но что поделать, это cmd)
set /p mytext=<temp.txt
:: Удаление временного файла
erase temp.txt 

:: Замена всех символов backslash (\) на двойной backslash (\\) 
:: Нужна для строк в С, чтобы не было внезапных escape символов
set mytext=%mytext:\=\\%
:: Запись в файл
echo %mytext% >> %1

:: Подпрограмма создания дефайна 
:git_info_define
:: Извращение, чтобы echo было без переноса строки
echo | set /p dummyName= #define GIT_INFO "
:: Вытягиваем из гит информацию о последнем коммите
git log --pretty=format:"%%h - %%an <%%ae>, %%ad %%s" -1 --date=format:"%%Y-%%m-%%d %%H:%%M:%%S"
echo "

