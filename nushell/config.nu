overlay use ./modules/config.nu
overlay use ./modules/ohmyposh_load.nu
overlay use ./modules/from_pwsh_config.nu

source ~/.zoxide.nu

# Initialize oh-my-posh.nu at shell startup by adding this line in your config.nu file
source ~/.oh-my-posh.nu


# television config
# mkdir ($nu.data-dir | path join "vendor/autoload")
# tv init nu | save -f ($nu.data-dir | path join "vendor/autoload/tv.nu")
