<# 
Name: WSUS Automated Approvals
Initial Author: TAFEITLAB
Version: 20220627
Update author: TAFEITLAB
Update notes:
  20220622: Initial creation.
  20220627: Added END OF SCRIPT comment
#>

# Get WSUS server
$wsus=Get-WsusServer -Name SERVERNAME -Port 8530

# Ensure WSUS Service is started
$wsus | Start-Service WSUSService

# Force Synchronisation
$wsus | (Get-WsusServer).GetSubscription().StartSynchronization()

<# END OF SCRIPT #>