Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy UnRestricted

Clear-Host

Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultUserName' -value 'Administrator'
Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'AutoLogonUser' -value 'Administrator'
Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'ForceAutoLogon' -value '1'
Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'AutoAdminLogon' -value '1'
Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultPassword' -value 'Administrator'
New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "DisableLockWorkstation" -Value "1"  -PropertyType "DWord"

$PowerPlan = Get-WmiObject -Namespace root\cimv2\power -Class Win32_PowerPlan -Filter "ElementName = 'Balanced'"
$PowerPlan.Activate()

powercfg -setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 3
powercfg -setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 96996bc0-ad50-47ec-923b-6f41874dd9eb 0
powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 0

$Apps = @('HP Easy Shell', 'HP System Information', 'Foxit PhantomPDF', 'HP ThinUpdate', 'VMware Horizon Client')

foreach ($app in $Apps)
	{
		Write-Output("Uninstalling: " + $app)
		$MyApp = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq $app}
		$MyApp.Uninstall()
	}
