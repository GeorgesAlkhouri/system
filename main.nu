#!/usr/bin/env nu

def main [command: string] {
  if ($command == "monitor") { monitor }
  if ($command == "rebuild") { rebuild }
}

export def monitor [] {
  cd ([$env.HOME "system"] | path join)
  watchexec --exts=nix nu main.nu rebuild
}

export def rebuild [] {
  let path = ([$env.HOME "system"] | path join)
  cd $path
  git add .
  sudo nixos-rebuild switch --impure --flake $"($path)#workstation-default" --show-trace
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
  cd ([$env.HOME "system"] | path join)

  open meta.yml
  | get documentation
  | transpose key val
  | each {|i| ($i | get val) | save --force ($i | get key)}

  cd $env.HOME
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
  ["repository" "workstation"] | each {|cell|
    cd ([$env.HOME "system" "nix" $cell "packages"] | path join)
    nvfetcher
  }
}

export def cluster [] {

# export CLUSTER_NAME=test && \
# k3d cluster create $CLUSTER_NAME --image=registry.gitlab.com/vainkop1/k3s-gpu:v1.21.2-k3s1 --gpus=all && \
# k3d kubeconfig write $CLUSTER_NAME && \
# export KUBECONFIG=$HOME/.k3d/kubeconfig-$CLUSTER_NAME.yaml


  # run-external "flux" "bootstrap" "github" "--components-extra=image-reflector-controller,image-automation-controller" $"--owner=($env.GITHUB_USER)" $"--repository=($env.GITHUB_REPO)" "--branch=main" "--path=./k8s/prod" "--personal" "--read-write-key"
}
