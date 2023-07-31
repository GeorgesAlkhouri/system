{ inputs, ... }:
with inputs.nixpkgs; [
  cachix
  cargo
  dufs
  nil
  nixfmt
  nurl
  p7zip
  sops
  ssh-to-age
  tree-sitter
  watchexec
  wget
]
