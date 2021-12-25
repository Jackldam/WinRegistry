function Get-RegistryKey {
    <#
    .SYNOPSIS
        Get the current value of an registrykey
    .DESCRIPTION
        Get the current value of an registrykey
    .EXAMPLE
        PS C:\> Get-RegistryKey "hklm\SOFTWARE\GitForWindows\InstallPath"

        C:\Program Files\Git
    .EXAMPLE
        PS C:\> Get-RegistryKey "HKEY_LOCAL_MACHINE\SOFTWARE\GitForWindows\InstallPath"

        C:\Program Files\Git
    .NOTES
        25-12-2021 jack den Ouden <jack@ldam.nl>
        Function created, tested and verified as functional.
    #>
    [CmdletBinding()]
    param (
        # Key
        [Parameter(Mandatory)]
        [string]
        $RegistryKey
    )

    $Name = Split-Path $RegistryKey -Leaf

    $RegistryKey = Split-Path $RegistryKey -Parent
    
    $Key = "Registry::$RegistryKey"

    try {
        Get-ItemPropertyValue -Path $Key `
            -Name $Name `
            -ErrorAction "Stop"
    }
    catch {
        Throw $_.Exception.message
    }

}