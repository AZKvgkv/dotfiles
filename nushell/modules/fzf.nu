# ========= fzf 集成模块 =========

export def history [] {
  history 
  | get command 
  | uniq 
  | reverse 
  | fzf 
  | str trim 
  | if $in != "" { nu -c $in }
}

export def open [] {
  ls ** | where type == "file" | get name | fzf | if $in != "" { open $in }
}

export def cd [] {
  ls ** | where type == "dir" | get name | fzf | if $in != "" { cd $in }
}

export def git-checkout [] {
  ^git branch --all --color=never 
  | lines 
  | each { str trim | str replace 'remotes/' '' } 
  | uniq 
  | fzf 
  | str trim 
  | if $in != "" { ^git checkout $in }
}

# ========= 快捷键绑定 =========

export-env {
  $env.config = ($env.config | merge {
    keybindings: [
      {
        name: fzf-history
        modifier: control
        key: r
        mode: [emacs, vi_normal, vi_insert]
        event: { send: executehostcommand cmd: "fzf history" }
      }
      {
        name: fzf-cd
        modifier: control
        key: g
        mode: [emacs, vi_normal, vi_insert]
        event: { send: executehostcommand cmd: "fzf cd" }
      }
    ]
  })
}
