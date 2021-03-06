param([string]$OutDir,[string]$FileType,[string]$Token,[string]$Value)

Function set-tokens-for-tests([string]$OutDir,[string]$FileType,[string]$token,[string]$Value)
{	
	$workingDir = Resolve-Path $OutDir
    Write-Host OutDir $OutDir
    Write-Host token $token
    Write-Host FileType $FileType
    Write-Host Value $Value
	Write-Host workingDir $workingDir
	[string[]]$tokenArray=$token.Split('|')
	[string[]]$ValueArray=$Value.Split('|')
	$filesList = Get-ChildItem  -Path $OutDir -Filter $FileType -Recurse
	for($i=0; $i -lt $tokenArray.length; $i++)
	{
        $tokenSplit=$tokenArray[$i]
        $ValueSplit=$ValueArray[$i] 

		foreach ($file in $filesList)	{

			    (Get-Content $file.Fullname) | foreach-object { $_ -replace $tokenSplit, $ValueSplit } | Set-Content $file.Fullname
		    }
	}	
}

set-tokens-for-tests $OutDir $FileType $token $Value