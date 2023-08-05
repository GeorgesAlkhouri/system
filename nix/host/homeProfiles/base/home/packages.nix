{ inputs, cell, ... }:
let
  language-servers = with inputs.nixpkgs; [
    alejandra
    archi
    cachix
    cachix
    cargo
    dufs
    dufs
    fclones
    filezilla
    k8sgpt
    firefox
    hub
    gopass
    hakrawler
    httrack
    imagemagick
    jq
    lnav
    mupdf
    nil
    nix-init
    nixfmt
    nixpkgs-fmt
    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
    nodePackages.npm-check-updates
    nurl
    p7zip
    python310Packages.python-lsp-server
    sops
    sosreport
    ssh-to-age
    taplo
    tree-sitter
    vscode-langservers-extracted
    watchexec
    wget
    yt-dlp
  ];
  system = with inputs.nixpkgs; [ glxinfo ];
  local = with cell.packages; [
    goscrape

    local-ai
    shell-gpt
    tg-archive

  ];
in inputs.nixpkgs.lib.concatLists [
  language-servers
  system
  local

]

