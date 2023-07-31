{ inputs, ... }:
with inputs.nixpkgs; [
  cachix
  cargo
  dufs
  nil
  nixfmt
  nurl
  mupdf
  httrack
  fclones
  yt-dlp
  p7zip
  sops
  ssh-to-age
  tree-sitter
  watchexec
  wget
]
