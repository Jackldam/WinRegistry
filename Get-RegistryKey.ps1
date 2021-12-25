function Get-RegistryKey {
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
        [Parameter(Mandatory)]
        [string]
        $RegistryKey,
        # Parameter help description
        [Parameter()]
        [switch][bool]
        $List
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