# config.nu
#
# Installed by:
# version = "0.103.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.


export-env {
  # $env.config.edit_mode = "vi"
  $env.config.buffer_editor = "nvim"
  $env.config.show_banner = false

  $env.config.history = {
    file_format: sqlite
    max_size: 1_000_000
    sync_on_enter: true
    isolation: true
  }
}

# 查询历史命令
# hist 命令：默认 20 条，可加数字或关键字
export def hist [
    n?: int = 20,          # 显示条数
    --rg: string = ""    # 可选过滤关键字
] {
    let db = $"($nu.config-path | path dirname)/history.sqlite3"
    let sql = if $rg == "" {
        $"select command_line from history order by start_timestamp desc limit ($n)"
    } else {
        $"select command_line from history where command_line like '%($rg)%'
          order by start_timestamp desc limit ($n)"
    }
    open $db | query db $sql
}