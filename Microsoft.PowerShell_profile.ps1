Import-Module posh-git
Import-Module oh-my-posh
Import-Module ZLocation
Set-PoshPrompt -Theme Honukai

function proxify {
        $env:HTTP_PROXY = "http://127.0.0.1:1080"
        $env:HTTPS_PROXY = "$env:HTTP_PROXY"
        $env:http_proxy = "$env:HTTP_PROXY"
        $env:https_proxy = "$env:HTTP_PROXY"
}
function unproxify {
        $env:HTTP_PROXY = $null
        $env:HTTPS_PROXY = $null
        $env:http_proxy = $null
        $env:https_proxy = $null
}

Set-PSReadLineOption -PredictionSource History
 
Set-PSReadlineKeyHandler -Key Tab -Function Complete 
Set-PSReadLineKeyHandler -Key "Ctrl+d" -Function MenuComplete
Set-PSReadLineKeyHandler -Key "Ctrl+z" -Function Undo 
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-Alias -Name which -Value Get-Command
