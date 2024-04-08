
$fi = [IO.FileInfo]$global:logFile

if($fi.Length -gt $global:logFileMaxSize)
{
    # Larger than max size. Rename current to .bak
    # Delete current .bak if it exists        
    $bakFile = ($fi.DirectoryName + "\" + $fi.BaseName + ".lo_")
    if([IO.File]::Exists($bakFile))
    {
        try
        {
            [IO.File]::Delete($bakFile)
        }
        catch { }
    }
    try
    {
        $fi.MoveTo($bakFile)
    }
    catch { }
}

try
{
    $logPath = [IO.Path]::GetDirectoryName($global:logFile)        
    if(-not (Test-Path $logPath)) { mkdir -Path $logPath -Force -ErrorAction SilentlyContinue | Out-Null }
}
catch 
{
    $script:logFailed = $true
    return
}

$date = Get-Date

if($global:PSCommandPath)
{
    $fileObj = [System.IO.FileInfo]$global:PSCommandPath
}
else
{
    $fileObj = [System.IO.FileInfo]$PSCommandPath
}

$timeStr = "$($date.ToString(""HH"")):$($date.ToString(""mm"")):$($date.ToString(""ss"")).000+000"
$dateStr = "$($date.ToString(""MM""))-$($date.ToString(""dd""))-$($date.ToString(""yyyy""))"    
$logOut = "<![LOG[$Text]LOG]!><time=""$timeStr"" date=""$dateStr"" component=""$($fileObj.BaseName)"" context="""" type=""$type"" thread=""$PID"" file=""$($fileObj.BaseName)"">"

if($type -eq 2)
{
    Write-Warning $Text
    $typeStr = "Warning"
}
elseif($type -eq 3)
{
    if($global:logOutputError -ne $false)
    {
        $host.ui.WriteErrorLine($Text)
    }
    else
    {
        Write-Warning $Text
    }        
    $typeStr = "Error"
}
else
{
    write-host $Text
    $typeStr = "Info"
}

$script:LogItems.Add([PSCustomObject]@{
    ID = ($script:LogItems.Count + 1)
    DateTime = $date
    Type = $type
    TypeText = $typeStr
    Text = $Text
})

try
{    
    out-file -filePath $global:logFile -append -encoding "ASCII" -inputObject $logOut
}
catch { }
}

function Write-LogDebug
{
param($Text, $type = 1)

if($global:Debug)
{
    Write-Log ("Debug: " + $text) $type
}
}

function Write-LogError
{
param($Text, $Exception)

if($Text -and $Exception.message)
{
    $Text += " Exception: $($Exception.Message)"
}

Write-Log $Text 3
}

function Write-Status
{
param($Text, [switch]$SkipLog, [switch]$Block, [switch]$Force)

if($global:hideUI -eq $true) 
{
    if($SkipLog -ne $true) { Write-Log $text }
    return
}

if(-not $text) { $global:BlockStatusUpdates = $false }    
elseif($global:BlockStatusUpdates -eq $true -and $Force -ne $true) { return }
elseif($Block -eq $true) { $global:BlockStatusUpdates = $true }

$global:txtInfo.Content = $Text
if($text)
{
    $global:grdStatus.Visibility = "Visible"
    if($SkipLog -ne $true) { Write-Log $text }
}
else
{
    $global:grdStatus.Visibility = "Collapsed"
}

[System.Windows.Forms.Application]::DoEvents()
}

#endregion
