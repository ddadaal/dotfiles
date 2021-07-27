Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Install-Module ZLocation -Scope CurrentUser

Set-PoshPrompt -Theme Honukai

if (!(Test-Path -Path $PROFILE )) { New-Item -Type File -Path $PROFILE -Force }

Copy-Item -Path ./Microsoft.PowerShell_profile.ps1 -Destination $PROFILE
