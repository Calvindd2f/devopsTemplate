function Set-EnvVar([string]$EnvName,[string]$Path){
    try{
      [System.Environment]::SetEnvironmentVariable("$EnvName","$Path")
    }
    catch{
      [null]$except=[Internal.Console]::WriteLine('You have fucked up')
      sleep 2
      error
      exit
    }


    if(!($except)){$msg=[Internal.Console]::WriteLine("EnvVar: $EnvName has been set to $Path")}
    return $msg
}
# Example usage:
<#
┌──(c㉿CALVIN)-[C:\sym]
└─PS> Set-EnvVar -EnvName '_NT_SYMBOL_PATH' -Path 'srv*DownstreamStore*https://msdl.microsoft.com/download/symbols'
EnvVar: _NT_SYMBOL_PATH has been set to srv*DownstreamStore*https://msdl.microsoft.com/download/symbols

┌──(c㉿CALVIN)-[C:\sym]
└─PS> $env:_NT_SYMBOL_PATH
srv*DownstreamStore*https://msdl.microsoft.com/download/symbols
#>
