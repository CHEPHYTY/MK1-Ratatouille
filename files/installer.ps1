# builds resource for rat
# created by: CHEPHYTY

#random string for directories

function random_text {
    return -join ((65..90) + (97..122) | Get-Random -Count 5 | % { [char]$_ })
}

## variables
$wd = random_text
$path = "$env:temp/$wd"
$initial_dir = %cd%

# goto temp, make working directory
mkdir $path
cd $path
echo "" > poc.txt
cd $initial_dir
del installer.ps1