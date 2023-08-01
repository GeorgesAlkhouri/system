def main [command: string] {
  if ($command == "rebuild") {
    rebuild
  }
}

export def monitor [] {
  let path = "/home/nixos/system"
  cd $path
  let main = "/home/nixos/system/nix/host/presets/nushell/scripts/main"
  watchexec --exts=nix nu $main rebuild
}

export def rebuild [] {
  let path = "/home/nixos/system"
  cd $path
  git add .
  sudo nixos-rebuild switch --impure --flake "/home/nixos/system#host-default"
}

export def syntaxes [] {
  let path = "/home/nixos/.config/tree-sitter/syntaxes"
  mkdir $path
  open meta.yml | get syntaxes | par-each {|i|
    let name = ($i | url parse | get path | split column "/" | get column3 | to text)
    let dist = ([$path $name] | path join | str downcase)
    if ($dist | path exists) {
      cd $dist
      git pull
    } else {
      git clone $i $dist
    }
  }
}

export def contribution [] {
  let path = "/home/nixos/contribution"
  mkdir $path
  cd $path
  gh repo list cognitive-singularity --json url
  | from json
  | get url
  | par-each {|i|
    git clone $i ($i | url parse | get path | str downcase | split column "/" | get column3)
  }
}

export def generate [] {
  alias td = terminusdb
}
  
export def upload [message: string] {
  git add .
  git commit --message $message
  git push
}