$THEME="Honukai"
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser

Set-Prompt
Set-Theme $THEME

if (!(Test-Path -Path $PROFILE )) { New-Item -Type File -Path $PROFILE -Force }

Add-Content -Path $PROFILE -Value @"
Import-Module posh-git
Import-Module oh-my-posh
Set-Theme $THEME

function proxify {
        $env:HTTP_PROXY="http://127.0.0.1:1080"
        $env:HTTPS_PROXY="http://127.0.0.1:1080"
}

function unproxify {
        $env:HTTP_PROXY=$null
        $env:HTTPS_PROXY=$null
}
"@
