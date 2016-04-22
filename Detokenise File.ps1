param(
	[string]$original_file ,
	[string]$destination_file,	
	[object] $tokens = @{ }

)
 
	
Function replaceStringPlaceholder
{
        $replacementsMade = 0
		$fileData = [System.IO.File]::ReadAllText($original_file);
		
	
		foreach($key in $tokens.Keys){
            $token = "{" + $key + "}"
            if ($fileData.Contains($token)){
                If ($key -eq $null) { 
                    write-host "$key skipped - was null"
                }	else {	
         
                    $value = $tokens.get_Item($key)
                        write-host "          $key replaced with $value"
				    $fileData = $fileData.Replace($token, $value)
                    $replacementsMade = $replacementsMade + 1
		        }
            }else{
                   #write-host "$key skipped - not found"
             
            }
		}
			 
        $r = [regex] "\{(.*?)\}"
        $match = $r.match($fileData)
         
        if ($match.Groups.Count -gt 0){
           $notFound = $match.Captures | % { $_.Value }
        }
		Write-Host "Detokenised $destination_file - replaced $replacementsMade tokens, could not replace $notFound"
		[System.IO.File]::WriteAllText($destination_file, $fileData, (New-Object System.Text.UTF8Encoding($False)))

}

replaceStringPlaceholder