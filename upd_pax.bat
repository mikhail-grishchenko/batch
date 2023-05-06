@echo off
@chcp 65001
cls
color 3F
title Обновление ПО компьютера для пин-падов PAX (главное окно).
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo Перед запуском батника нужно скопировать в "C:\Application_Path\" каталог PAX c содержимым:
echo 1.Каталоги USBDriver_V2.00_201709012, Batch.
echo 2.Файлы Application.exe, Application.msi.
echo 4.Файл upd_pax.bat. 
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo Порядок комманд батника:
echo 1) Закрываем Application если он не закрыт.
echo 2) Удаляем службу Service, 
echo останавливаем службы Service2, Service3.
echo 3) Перезапуск службы Windows Management Instrumentation (WMI) - доп.окно.
echo 4) Запускаем установку C:\Application_Path\PAX\Application.msi.
echo 5) Переходим в каталог C:\Program Files (x86)\Application_Path\Application
echo и запускаем Application.exe - доп.окно.
echo 6) Удаляем Lan4POS 2.06.3, CAS CDC Driver, каталог C:\Lan4POS в случае их наличия.
echo 7) Запускаем установку C:\Application_Path\PAX\USBDriver_V2.00_201709012\USBDriver.exe.
echo 8) Запускаем установку C:\Application_Path\PAX\Application.exe.
echo 9) Перезапускаем службу Services на Main_PC (computername-001 или computername-002).
echo 10) Переходим в каталог C:\Program Files (x86)\Application_Path\Application_Path 
echo     и выполняем команды.
echo 11) Отмена регистрации библиотек от Lan4POS если они есть.
echo 12) Прописываем SSL OFF SSL в файле C:\Program Files (x86)\Application_Path\Application_Path
echo     \DualConnector.xml.    
echo 13) Перезапуск Service и Service2.
echo 14) Выполняем регистрацию библиотек для терминала PAX.
echo 15) Перезапуск службы Service.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

pause

echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo 1) Закрываем Application если он не закрыт
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo.
taskkill /F /IM Application.exe
TIMEOUT /T 5


echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo 2) Удаляем службу Service, 
echo    останавливаем службы Service2, Service3.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo.
wmic product where name="Service" call uninstall
TIMEOUT /T 2
net stop "Service2"
TIMEOUT /T 2
net stop "Service3"
TIMEOUT /T 2

echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo Запускаем в дополнительном окне (В СВЕРНУТОМ ВИДЕ):
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo.
TIMEOUT /T 3
start /min C:\"Application_Path\PAX\Batch\WMI.bat" 
TIMEOUT /T 3


echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo 4) Запускаем установку C:\Application_Path\PAX\Application.msi
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo.
taskkill /F /IM msiexec.exe
TIMEOUT /T 3
start C:\"Application_Path\PAX\Application.msi" /quiet
TIMEOUT /T 10

:rekurs3
setlocal enableextensions enabledelayedexpansion
set sFileName=msiexec.exe
for /f "usebackq delims=" %%i in (`tasklist.exe /nh /fi "IMAGENAME eq %sFileName%" ^| 2^>nul find.exe /i "%sFileName%" ^| find.exe /c /v ""`) do if %%i lss 2 goto all2
goto timeout3

:timeout3
timeout 3 /NOBREAK
goto rekurs3

:all2
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo Запускаем в дополнительном окне (В СВЕРНУТОМ ВИДЕ):
echo.
echo Обновление служб Services.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo.
TIMEOUT /T 3
start /min C:\"Application_Path\PAX\Batch\Services.bat"
TIMEOUT /T 3


echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo 6) Удаляем Lan4POS 2.06.3, CAS CDC Driver, каталог C:\Lan4POS.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo.
taskkill /F /IM Lan4POS.exe
TIMEOUT /T 1

IF EXIST "C:\Lan4POS\unins000.exe" (
	echo --------------------------
    echo Программа Lan4POS найдена.
	echo --------------------------
	TIMEOUT /T 2
	start C:\"Lan4POS\unins000.exe"
) ELSE (
	echo -----------------------------
    echo Программа Lan4POS не найдена.
	echo -----------------------------
    TIMEOUT /T 2	
)

