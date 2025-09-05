# 预加载配置
$preloadCache = "$env:TEMP\pwsh-preload.ps1"
$ompCache = "$env:TEMP\omp-cache.ps1"

# Oh-my-posh 缓存初始化
if (!(Test-Path $ompCache) -or (Get-Item $ompCache).LastWriteTime -lt (Get-Date).AddDays(-1)) {
    oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/di4am0nd.omp.json" | Out-File -FilePath $ompCache
}
. $ompCache
${function:ll} = { lsd -l $args }
# 快速导入模块
$modules = @('DirColors', 'Terminal-Icons')
$modules | ForEach-Object { 
    if (Get-Module -ListAvailable -Name $_) {
        Import-Module $_ -DisableNameChecking
    }
}

# PSReadLine 配置（合并设置减少调用）
Set-PSReadLineOption -EditMode Emacs `
                    -PredictionSource History `
                    -PredictionViewStyle ListView

# 快捷键设置
@{
    'Tab' = 'Complete'
    'Ctrl+d' = 'MenuComplete'
    'Ctrl+z' = 'Undo'
    'UpArrow' = 'HistorySearchBackward'
    'DownArrow' = 'HistorySearchForward'
}.GetEnumerator() | ForEach-Object { 
    Set-PSReadLineKeyHandler -Key $_.Key -Function $_.Value 
}

# 别名设置
@{
    'vi' = 'vim'
    'c' = 'cls'
    'o' = 'gvim'
    'yz' = 'D:\!Workbenches\007_software\yazi-x86_64-pc-windows-msvc\yazi.exe'
    'f' = 'fastfetch'
    'n' = 'nvim'
    'm' = 'micro'
    'g' = 'git'
    #'ll' = 'lsd -l'
}.GetEnumerator() | ForEach-Object { Set-Alias $_.Key $_.Value -Force }

# Neovim配置函数（使用脚本属性提高性能）
$script:nvimConfigs = @{
    "as" = "AstroNvim"
    "az" = "az_nvim"
    "hd" = "HardNvim"
    "lz" = "LazyVim"
    "nm" = "NormalNvim"
    "nc" = "NvChad"
    "kk" = "Kickstart"
}

function n { 
    param(
        [Parameter(Position = 0)]
        [string]$Config = "",
        [Parameter(ValueFromRemainingArguments)]
        $args
    )
    
    if ($Config -and $script:nvimConfigs.ContainsKey($Config)) {
        $env:NVIM_APPNAME = $script:nvimConfigs[$Config]
    }
    
    nvim $args
}

# 自动加载函数（延迟加载）
${function:Get-CommandPath} = { 
    param([string]$name)
    (Get-Command $name).Path
}.GetNewClosure()

${function:Update-File} = { 
    param([string]$Path)
    if (Test-Path $Path) {
        (Get-ChildItem $Path).LastWriteTime = Get-Date
    } else {
        New-Item -Path $Path -ItemType file
    }
}.GetNewClosure()

${function:Get-DirectorySize} = { 
    param ([string]$Path)
    $bytes = (Get-ChildItem $Path -Recurse -File | Measure-Object -Property Length -Sum).Sum
    switch ($bytes) {
        {$_ -lt 1KB} { "$bytes Bytes"; break }
        {$_ -lt 1MB} { "$([math]::Round($bytes / 1KB, 2)) KB"; break }
        {$_ -lt 1GB} { "$([math]::Round($bytes / 1MB, 2)) MB"; break }
        default { "$([math]::Round($bytes / 1GB, 2)) GB" }
    }
}.GetNewClosure()

# fzf配置（延迟加载）
$null = Register-EngineEvent -SourceIdentifier PowerShell.OnIdle -MaxTriggerCount 1 -Action {
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
    Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
}

# 条件加载Chocolatey
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module $ChocolateyProfile
}