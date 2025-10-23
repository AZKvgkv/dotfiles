overlay use ./modules/config.nu
overlay use ./modules/ohmyposh_load.nu
overlay use ./modules/from_pwsh_config.nu

source ~/.zoxide.nu

# Initialize oh-my-posh.nu at shell startup by adding this line in your config.nu file
source ~/.oh-my-posh.nu

# Init atuin
source ./modules/atuin/init.nu
