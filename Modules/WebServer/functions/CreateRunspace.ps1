function CreateRunspace {
    [cmdletbinding()]
    param(
        $runspacePool
    )

    $shell = [PowerShell]::Create()
    $shell.RunspacePool = $runspacePool


    return $shell
}