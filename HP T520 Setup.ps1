Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy UnRestricted

Clear-Host

Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultUserName' -value 'Administrator'
Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'AutoLogonUser' -value 'Administrator'
Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'ForceAutoLogon' -value '1'
Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'AutoAdminLogon' -value '1'
Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultPassword' -value 'Administrator'
New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "DisableLockWorkstation" -Value "1"  -PropertyType "DWord"

Get-WmiObject -Class Win32_Product | Select-Object -Property Name

$Apps = @('HP Easy Shell','HP Thin Update','HP Write Manager','Broadcom Bluetooth Software','Foxit PhantomPDF','HP System Information','Intel(R) PRO/Wireless Driver')

foreach ($app in $Apps)
	{
		$MyApp = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq $app}
		$MyApp.Uninstall()
	}
