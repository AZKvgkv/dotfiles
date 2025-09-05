#Invoke-Expression (&starship init powershell)

# ============ starship config home============
if (-not (Test-Path env:STARSHIP_SHELL)) {
   $starshipCmd = Get-Command starship -ErrorAction SilentlyContinue
   if ($starshipCmd) {
       & $starshipCmd init powershell --print-full-init | Out-String | Invoke-Expression
   }   

   Invoke-Expression (& { (zoxide init powershell | Out-String) })
   Invoke-Expression (&scoop-search --hook)
}
# ============ starship config end============


# ============ Oh-My-Posh config home============
# $ompCache = "$env:TEMP\omp-cache.ps1"
# if (!(Test-Path $ompCache) -or (Get-Item $ompCache).LastWriteTime -lt (Get-Date).AddDays(-1)) {
#
# 	$currentTheme = "$env:POSH_THEMES_PATH/pure.omp.json"
# 	$currentTheme = "$env:POSH_THEMES_PATH/amro.omp.json"
# 	$currentTheme = "$env:POSH_THEMES_PATH/ys.omp.json"
# 	$currentTheme = "$env:POSH_THEMES_PATH/star.omp.json"
# 	$currentTheme = "$env:POSH_THEMES_PATH/tokyonight_storm.omp.json"
#   $currentTheme = "$env:POSH_THEMES_PATH/craver.omp.json"
#	$currentTheme = "$env:POSH_THEMES_PATH/M365Princess.omp.json"
#	$currentTheme = "$env:POSH_THEMES_PATH/spaceship.omp.json"
#	$currentTheme = "$env:POSH_THEMES_PATH/illusi0n.omp.json"
#	$currentTheme = "$env:POSH_THEMES_PATH/the-unnamed.omp.json"
#     oh-my-posh init pwsh --config $currentTheme | Out-File $ompCache
# }
# . $ompCache
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/amro.omp.json" | Invoke-Expression
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/ys.omp.json" | Invoke-Expression

# $ompTheme = "$env:POSH_THEMES_PATH/uew.omp.json"
# $ompCache = "$env:TEMP\omp-cache.ps1"
# if (!(Test-Path $ompCache) -or (Get-Item $ompTheme).LastWriteTime -gt (Get-Item $ompCache).LastWriteTime) {
#     oh-my-posh init pwsh --config $ompTheme | Out-File $ompCache
# }
# . $ompCache
#
# Invoke-Expression (& { (zoxide init powershell | Out-String) })
# Invoke-Expression (&scoop-search --hook)
# ============ Oh-My-Posh config end============


# 自定义函数
${function:e} = { eza -Al $args }
${function:l} = { lsd $args }
${function:ll} = { lsd -Al $args }
${function:lt} = { lsd --tree $args }
${function:ltd} = { lt --depth $args }
function y {
    $tmp = (New-TemporaryFile).FullName
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
    }
    Remove-Item -Path $tmp
}

# 别名设置，批量设置
@{
    'vi' = 'vim'
    'n' = 'nvim'
    'c' = 'cls'
    'o' = 'gvim'
#    'yz' = 'C:\Users\AZK19\Software\yazi-x86_64-pc-windows-msvc\yazi.exe'
    'f' = 'fastfetch'
    'm' = 'micro'
    'g' = 'git'
    'gds' = 'Get-DirectorySize'
    'copyfile' = 'Copy-FileContentToClipboard'
    'copypath' = 'Copy-Path'
}.GetEnumerator() | ForEach-Object { 
    Set-Alias $_.Key $_.Value -Force
}

# Neovim 配置函数（提前定义，避免每次加载时都执行）
$script:nvimConfigNames = @{
    "as" = "AstroNvim"
    "az" = "az_nvim"
    "nc" = "NvChad"
    "kk" = "KickStart"
    "lz" = "LazyVim"
    "nv" = "nvim"
    "tv" = "TinyNvim"
}

