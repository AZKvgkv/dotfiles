export alias vi = vim
export alias n = nvim
export alias c = cls
export alias o = gvim
export alias y = yazi
export alias f = fastfetch
export alias m = micro
export alias g = git
export alias ni = touch
export alias md = mkdir

export alias e = eza --icons
export alias ee = eza -al --git --icons
export alias et = eza -ahl --git --icons --tree --level 2
export alias l = lsd
export alias ll = lsd -Al -g
export alias lt = lsd -l --git --tree
export alias ltd = lt --depth
export alias ls = ls -al

export def scoop_update_status [] {
    scoop update
    scoop status
}
export def scoop_cache_clean [] {
    scoop cache rm *
    scoop cleanup -a
}
export alias suss = scoop_update_status
export alias scc = scoop_cache_clean

export def ss [$name] {
    scoop-search $name
}

export def "scoop search" [$args] {
  scoop-search $args
}

export def copypath [path?: string] {
  let target = if ($path == null) { pwd } else { $path }
  let abs = ($target | path expand)
  $abs | clip
  print $"($abs) copied to clipboard."
}

# TODO
# nvim_configs
# let nvimConfigNames = {
#     as: "AstroNvim",
#     az: "az_nvim",
#     nc: "NvChad",
#     kk: "KickStart",
#     lz: "LazyVim",
#     nv: "nvim",
#     tv: "TinyNvim"
# }
#
#
# def ns [config?: string] {
#     let key = if ($config | is-empty) {
#         let lines = ($nvimConfigNames | transpose k v | each {|r| $"($r.k): ($r.v)"})
#         let keys = $nvimConfigNames | columns
#         let chosen = ($lines | str join "\n" | fzf --prompt=" 󰔰  AZ's Config 󰶻 " --height=~40% --layout=reverse --border --exit-0)
#         if ($chosen | is-empty) { return }
#         $chosen | str trim
#     } else {
#         $config
#     }
#
#     let full = $nvimConfigNames | get -o $key
#     if ($full | is-empty) {
#         print $"Invalid config name. Available options: ($nvimConfigNames | columns | str join ', ')"
#         return
#     }
#
#     with-env { NVIM_APPNAME: $full } { nvim }
# }
#
