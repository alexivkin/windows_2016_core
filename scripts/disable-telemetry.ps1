Write-Host "Disabling Telemetry..."
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0

Write-Host "Disabling Telemetry services..." 
Get-Service -Name "diagnosticshub.standardcollector.service" | Set-Service -StartupType Disabled | Stop-Service # Microsoft (R) Diagnostics Hub Standard Collector Service
Get-Service -Name "DiagTrack" | Set-Service -StartupType Disabled | Stop-Service # Diagnostics Tracking Service

# paranoid changes
#Get-ScheduledTask -TaskName "Microsoft Compatibility Appraiser" | Disable-ScheduledTask
#Get-ScheduledTask -TaskName "Consolidator" | Disable-ScheduledTask
#Get-ScheduledTask -TaskName "CreateObjectTask" | Disable-ScheduledTask
#Get-ScheduledTask -TaskName "GatherNetworkInfo" | Disable-ScheduledTask



