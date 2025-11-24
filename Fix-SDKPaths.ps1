# PowerShell script to fix hardcoded paths in SDK project files
# Replaces hardcoded paths with Visual Studio macros for portability

$sdkPath = "Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK"
$projectFiles = Get-ChildItem -Path $sdkPath -Filter "*.vcxproj" -Recurse

$replacements = @{
    # IncludePath replacements
    'C:\\Program Files %28x86%29\\Microsoft SDKs\\Windows\\v7\.0A\\Include' = '$(WindowsSdkDir)Include'
    'C:\\Program Files %28x86%29\\Microsoft Visual Studio 10\.0\\VC\\include' = '$(VCInstallDir)include'
    'C:\\Program Files %28x86%29\\Microsoft Visual Studio 10\.0\\VC\\atlmfc\\include' = '$(VCInstallDir)atlmfc\include'
    'C:\\Program Files %28x86%29\\Microsoft DirectX SDK %28June 2010%29\\Include' = '$(DXSDK_DIR)\Include'
    'C:\\Program Files %28x86%29\\Microsoft DirectX SDK %28August 2007%29\\Include' = '$(DXSDK_DIR)\Include'
    'C:\\Program Files %28x86%29\\Microsoft DirectX SDK %28October 2006%29\\Include' = '$(DXSDK_DIR)\Include'
    
    # LibraryPath replacements
    'C:\\Program Files %28x86%29\\Microsoft Visual Studio 10\.0\\VC\\atlmfc\\lib' = '$(VCInstallDir)atlmfc\lib'
    'C:\\Program Files %28x86%29\\Microsoft SDKs\\Windows\\v7\.0A\\Lib' = '$(WindowsSdkDir)Lib'
    'C:\\Program Files %28x86%29\\Microsoft Visual Studio 10\.0\\VC\\lib' = '$(VCInstallDir)lib'
    'C:\\Program Files %28x86%29\\Microsoft DirectX SDK %28June 2010%29\\Lib\\x86' = '$(DXSDK_DIR)\Lib\x86'
    'C:\\Program Files %28x86%29\\Microsoft DirectX SDK %28August 2007%29\\Lib\\x86' = '$(DXSDK_DIR)\Lib\x86'
    'C:\\Program Files %28x86%29\\Microsoft DirectX SDK %28October 2006%29\\Lib\\x86' = '$(DXSDK_DIR)\Lib\x86'
}

$updatedFiles = 0

foreach ($file in $projectFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    $fileUpdated = $false
    
    foreach ($pattern in $replacements.Keys) {
        if ($content -match $pattern) {
            $content = $content -replace $pattern, $replacements[$pattern]
            $fileUpdated = $true
        }
    }
    
    if ($fileUpdated) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Updated: $($file.Name)" -ForegroundColor Green
        $updatedFiles++
    }
}

Write-Host "`nTotal files updated: $updatedFiles" -ForegroundColor Cyan

