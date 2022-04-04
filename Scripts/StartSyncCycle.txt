function Start-SyncCycle {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, Position = 0)]
        [ValidateSet('Delta','Initial')]
        [string]$PolicyType = 'Delta'
    )
    # test if the ADSyncScheduler is not suspended
    $scheduler = Get-ADSyncScheduler
    if ($scheduler.SchedulerSuspended) {
        # SchedulerSuspended is set during an upgrade to temporarily block the scheduler from running. 
        # When this property is $true, running Start-ADSyncSyncCycle wil result in error:
        # System.InvalidOperationException: Scheduler is already suspended via global parameters.

        Set-ADSyncScheduler -SchedulerSuspended $false
    }
    # test if a scheduled synchronization is already running
    if ($scheduler.SyncCycleInProgress) {  # or use: if (Get-ADSyncConnectorRunStatus) { ... }
        Write-Warning "A sync is already in progress. Please try again later."
    }
    else {
        Write-Host "Initializing Azure AD $PolicyType Sync..." -ForegroundColor Yellow
        try {
            Start-ADSyncSyncCycle -PolicyType $PolicyType -ErrorAction Stop | Out-Null

            Write-Host "Waiting for Sync to start.."
            # give the Sync Connector some time to start up (10 seconds should be enough)
            Start-Sleep -Seconds 10

            Write-Host "Waiting for Sync to finish.."
            While(Get-ADSyncConnectorRunStatus) {
                Write-Host "." -NoNewline
                Start-Sleep -Seconds 5
            }
            Write-Host
            Write-Host "Azure AD $PolicyType Sync has finished." -ForegroundColor Green

        }
        catch {
            Write-Error $_.Exception.Message
        }
    }
}
$cred = Get-Credential 
Invoke-Command -ComputerName S-ADCON -ScriptBlock ${function:Start-SyncCycle}  -Credential $cred 