:rekurs5
tasklist|find "unins000.exe"&&goto timeout5
goto lan

:timeout5
timeout 3 /NOBREAK
goto rekurs5

:lan
IF EXIST "C:\Lan4POS" (
	echo -----------------------
    echo Каталог Lan4POS найден.
	echo -----------------------
	TIMEOUT /T 2
	RD /S /Q C:\Lan4POS
	echo -----------------------
	echo Каталог Lan4POS удален.
	echo -----------------------
	TIMEOUT /T 2
) ELSE (
	echo --------------------------
    echo Каталог Lan4POS не найден.
	echo --------------------------
    TIMEOUT /T 2	
)

reg query HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{GUID Application} 
if %ERRORLEVEL% EQU 0 goto CASYES
if %ERRORLEVEL% EQU 1 goto CASNO

:CASYES
echo -------------------------------------
echo CAS CDC Driver найден и будет удален.
echo -------------------------------------
TIMEOUT /T 2
msiexec.exe /x {GUID Application}
goto rekurs30 

:CASNO
echo -------------------------
echo CAS CDC Driver не найден.
echo -------------------------
goto usb

:rekurs30
setlocal enableextensions enabledelayedexpansion
set sFileName=msiexec.exe
for /f "usebackq delims=" %%i in (`tasklist.exe /nh /fi "IMAGENAME eq %sFileName%" ^| 2^>nul find.exe /i "%sFileName%" ^| find.exe /c /v ""`) do if %%i lss 2 goto usb
goto timeout30

:timeout30
timeout 3 /NOBREAK
goto rekurs30


:usb
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo 7) Запускаем установку C:\Application_Path\PAX\USBDriver_V2.00_201709012\USBDriver.exe
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo.
start C:\"Application_Path\PAX\USBDriver_V2.00_201709012\USBDriver.exe"
TIMEOUT /T 10

:rekurs
tasklist|find "USBDriver.exe"&&goto timeout
goto pc

:timeout
timeout 3 /NOBREAK
goto rekurs

:pc
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo 8) Запускаем установку C:\Application_Path\PAX\Application.exe
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo.
start C:\"Application_Path\PAX\Application.exe" /S
TIMEOUT /T 20

:rekurs2
tasklist|find "Application.exe"&&goto timeout2
goto all

:timeout2
timeout 3 /NOBREAK
goto rekurs2

:all
TIMEOUT /T 3
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo 9) Перезапускаем службу Service на Main_PC (computername-001 или computername-002).
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo.
set str=%computername%
set str=%str:~0,10%
set "str2=-001"
set "str3=%str%%str2%"
echo %str3%
net use \\%str3%
SC \\%str3% Stop Service
TIMEOUT /T 3
SC \\%str3% Start Service
TIMEOUT /T 2

set "str4=-002"
set "str5=%str%%str4%"
echo %str5%
net use \\%str5%
SC \\%str5% Stop Service
TIMEOUT /T 3
SC \\%str5% Start Service
TIMEOUT /T 2


echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo 10) Переходим в каталог C:\Program Files (x86)\Application_Path\Application_Path 
echo и выполняем команды regasmDC.bat.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo.
cd /d "C:\Program Files (x86)\Application_Path\Application_Path"
regasm.exe DualConnector.dll /codebase /tlb


echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo 11) Отмена регистрации библиотек от Lan4POS если они есть.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo.
taskkill /F /IM Lan4POS.exe
TIMEOUT /T 1

@PUSHD %~dp0
regsvr32 /u /s "c:\Lan4POS\LanCOM.dll"
@POPD

TIMEOUT /T 3 
erase /f /s /q C:\Lan4POS\delayrun.bat
erase /f /s /q C:\Lan4POS\rg.bat
TIMEOUT /T 2

echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo 12) Прописываем SSL OFF SSL в файле 
echo    C:\Program Files (x86)\Application_Path\Application_Path\DualConnector.xml.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo.

