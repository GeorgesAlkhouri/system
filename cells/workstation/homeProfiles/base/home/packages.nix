{ inputs, cell }:

let
  languages = with inputs.nixpkgs; [
    nodePackages.typescript-language-server
    nil
    nixfmt
    nodePackages.yaml-language-server
    python310Packages.python-lsp-server
    vscode-langservers-extracted
    nodePackages.npm-check-updates
  ];

  system = with inputs.nixpkgs; [
    archi
    cachix
    dufs
    sd
    fclones
    filezilla
    firefox
    glxinfo
    gopass
    hakrawler
    httrack
    hub
    imagemagick
    jq
    k8sgpt
    lnav
    mupdf
    nix-init
    nurl
    p7zip
    sops
    sosreport
    ssh-to-age
    taplo
    tree-sitter
    watchexec
    wget
  ];

  packages = with cell.packages; [ goscrape tg-archive ];

  applications = with inputs.cells.experience.packages;
    [
      # wrapped 
    ];

in inputs.nixpkgs.lib.concatLists [ languages system packages applications ]

