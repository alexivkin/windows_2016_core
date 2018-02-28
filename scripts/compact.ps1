# should be stopped already - net stop wuauserv
Remove-Item -Recurse -Force C:\Windows\SoftwareDistribution\Download
mkdir C:\Windows\SoftwareDistribution\Download
# net start wuauserv

Optimize-Volume -DriveLetter C -Defrag

(New-Object System.Net.WebClient).DownloadFile('https://vagrantboxes.blob.core.windows.net/box/sdelete/v1.6.1/sdelete.exe', 'C:\Windows\Temp\sdelete.exe')
## %SystemRoot%\System32\
reg.exe ADD HKCU\Software\Sysinternals\SDelete /v EulaAccepted /t REG_DWORD /d 1 /f
#Set-ItemProperty "HKCU:\Software\Sysinternals\SDelete" -Name EulaAccepted -Value 1 -Type DWord
C:\Windows\Temp\sdelete.exe -q -z C:
rm C:\Windows\Temp\sdelete.exe
