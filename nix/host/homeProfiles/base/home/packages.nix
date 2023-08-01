{ inputs, ... }:
with inputs.nixpkgs; [
  cachix
  cargo
  dufs
  fclones
  hakrawler
  mupdf
  nil
  nixfmt
  nurl
  p7zip
  firefox
  sops
  ssh-to-age
  tree-sitter
  watchexec
  wget
  yt-dlp
]
