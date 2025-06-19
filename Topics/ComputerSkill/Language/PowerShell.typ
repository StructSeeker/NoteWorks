=== Use -WhatIf for tentative running



== Setup Perference Variable 
```pwsh
$PSNativeCommandUseErrorActionPreference = $true
$WhatIfPreference = $true # -WhatIf:$false to override
```

== Join-Path



== Creating symbolink and junction
```pwsh
$targetFolder = "C:\Path\to\Target\Folder"
$shortcutPath = "C:\Path\to\Shortcut.lnk"
New-Item -ItemType SymbolicLink -Target $targetFolder -Path $shortcutPath
```

== Create Shortcut
```pwsh
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut("$env:appdata\Microsoft\Windows\Start Menu\Programs\Start.lnk")
$targetFolder = (join-path "$env:USERPROFILE" "Start.exe")
$shortcut.TargetPath = $targetFolder
$shortcut.Save()
```