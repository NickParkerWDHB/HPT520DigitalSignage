Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy UnRestricted

Clear-Host

Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows NT\Current Version\Winlogon' -Name 'DefaultUserName' -value 'Administrator'
Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows NT\Current Version\Winlogon' -Name 'ForceAutoLogon' -value '1'
Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows NT\Current Version\Winlogon' -Name 'AutoAdminLogon' -value '1'
New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\Current Version\Winlogon" -Name "DefaultPassword" -Value "Administrator"  -PropertyType "String"
New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\Current Version\Winlogon" -Name "DisableLockWorkstation" -Value "1"  -PropertyType "DWord"

Get-WmiObject -Class Win32_Product | Select-Object -Property Name

$Apps = @('HP Easy Shell','HP Thin Update','HP Write Manager','Broadcom Bluetooth Software','Foxit PhantomPDF','HP System Information','Intel(R) PRO/Wireless Driver')

foreach ($app in $Apps)
	{
		$MyApp = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq $app}
		$MyApp.Uninstall()
	}
