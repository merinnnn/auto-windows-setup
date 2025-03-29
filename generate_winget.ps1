$installedApps = winget list | ForEach-Object { $_ -split '\s{2,}' } | Where-Object { $_ -match '\S' }

# Filter out system apps and extract package names
$apps = @()
foreach ($app in $installedApps) {
    if ($app -match '^(.*?)\s{2,}(.*?)\s{2,}(.*?)$') {
        $name = $matches[1]
        $id = $matches[2]
        if ($id -ne "----" -and $id -ne "Name") { # Exclude header rows
            $apps += "winget install --id `"$id`" --silent --accept-package-agreements --accept-source-agreements"
        }
    }
}

$outputFile = "$env:USERPROFILE\Desktop\winget_reinstall_script.ps1"
$apps | Set-Content -Path $outputFile

Write-Host "Reinstallation script generated: $outputFile"