powershell -executionpolicy bypass -command "(get-content 'C:\Program Files (x86)\Application_Path\Application_Path\DualConnector.xml') | foreach {$_ -creplace 'SSL>ON</SSL','SSL>OFF</SSL'} | set-content 'C:\Program Files (x86)\Application_Path\Application_Path\DualConnector.xml'"
TIMEOUT /T 1 

powershell -executionpolicy bypass -command "(get-content 'C:\Program Files (x86)\Application_Path\Application_Path\DualConnector.xml') | foreach {$_ -creplace 'SSL>On</SSL','SSL>OFF</SSL'} | set-content 'C:\Program Files (x86)\Application_Path\Application_Path\DualConnector.xml'"
TIMEOUT /T 1 

powershell -executionpolicy bypass -command "(get-content 'C:\Program Files (x86)\Application_Path\Application_Path\DualConnector.xml') | foreach {$_ -creplace 'SSL>on</SSL','SSL>OFF</SSL'} | set-content 'C:\Program Files (x86)\Application_Path\Application_Path\DualConnector.xml'"
TIMEOUT /T 1 

powershell -executionpolicy bypass -command "(get-content 'C:\Program Files (x86)\Application_Path\Application_Path\DualConnector.xml') | foreach {$_ -creplace 'SSL>oN</SSL','SSL>OFF</SSL'} | set-content 'C:\Program Files (x86)\Application_Path\Application_Path\DualConnector.xml'"
TIMEOUT /T 1 

powershell -executionpolicy bypass -command "(get-content 'C:\Program Files (x86)\Application_Path\Application_Path\DualConnector.xml') | foreach {$_ -creplace 'SSL>ОН</SSL','SSL>OFF</SSL'} | set-content 'C:\Program Files (x86)\Application_Path\Application_Path\DualConnector.xml'"
TIMEOUT /T 1

powershell -executionpolicy bypass -command "(get-content 'C:\Program Files (x86)\Application_Path\Application_Path\DualConnector.xml') | foreach {$_ -creplace 'SSL>OF</SSL','SSL>OFF</SSL'} | set-content 'C:\Program Files (x86)\Application_Path\Application_Path\DualConnector.xml'"
TIMEOUT /T 1

powershell -executionpolicy bypass -command "(get-content 'C:\Program Files (x86)\Application_Path\Application_Path\DualConnector.xml') | foreach {$_ -creplace 'SSL>Off</SSL','SSL>OFF</SSL'} | set-content 'C:\Program Files (x86)\Application_Path\Application_Path\DualConnector.xml'"
TIMEOUT /T 1 

powershell -executionpolicy bypass -command "(get-content 'C:\Program Files (x86)\Application_Path\Application_Path\DualConnector.xml') | foreach {$_ -creplace 'SSL>off</SSL','SSL>OFF</SSL'} | set-content 'C:\Program Files (x86)\Application_Path\Application_Path\DualConnector.xml'"
TIMEOUT /T 2 


echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo 13) Перезапуск служб Service и Service2.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo.

taskkill /F /IM Application.exe
TIMEOUT /T 3 
net start "Service"

net stop "Service2"
TIMEOUT /T 3 
net start "Service2"
TIMEOUT /T 1 

echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo 14) Выполняем регистрацию библиотек для терминала PAX 
echo    Процесс может занять некоторое время...
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo.
@PUSHD %~dp0
regsvr32 /s "C:\Program Files (x86)\Application_Path\Application_Path\Application_Path.dll"
@POPD
TIMEOUT /T 2


echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo 15) Перезапуск службы Service.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo.
taskkill /F /IM Application.exe
TIMEOUT /T 3 
net start "Service"
TIMEOUT /T 3


echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo Работа основного батника завершена.
echo.
echo ПРОВЕРЬТЕ ЗАВЕРШЕНИЕ ОПЕРАЦИЙ В СОСЕДНИХ ОКНАХ CMD, 
echo после нажатия любой клавиши будет выполнена перезагрузка ПК.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo.
echo.
pause
shutdown.exe -r -f -t 3

::MGr

