@echo off
taskkill /FI "IMAGENAME eq adb.exe" /T /F  1>nul 2>nul

set TIME_DIR=%DATE:~0,10%%TIME:~0,8%
set TIME_DIR=%TIME_DIR::=%
set TIME_DIR=%TIME_DIR: =%
set TIME_DIR=%TIME_DIR:/=%

set BASE_DIR=%~d0\LogAndroid2PC\%TIME_DIR%

md "%BASE_DIR%"

xcopy /Y /S /E "%~dp0*" "%BASE_DIR%\" 

cd "%BASE_DIR%"
start "" "%BASE_DIR%\LogAndroid2PC.bat"

exit
