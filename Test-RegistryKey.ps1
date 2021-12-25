function Test-RegistryKey {
    <#
    .SYNOPSIS
        Short description
    .DESCRIPTION
        Long description
    .EXAMPLE
        PS C:\> <example usage>
        Explanation of what the example does
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        Output (if any)
    .NOTES
        General notes
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