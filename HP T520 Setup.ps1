Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy UnRestricted

Clear-Host

New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\Current Version\Winlogony" -Name "NetwrixParam" -Value ”NetwrixValue”  -PropertyType "String"

Get-WmiObject -Class Win32_Product | Select-Object -Property Name

$Apps = @('HP Easy Shell','HP Thin Update','HP Write Manager','Broadcom Bluetooth Software','Foxit PhantomPDF','HP System Information','Intel(R) PRO/Wireless Driver')

foreach ($app in $Apps)
	{
		$MyApp = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq $app}
		$MyApp.Uninstall()
	}
