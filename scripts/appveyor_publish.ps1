$credentials = "buddyspike:$($Env:BINTRAY_APIKEY)"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($credentials))

$basicAuthValue = "Basic $encodedCreds"

$Headers = @{
    Authorization = $basicAuthValue
}

if ($Env:APPVEYOR_REPO_TAG_NAME -ne $null) {
  Invoke-WebRequest -Method Put -Infile build/mbt_windows_x86.zip -Headers $Headers -ContentType "multipart/form-data" -Uri "https://api.bintray.com/content/buddyspike/bin/mbt_windows_x86/$($Env:APPVEYOR_REPO_TAG_NAME)/mbt_windows_x86.zip"
} else {
  Write-Host "Publishing skipped - not a tagged build"
}
