use /home/nixos/system/start.nu *
use /home/nixos/system/configs/nushell/scripts/archive.nu *
use /home/nixos/system/configs/nushell/scripts/dependencies.nu *
use /home/nixos/system/configs/nushell/scripts/processing.nu *


let external_completer = {|spans| 
  {
    $spans.0: { }
    std: { std _carapace nushell $spans | from json }
  } | get $spans.0 | each {|it| do $it}
}

$env.config = {
  show_banner: false

  ls: {
    use_ls_colors: true
    clickable_links: true
  }

  rm: {
    always_trash: true
  }

  cd: {
    abbreviations: false
  }

  table: {
    mode: none

    index_mode: always

    show_empty: true

    trim: {
      methodology: wrapping
      wrapping_try_keep_words: true
    }
  }

  hooks: {
    pre_prompt: [{ ||
      let direnv = (direnv export json | from json)
      let direnv = if ($direnv | length) == 1 { $direnv } else { {} }
      $direnv | load-env
    }]
  }

  completions: {
    external: {
      enable: true
      completer: $external_completer
    }
  }
}