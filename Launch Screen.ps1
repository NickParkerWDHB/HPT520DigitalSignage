Add-Type -AssemblyName System.Windows.Forms

$servername = '192.0.2.1'
$url = 'https://docs.google.com/presentation/d/e/2PACX-1vQYaVmzpXHweH2NFD1Apxe3CPZSBzsXCwAHpnvF9yAwcB-pW920XRjUXozn8nl9XH3xmgnF500t9PdI/pub?start=true&loop=true&delayms=10000'

clear

do { 
    Write-Host "Waiting for active WiFi connection..." 
    Start-Sleep -Seconds 5 
} until (Test-Connection $servername -Quiet -Count 1) 

Write-Host "Wifi connection active."
Write-Host "Moving mouse to the corner."

$screen = [System.Windows.Forms.SystemInformation]::VirtualScreen
[Windows.Forms.Cursor]::Position = "$($screen.Width),$($screen.Height)"

Write-Host "Launching Chrome."

$chrome = Start-Process -PassThru -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList "-kiosk -incognito $url"

$wshell = New-Object -ComObject wscript.shell
Write-Host "Chrome PID =" $chrome.Id
Write-Host "Waiting 30 seconds for Chrome to launch."
Start-Sleep -Seconds 30
while ($wshell.AppActivate($chrome.Id))
{
    Start-Sleep -Seconds 3600
    Write-Host "Refreshing Chrome."
    $wshell.SendKeys('{f5}')
    Write-Host "Waiting 1 hour before next refresh."
}
Wait