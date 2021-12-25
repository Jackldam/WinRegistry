function Test-RegistryKey {
    <#
    .SYNOPSIS
        Test if an registry key is present
    .DESCRIPTION
        Test if an registry key is present
    .EXAMPLE
        PS C:\> Test-RegistryKey "HKEY_LOCAL_MACHINE\SOFTWARE\GitForWindows\InstallPath"

        True
    .EXAMPLE
        PS C:\> Test-RegistryKey "HKEY_LOCAL_MACHINE\SOFTWARE\GitForWindows\InstallPat"

        False
    .OUTPUTS
        Boolean
    .NOTES
        25-12-2021 jack den Ouden <jack@ldam.nl>
        Function created, tested and verified as functional.
    #>
    [CmdletBinding()]
    param (
        # Key
        [Parameter()]
        [string]
        $RegistryKey
    )

    $Name = Split-Path $RegistryKey -Leaf

    $RegistryKey = Split-Path $RegistryKey -Parent
    
    $Key = "Registry::$RegistryKey"


    try {
        Get-ItemProperty -Path $Key -Name $Name -ErrorAction Stop | Out-Null
        $true
    }
    catch {
        $false
    }

}