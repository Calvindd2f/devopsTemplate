############################
$appID = $env:AppId
$appSecret = $env:AppSecret
$tenantID = $env:TenantId
############################

function add-path($path){
    $env:PATH += ";$path"
}
function Get-MgToken {
    param (
        [string]$scope = "https://graph.microsoft.com/.default"
    )
    $body = @{
        grant_type    = 'client_credentials'
        client_id     = $appID
        client_secret = $appSecret
        scope         = $scope
    }
    $tokenEndpoint = "https://login.microsoftonline.com/$tenantID/oauth2/v2.0/token"
    $response = Invoke-RestMethod -Uri $tokenEndpoint -Method Post -Body $body
    return $response.access_token
}
function Get-ExchangeToken {
        param (
                [string]$scope="https://outlook.office.com/.default"
        )
        $body = @{
                grant_type    = 'client_credentials'
                client_id     = $appID
                client_secret = $appSecret
                scope         = $scope
        }
        $tokenEndpoint = "https://login.microsoftonline.com/$tenantID/oauth2/v2.0/token"
        $response = Invoke-RestMethod -Uri $tokenEndpoint -Method Post -Body $body
        return $response.access_token
}
function TenantId{

    [CmdletBinding()]
    param
    (
        [ValidateScript({$_ -notmatch "@"})]
        [string]
        $domain,

        [ValidateScript({$_ -match "@"})]
        [string]
        $email
    )

    Process{
        if($domain){
            Write-Verbose 'Domain provided.'
        }
        elseif ($email) {
            Write-Verbose 'Split the string on the username to get the Domain.'
            $domain = $email.Split("@")[1]
        }
        else{
            throw
            Write-Warning 'You must provide a valid Domain or User email to proceed.'
        }

        Write-Verbose 'Query anonymously.'
        $tenantId = (Invoke-WebRequest -UseBasicParsing https://login.windows.net/$($Domain)/.well-known/openid-configuration|ConvertFrom-Json).token_endpoint.Split('/')[3]

        return $tenantId
    }
}

$modules=@(
        "PSScriptAnalyzer",
        "Microsoft365DSC",
        "ISESteroids"
)
ForEach($module in $modules){
    if(!(Get-Module $module )){
        Install-Module -Name $module
    }
}