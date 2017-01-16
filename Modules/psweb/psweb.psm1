

# Loading functions
Get-ChildItem $PSScriptRoot -Recurse -Filter "*.ps1" | ForEach-Object -Process {
    Write-Host $_.FullName
    .  $_.fullname
}

