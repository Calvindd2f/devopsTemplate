[CmdletBinding(SupportsShouldProcess=$True)]
param(
    [switch]
    $ShowConsoleWindow,
    [switch]
    $JSonSettings,
    [string]
    $JSonFile,
    [switch]
    $Silent,
    [string]
    $SilentBatchFile = "",
    [string]
    $TenantId,
    [string]
    $AppId,
    [string]
    $Secret,
    [string]
    $Certificate
)
#Import-Module ($PSScriptRoot + "\.psd1") -Force
#$param = $PSBoundParameters
#$? @param