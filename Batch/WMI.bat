@echo off
@chcp 65001
cls
color 3F
title WMI.Неправильное пространство имен и Недопустимый класс (дополнительное окно).

echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo Перезапуск службы Windows Management Instrumentation (WMI).
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo.
taskkill /F /IM Application.exe
TIMEOUT /T 3 


sc config winmgmt start= disabled
net stop winmgmt /y
%systemdrive%
cd %windir%\system32\wbem
for /f %%s in ('dir /b *.dll') do regsvr32 /s %%s
wmiprvse /regserver
winmgmt /regserver
sc config winmgmt start= auto
net start winmgmt
for /f %%s in ('dir /s /b *.mof *.mfl') do mofcomp %%s

echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo Работа батника "Перезапуск службы Windows Management Instrumentation (WMI)" 
echo завершена.
echo.
echo ПРОВЕРЬТЕ ЗАВЕРШЕНИЕ ОПЕРАЦИЙ В СОСЕДНИХ ОКНАХ CMD, 
echo после нажатия любой клавиши будет выполнена перезагрузка ПК.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo.
pause
shutdown.exe -r -f -t 3

::MGr

