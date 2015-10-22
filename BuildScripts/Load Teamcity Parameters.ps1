
param(
    $prefix = 'TeamCity.',
    $file = $env:TEAMCITY_BUILD_PROPERTIES_FILE + ".xml",
    [switch] $inTeamCity = (![String]::IsNullOrEmpty($env:TEAMCITY_VERSION))
)


$buildProperties = @{};

if($inTeamCity){
    Write-Host "Loading TeamCity properties from $file"

    $file = (Resolve-Path $file).Path;

    $buildPropertiesXml = New-Object System.Xml.XmlDocument
    $buildPropertiesXml.XmlResolver = $null; # force the DTD not to be tested
    $buildPropertiesXml.Load($file);
    foreach($entry in $buildPropertiesXml.SelectNodes("//entry")){
        $key = $entry.key;
        $value = $entry.'#text';
        $buildProperties[$key] = $value;
        $key = "$prefix$key";

        Write-Verbose ("[TeamCity] Set {0}={1}" -f $key,$value);
        Set-Variable -Name:$key -Value:$value -Scope:1; # variables are loaded into parent scope
    }
}

$buildProperties