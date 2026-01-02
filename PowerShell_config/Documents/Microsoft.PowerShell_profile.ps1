# starship config
if (-not (Test-Path env:STARSHIP_SHELL))
{
    $starshipCmd = Get-Command starship -ErrorAction SilentlyContinue
    if ($starshipCmd)
    {
        & $starshipCmd init powershell --print-full-init | Out-String | Invoke-Expression
    }

    Invoke-Expression (& { (zoxide init powershell | Out-String) })
    Invoke-Expression (&scoop-search --hook)
}

${function:az} = {ns az $args}
${function:tt} = {ns tv $args}
${function:lz} = {ns lz $args}
${function:kk} = {ns kk $args}
${function:nc} = {ns nc $args}
${function:as} = {ns as $args}
${function:e} = { eza  --icons $args }
${function:ee} = { eza -al --git --icons $args }
${function:et} = { eza -ahl --git --icons --tree --level 2 $args }
${function:l} = { lsd $args }
${function:ll} = { lsd -Al -g $args }
${function:lt} = { lsd -l --git --tree $args }
${function:ltd} = { lt --depth $args }

function y
{
    $tmp = (New-TemporaryFile).FullName
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path)
    {
        Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
    }
    Remove-Item -Path $tmp
}
@{
    'vi' = 'vim'
    'n' = 'nvim'
    'c' = 'cls'
    'o' = 'gvim'
    'f' = 'fastfetch'
    'm' = 'micro'
    'g' = 'git'
    'gds' = 'Get-DirectorySize'
    'copyfile' = 'Copy-FileContentToClipboard'
    'copypath' = 'Copy-Path'
}.GetEnumerator() | ForEach-Object {
    Set-Alias $_.Key $_.Value -Force
}

$script:nvimConfigNames = @{
    "as" = "AstroNvim"
    "az" = "az_nvim"
    "nc" = "NvChad"
    "kk" = "KickStart"
    "lz" = "LazyVim"
    "nv" = "nvim"
    "tv" = "TinyNvim"
}

function ns
{
    param(
        [Parameter(Position = 0)]
        [string]$Config,
        [Parameter(ValueFromRemainingArguments)]
        [array]$myArgs
    )

    if (-not $Config)
    {
        $Config = $script:nvimConfigNames.Values | fzf --prompt=" 󰔰  AZ's Config 󰶻 " --height=~70% --layout reverse --border --exit-0
        if (-not $Config)
        {return
        }
    }
    if ($script:nvimConfigNames.ContainsKey($Config))
    {
        $Config = $script:nvimConfigNames[$Config]
    }
    if ($script:nvimConfigNames.Values -contains $Config)
    {
        $env:NVIM_APPNAME = $Config
        nvim $myArgs
        return
    }
    Write-Host "Invalid config name. Available options are: $($script:nvimConfigNames.Values -join ', ')"
}

Import-Module -Name CompletionPredictor
Import-Module gsudoModule
Set-PSReadLineOption -EditMode Emacs `
    -PredictionSource HistoryAndPlugin `
    -PredictionViewStyle ListView `
    -HistoryNoDuplicates:$true `
    -AddToHistoryHandler {
    param($line)

    if ([string]::IsNullOrWhiteSpace($line))
    {
        return $false
    }

    if ($line -eq $global:__lastHistoryLine)
    {
        return $false
    }

    $global:__lastHistoryLine = $line
    return $true
}

@{
    'Tab' = 'Complete'
    'Ctrl+d' = 'MenuComplete'
    'Ctrl+z' = 'Undo'
    'UpArrow' = 'HistorySearchBackward'
    'DownArrow' = 'HistorySearchForward'
}.GetEnumerator() | ForEach-Object {
    Set-PSReadLineKeyHandler -Key $_.Key -Function $_.Value
}

$uvCompletionPath = "$env:LOCALAPPDATA\uv-completion.ps1"
$null = Register-EngineEvent -SourceIdentifier PowerShell.OnIdle -MaxTriggerCount 1 -Action {

    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
    Set-PSReadLineKeyHandler -Key Alt+c -ScriptBlock { Invoke-FuzzySetLocation }

    if (-not (Test-Path $uvCompletionPath))
    {
        uv generate-shell-completion powershell | Out-File -Encoding UTF8 $uvCompletionPath
    }
    . $uvCompletionPath
}


${function:Get-CommandPath} = {
    param([string]$name)
    (Get-Command $name).Path
}.GetNewClosure()

${function:Update-File} = {
    param([string]$Path)
    if (Test-Path $Path)
    {
        (Get-ChildItem $Path).LastWriteTime = Get-Date
    } else
    {
        New-Item -Path $Path -ItemType file
    }
}.GetNewClosure()

${function:Get-DirectorySize} = {
    param ([string]$Path)
    $bytes = (Get-ChildItem $Path -Recurse -File | Measure-Object -Property Length -Sum).Sum
    switch ($bytes)
    {
        {$_ -lt 1KB}
        { "$bytes Bytes"; break
        }
        {$_ -lt 1MB}
        { "$([math]::Round($bytes / 1KB, 2)) KB"; break
        }
        {$_ -lt 1GB}
        { "$([math]::Round($bytes / 1MB, 2)) MB"; break
        }
        default
        { "$([math]::Round($bytes / 1GB, 2)) GB"
        }
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
