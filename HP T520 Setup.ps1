Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy UnRestricted

Clear-Host

Write-Output("Configuring AutoLogon")
Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultUserName' -value 'Administrator'
Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'AutoLogonUser' -value 'Administrator'
Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'ForceAutoLogon' -value '1'
Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'AutoAdminLogon' -value '1'
Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultPassword' -value 'Administrator'
New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "DisableLockWorkstation" -Value "1"  -PropertyType "DWord"

Write-Output("Enabling Windows Administrator logins in TeamViewer")
Set-Itemproperty -path 'HKLM:\Software\TeamViewer' -Name 'Security_WinLogin' -value '1'

Write-Output("Removing Desktop Icons")
Remove-Item "C:\Users\Public\Desktop\*.*"

Write-Output("Removing TaskBar Icons")
Remove-Item "C:\Users\Default\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*.*"
Remove-Item "C:\Users\Administrator\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\*.*"
Remove-Item "C:\Users\Administrator\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*.*"
Remove-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Taskband -Force

Write-Output("Disable Chrome Hardware Acceleration setting")
New-Item -Path HKLM:\Software\Policies -Name Google -Force
New-Item -Path HKLM:\Software\Policies\Google -Name Chrome -Force
New-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "HardwareAccelerationModeEnabled" -Value "0"  -PropertyType "DWord"

Write-Output("Unblock the Launch Screen.PS1 file")
#This only works in Powershell 3+
#Unblock-File -Path "C:\Scripts\Launch Screen.ps1"
start-process "C:\Scripts\Unblock_File.bat"

Write-Output("Setting Power Plan to Balanced")
$PowerPlan = Get-WmiObject -Namespace root\cimv2\power -Class Win32_PowerPlan -Filter "ElementName = 'Balanced'"
$PowerPlan.Activate()

Write-Output("Configuring power button & sleep button action to shutdown")
powercfg -setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 3
powercfg -setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 96996bc0-ad50-47ec-923b-6f41874dd9eb 0

Write-Output("Deactivating password on wake/screensaver")
powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 0

#This only works in Powershell 4+
#Write-Output("Creating Scheduled Task for daily restart")
#$taskAction = New-ScheduledTaskAction -Execute 'shutdown.exe' -Argument '-r -t 00'
#$taskTrigger = New-ScheduledTaskTrigger -Daily -At 2AM
#$taskName = "Daily Restart"
#$description = "Restarts the computer at 2AM every day."
#Register-ScheduledTask -TaskName $taskName -Action $taskAction -Trigger $taskTrigger -Description $description

Write-Output("Importing Daily Restart Scheduled Task")
Start-Process "C:\Scripts\Import Scheduled Task.bat"

Write-Output("Copying Start-Up Shortcut")
Copy-Item -Path "C:\Scripts\Launch Screen Shortcut.lnk" -Destination "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\"

$Apps = @('HP Easy Shell', 'HP System Information', 'Foxit PhantomPDF', 'HP ThinUpdate')

foreach ($app in $Apps)
	{
		Write-Output("Uninstalling: " + $app)
		$MyApp = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq $app}
		$MyApp.Uninstall()
	}

#Uninstall CyberLink Media+ Player 10
#Uninstall CitrixReceiver 4.7
#Uninstall VMware Horizon Client - REBOOT
#Uninstall HPDM Agent 32-bit
#Uninstall HP Write Manager
#Uninstall HP Velocity
#Uninstall HP Documentation
#Uninstall Broadcom 802.11 Wireless LAN Adapter - REBOOT
#Uninstall Broadcom Wireless Utility
#Uninstall Broadcom Bluetooth Software
#Uninstall HP USB Port Manager
#Uninstall PL-2303 USB-to-Serial
#Uninstall Intel PROSet/Wireless Software - NB - this will clear any saved wireless profiles
#Uninstall Intel Wireless Bluetooth - REBOOT
