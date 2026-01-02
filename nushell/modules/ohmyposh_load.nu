# Custom Prompt
export-env {
### Generate the .oh-my-posh.nu file
  let omp_theme_path = '~/application/scoop/apps/oh-my-posh/current/themes/'

  let avit = ($omp_theme_path | path join "avit.omp.json")
  let nordtron = ($omp_theme_path | path join "nordtron.omp.json")
  let sorin = ($omp_theme_path | path join "sorin.omp.json")
  let the_unnamed = ($omp_theme_path | path join "the-unnamed.omp.json")
  let tokyonight_storm = ($omp_theme_path | path join "tokyonight_storm.omp.json")

  let amro = ($omp_theme_path | path join "amro.omp.json")
  let cobalt2 = ($omp_theme_path | path join "cobalt2.omp.json")
  let cinnamon = ($omp_theme_path | path join "cinnamon.omp.json")
  let di4am0nd = ($omp_theme_path | path join "di4am0nd.omp.json")
  let easy_term = ($omp_theme_path | path join "easy-term.omp.json")
  let robbyrussell = ($omp_theme_path | path join "robbyrussell.omp.json")
  let star = ($omp_theme_path | path join "star.omp.json")
  let xtoys = ($omp_theme_path | path join "xtoys.omp.json")
  let ys = ($omp_theme_path | path join "ys.omp.json")


  let mt = ($omp_theme_path | path join "mt.omp.json")
  let onehalf_minimal = ($omp_theme_path | path join "onehalf.minimal.omp.json")

  let pararussel = ($omp_theme_path | path join "pararussel.omp.json")
  let peru = ($omp_theme_path | path join "peru.omp.json")
  let pure = ($omp_theme_path | path join "pure.omp.json")


  let probua_minial = ($omp_theme_path | path join "probua.minimal.omp.json")
  let space = ($omp_theme_path | path join "space.omp.json")
  let spaceship = ($omp_theme_path | path join "spaceship.omp.json")

  let devious_diamonds = ($omp_theme_path | path join "devious-diamonds.omp.yaml")

  # oh-my-posh init nu --config $space
  # oh-my-posh init nu --config $the_unnamed
  # oh-my-posh init nu --config $star
  # oh-my-posh init nu --config $avit
  # oh-my-posh init nu --config $ys
  # oh-my-posh init nu --config $spaceship

  # oh-my-posh init nu --config $devious_diamonds



  # oh-my-posh init nu --config ~/Application/Scoop/apps/oh-my-posh/current/themes/zash.omp.json

  ## az_config
  # let az_omp_path = '~/Develop/dotfiles/ohmyposh_themes/'
  # oh-my-posh init nu --config ~/Develop/dotfiles/ohmyposh_themes/star.omp.json

  # oh-my-posh init nu --config ~/Develop/dotfiles/ohmyposh_themes/sorin.omp.json
  # oh-my-posh init nu --config ~/Develop/dotfiles/ohmyposh_themes/onehalf.minimal.omp.json
  # oh-my-posh init nu --config ~/Develop/dotfiles/ohmyposh_themes/amro.omp.json
  # oh-my-posh init nu --config ~/Develop/dotfiles/ohmyposh_themes/tokyonight_storm.omp.json
  # oh-my-posh init nu --config ~/Develop/dotfiles/ohmyposh_themes/craver.omp.json
  # oh-my-posh init nu --config ~/Develop/dotfiles/ohmyposh_themes/emodipt-extend.omp.json
  # oh-my-posh init nu --config ~/Develop/dotfiles/ohmyposh_themes/velvet.omp.json

  oh-my-posh init nu --config ~/Develop/dotfiles/ohmyposh_themes/ys.omp.json
}
