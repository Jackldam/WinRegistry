function Set-RegistryKey {
    <#
    .SYNOPSIS
        Set an registry key 
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
        25-12-2021 jack den Ouden <jack@ldam.nl>
        Function created, tested and verified as functional.
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
        $PropertyType,
        # Parameter needed to overwrite an registry key.
        [Parameter()]
        [switch][bool]
        $Force

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

        $ItemProperty = @{
            New-ItemProperty -Path $Key `
            -PropertyType $PropertyType `
            -Name $Name `
            -Value $Value `
            -Force `
            -ErrorAction "Stop"
        }

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

Set-RegistryKey -RegistryKey "HKEY_LOCAL_MACHINE\SOFTWARE\GitForWindows\InstallPath2" -Value "C:\example" -PropertyType String