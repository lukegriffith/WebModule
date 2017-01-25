function DeployModule{
    param($Name,$Path)

}

task -name Deploy -action { 

    Get-ChildItem -Path $PSScriptRoot\Modules | ForEach-Object -Process {
        $Name = $_.Name 
        $Path = $_.FullName

        if (-not (Get-Module -Name $Name -ErrorAction SilentlyContinue)){
           New-Item -Path $env:USERPROFILE\Documents\WindowsPowerShell\Modules -Name $Name -ItemType Junction -Value $Path
        }
    }

}  


task -name Test -action {

    ipmo Pester
    $pOut = Invoke-Pester -PassThru


    if ($pOut.FailedCount -gt 0) {
        Write-Error "Unit testing failed."
    }



}
