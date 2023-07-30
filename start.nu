def main [] {}

export def rebuild [] {
  watchexec --exts=nix git add .; git commit --amend; sudo nixos-rebuild switch --impure --flake .#host-default
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

export def contrib [] {

}