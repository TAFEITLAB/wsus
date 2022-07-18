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

# Confirm last sync
($wsus).GetSubscription().GetLastSynchronizationInfo()

# Check for unapproved updates
$wsus | Get-WsusUpdate -Approval Unapproved

# Decline unwanted updates
$wsus | Get-WsusUpdate -Approval Unapproved -Status Any | Where { $_.update.title  -match "farm-deployment|ARM64|x86|SharePoint|Windows 10 Version 1809|Windows 10 Version 1909|Windows 10 Version 1607|Office 2016" } | Deny-WsusUpdate –Verbose

# Decline Superseded updates
$wsus | Get-WSUSUpdate -Classification All -Status Any -Approval AnyExceptDeclined | Where-Object {$_.Update.GetRelatedUpdates(([Microsoft.UpdateServices.Administration.UpdateRelationship]::UpdatesThatSupersedeThisUpdate)).Count -gt 0 } | Deny-WsusUpdate -Verbose

# Approve wanted updates
$wsus | Get-WsusUpdate -Approval Unapproved -Status Any | Where { $_.update.title  -match "Windows 10 Version 2004|Windows 10 Version 20H2|Windows 10 Version 21H1|Windows 10 Version 21H2|Windows Server 2019|Windows Server 2016|Windows Defender Antivirus|Microsoft Defender Antivirus|Office 2019"} | Approve-WsusUpdate -Action Install -TargetGroupName 'All Computers' -Verbose

<# END OF SCRIPT #>