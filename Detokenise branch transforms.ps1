
$parametersFilePath =  if (![String]::IsNullOrEmpty($env:TEAMCITY_VERSION)) { $env:TEAMCITY_BUILD_PROPERTIES_FILE + ".xml" } else { ".\BuildScripts\Example Teamcity Properties.xml" }

$tokens = & "$PSScriptRoot/Load Teamcity Parameters.ps1" -file $parametersFilePath
 
Write-Host "Found tokens:"
$tokens

Get-ChildItem -Filter *.branch.config -Recurse | % {


    #Swap tokens in project.Branch.config out for teamcity parameter
    $transformFile = $_.FullName
    $shortName = $_.FullName.Substring($PSScriptRoot.Length - 7)
    write-host "     detokenising  $shortName ..."
    & "$PSScriptRoot/Detokenise File.ps1" $transformFile $transformFile $tokens

    write-host "     done."
}