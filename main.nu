#!/usr/bin/env nu

def main [command: string] {
  if ($command == "rebuild") {
    rebuild
  }
}

export def monitor [] {
  cd ([$env.HOME "system"] | path join)
  watchexec --exts=nix nu main.nu rebuild
}

export def rebuild [] {
  let path = ([$env.HOME "system"] | path join)
  cd $path
  git add .
  sudo nixos-rebuild switch --impure --flake $"($path)#host-default" --show-trace
}

export def upload [message: string] {
  cd ([$env.HOME "system"] | path join)
  git add .
  git commit --message $message
  git push
}

export def review [path: string, type = all] {
  cd $path
  rg --files --sort path --type $type --hidden | lines | hx $in
}

export def generate [] {
  alias td = terminusdb
  cd $env.HOME
}
