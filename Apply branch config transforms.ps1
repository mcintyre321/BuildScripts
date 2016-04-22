 
$parametersFilePath =  if (![String]::IsNullOrEmpty($env:TEAMCITY_VERSION)) { $env:TEAMCITY_BUILD_PROPERTIES_FILE + ".xml" } else { ".\BuildScripts\Example Teamcity Properties.xml" }

$tokens = & "BuildScripts/Load Teamcity Parameters.ps1" -file $parametersFilePath
 
Get-ChildItem -Filter *.branch.config -Recurse | % {

    
    # apply the config transform to web.config or app.config
  
    write-host (Resolve-Path -Relative $transformTarget)
    write-host "    detokenising..."
    & "BuildScripts/Detokenise File.ps1" $transformTarget $transformTarget  $tokens

    write-host "     done."
}