<# 
Name: WSUS Automated Approvals
Initial Author: TAFEITLAB
Version: 20220622
Update author: TAFEITLAB
Update notes:
  20220622: Initial creation.
#>

# Get WSUS server
$wsus=Get-WsusServer -Name SERVERNAME -Port 8530

# Ensure WSUS Service is started
$wsus | Start-Service WSUSService