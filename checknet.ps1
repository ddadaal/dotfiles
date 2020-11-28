param(
    [string] $Contain
)

$BASE_PATH = 'HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Mappings\'
# 获取相关注册表信息，并进行筛选和排序
$mapping = Get-ChildItem -Pat $BASE_PATH | Where-Object {$Contain -Eq "" -or $_.GetValue('DisplayName').Contains($Contain)} | Sort-Object {$_.GetValue('DisplayName')}

if ($mapping.Length -eq 0) {
    Write-Output "没有包含字符 $Contain 的软件包，请重试。"
    exit
}
# 格式化打印 APP List
$mapping | Format-Table @{label='Num'; expression={$mapping.IndexOf($_)}}, @{label='DisplayName'; expression={$_.GetValue('DisplayName')}}
$input = Read-Host '回复序号并回车提交（若只有一项，输入0），添加指定应用到排除列表中'
$id = $mapping[$input].Name.Split("\") | Select-Object -Last 1
Write-Output $id
CheckNetIsolation LoopbackExempt -a -p="$id"