Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Honukai
function proxify {
        $env:HTTP_PROXY="http://127.0.0.1:1080"
        $env:HTTPS_PROXY="$env:HTTP_PROXY"
        $env:http_proxy="$env:HTTP_PROXY"
        $env:https_proxy="$env:HTTP_PROXY"
}
function unproxify {
        $env:HTTP_PROXY=$null
        $env:HTTPS_PROXY=$null
        $env:http_proxy=$null
        $env:https_proxy=$null
}
