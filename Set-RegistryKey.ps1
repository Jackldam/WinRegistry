function Set-RegistryKey {
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
        # Value
        [Parameter(Mandatory)]
        [string]
        $Value,
        # Registry Value Types
        [Parameter(Mandatory)]
        [validateset("Binary", "DWord", "ExpandString", "MultiString", "String", "QWord")]
        $PropertyType

    )

    $Name = Split-Path $RegistryKey -Leaf

    $RegistryKey = Split-Path $RegistryKey -Parent
    
    $Key = "Registry::$RegistryKey"

    try {
        if (!(Test-Path $Key)) {
            Write-Verbose "Creating key: $RegistryKey"
            New-Item $Key -Force | Out-Null
        }

        Write-Verbose "Setting $RegistryKey\$Name to $PropertyType Value $Value "
        New-ItemProperty -Path $Key `
            -PropertyType $PropertyType `
            -Name $Name `
            -Value $Value `
            -Force `
            -ErrorAction "Stop" | Out-Null
    }
    catch {
        Throw $_.Exception.message
    }

}
