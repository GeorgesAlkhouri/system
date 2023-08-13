#!/usr/bin/env nu

def main [command = "monitor"] {
  if ($command == "monitor") { monitor }
  if ($command == "rebuild") { rebuild }
}

export def monitor [] {
  cd ([$env.HOME "system"] | path join)
  watchexec --exts=nix nu start.nu rebuild
}

export def rebuild [] {
  let path = ([$env.HOME "system"] | path join)

  cd $path
  git add .

  sudo nixos-rebuild switch --impure --flake $"($path)#workstation-default" --show-trace
}

export def check [] {
  cd ([$env.HOME "system"] | path join)

  nix flake check --show-trace
  nix develop --no-update-lock-file --command treefmt
}

export def upload [message: string] {
  cd ([$env.HOME "system"] | path join)

  git add .
  git commit --message $message
  git push
}

export def cache [] {
  cd ([$env.HOME "system"] | path join)

  nix flake archive --json
  | jq -r '.path,(.inputs|to_entries[].value.path)'
  | cachix push cognitive-singularity

  nix build --json
  | jq -r '.[].outputs | to_entries[].value'
  | cachix push cognitive-singularity

  nix develop --profile default -c "true"
  cachix push cognitive-singularity default
}

export def refetch [] {
  ["workstation" "environment"] | each {|cell|
    cd ([$env.HOME "system" "cells" $cell "packages"] | path join)
    nvfetcher
  }
}

export def cleanup [] {
  rm -fr ~/.local/share/Trash/*
  nix-collect-garbage -d
  sudo nix-collect-garbage -d
}