function ns {
    param(
        [Parameter(Position = 0)]
        [string]$Config = "",
        [Parameter(ValueFromRemainingArguments)]
        $args
    )
    
    #每次清除 NVIM_APPNAME 环境变量，确保每次启动都使用新的配置
    #Remove-Item Env:NVIM_APPNAME -ErrorAction SilentlyContinue

    # 如果没有指定配置，使用 fzf 列出所有配置（显示全名）
    if (-not $Config) {
        $Config = $script:nvimConfigNames.Values | fzf --prompt=" 󰔰  AZ's Config 󰶻 " --height=~70% --layout reverse --border --exit-0
    }

    # 如果配置是简写，映射到完整名称
    if ($script:nvimConfigNames.ContainsKey($Config)) {
        $Config = $script:nvimConfigNames[$Config]
    }

    # 查找对应的配置名称
    if ($script:nvimConfigNames.Values -contains $Config) {
        $env:NVIM_APPNAME = $Config
        nvim $args
    } else {
        Write-Host "Invalid config name. Available options are: $($script:nvimConfigNames.Values -join ', ')"
    }
}

#Set-PSReadLineOption -EditMode Vi `
#Set-PSReadLineOption -EditMode Emacs `

#Import-Module posh-git
#Import-Module Az.Tools.Predictor #暂时先不用
Import-Module -Name CompletionPredictor
Set-PSReadLineOption -EditMode Emacs `
                     -PredictionSource HistoryAndPlugin `
                     -PredictionViewStyle ListView `
                     -HistoryNoDuplicates:$true `
                     -AddToHistoryHandler {
                         param($line)

                         if ([string]::IsNullOrWhiteSpace($line)) {
                             return $false
                         }

                         if ($line -eq $global:__lastHistoryLine) {
                             return $false
                         }

                         $global:__lastHistoryLine = $line
                         return $true
                     }

#Get-Content "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt" |
#    Sort-Object -Unique |
#    Set-Content "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"


# 快捷键设置 (批量设置)
@{
#    'Tab' = 'Complete'
    'Ctrl+d' = 'MenuComplete'
    'Ctrl+z' = 'Undo'
    'UpArrow' = 'HistorySearchBackward'
    'DownArrow' = 'HistorySearchForward'
}.GetEnumerator() | ForEach-Object { 
    Set-PSReadLineKeyHandler -Key $_.Key -Function $_.Value 
}


$uvCompletionPath = "$env:LOCALAPPDATA\uv-completion.ps1"
# 自动加载函数（延迟加载）
$null = Register-EngineEvent -SourceIdentifier PowerShell.OnIdle -MaxTriggerCount 1 -Action {
	# startship theme config
	#Invoke-Expression (&starship init powershell)
	
	# PSReadLine 和 Fzf 的延迟加载
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
    Set-PSReadLineKeyHandler -Key Alt+c -ScriptBlock { Invoke-FuzzySetLocation }
    Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
    
	# DirColors 和 Terminal-Icons 仅在需要时加载
    # 监听 ls 和 lsd -l 等命令来延迟加载模块
    if (Get-Command "ls" -ErrorAction SilentlyContinue) {
#        Import-Module DirColors Terminal-Icons -DisableNameChecking -Global
        Import-Module Terminal-Icons -DisableNameChecking -Global
    }
       
	if (-not (Test-Path $uvCompletionPath)) {
		uv generate-shell-completion powershell | Out-File -Encoding UTF8 $uvCompletionPath
	}
	. $uvCompletionPath
}

# 函数定义（提升性能）
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

${function:Copy-FileContentToClipboard} = {
    param([string]$FilePath)
    Get-Content -Path $FilePath | Set-Clipboard
}.GetNewClosure()

${function:Copy-Path} = {
    param([string]$Path = (Get-Location).Path)
    $AbsolutePath = Resolve-Path -LiteralPath $Path
    $AbsolutePath | Set-Clipboard
    Write-Host "`e[1m$AbsolutePath`e[0m copied to clipboard."
}.GetNewClosure()
