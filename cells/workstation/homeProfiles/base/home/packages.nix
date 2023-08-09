{ inputs, cell }:

let
  inherit (inputs.nixpkgs) system;
  pkgs = import inputs.nixpkgs { inherit system; };

  packages = with cell.packages;
    with inputs.cells.experience.packages;
    with inputs.cells.repository.packages; [
      terminusdb
      goscrape
      tg-archive
      wgsl-analyzer
      # wrapped
    ];

  tools = with pkgs; [
    act
    ansible
    ansible-doctor
    ansible-lint
    archi
    awscli2
    binaryen
    cachix
    cargo-audit
    cargo-edit
    cargo-generate
    cargo-leptos
    cargo-nextest
    cargo-outdated
    cargo-spellcheck
    cargo-udeps
    cargo-watch
    cloudflared
    delve
    doctl
    dufs
    fclones
    fd
    fluxcd
    flyctl
    gnumake
    go
    onefetch
    go-outline
    gocode
    gocode-gomod
    godef
    golint
    gopass
    gopkgs
    gopls
    gotools
    hakrawler
    jq
    k2tf
    k3d
    k9s
    kargo
    kind
    kompose
    krew
    kube3d
    kubectl
    kubectx
    kubernetes
    kubernetes-helm
    kubeseal
    kubeval
    libreoffice-fresh
    lua-language-server
    minikube
    mupdf
    nfs-utils
    nil
    nixfmt
    nodePackages.npm-check-updates
    nodePackages.tailwindcss
    nodePackages.typescript-language-server
    nodePackages.wrangler
    nodePackages.yaml-language-server
    nodejs
    p7zip
    packer
    podman
    poetry
    python310
    python310Packages.python-lsp-server
    rsync
    sd
    sops
    sosreport
    sqlx-cli
    ssh-to-age
    stern
    taplo
    terraform
    terraform-docs
    terragrunt
    tree-sitter
    trunk
    vscode-langservers-extracted
    wasm-pack
    watchexec
    nvfetcher
    wget
    zarf
  ];

in pkgs.lib.concatLists [ packages tools ]

