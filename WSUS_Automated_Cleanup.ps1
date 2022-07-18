<# 
Name: WSUS Automated Cleanup
Initial Author: TAFEITLAB
Version: 20220627
Update author: TAFEITLAB
Update notes:
  20220627: Initial creation.
#>

# Get WSUS server
$wsus=Get-WsusServer -Name SERVERNAME -Port 8530

# Ensure WSUS Service is started
$wsus | Start-Service WSUSService

# Delete obsolete updates from the database
$wsus | Invoke-WsusServerCleanup -CleanupObsoleteUpdates

# Delete unneeded update files
$wsus || Invoke-WsusServerCleanup -CleanupUnneededContentFiles

# Decline expired updates
$wsus | Invoke-WsusServerCleanup -DeclineExpiredUpdates

# Decline superseded updates
$wsus | Invoke-WsusServerCleanup -DeclineSupersededUpdates

# Delete obsolete revisions to updates from the database
$wsus | Invoke-WsusServerCleanup -CompressUpdates

<# END OF SCRIPT #>

