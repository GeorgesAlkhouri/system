{ inputs }:
let
  inherit (inputs.nixpkgs) system;
  pkgs = import inputs.nixpkgs { inherit system; };
  packages = [
    inputs.cells.environment.packages.wgsl-analyzer
    inputs.cells.workstation.packages.goscrape
    inputs.cells.workstation.packages.pywebscrapbook
    inputs.cells.workstation.packages.llama-cpp
    inputs.cells.workstation.packages.terminusdb
    inputs.cells.workstation.packages.terminusdb-semantic-indexer
    inputs.cells.workstation.packages.tg-archive
    inputs.cells.workstation.packages.whisper-cpp
    pkgs.cachix
    pkgs.ffmpeg
    pkgs.nickel
    pkgs.nil
    pkgs.nixfmt
    pkgs.nls
    pkgs.nix-init
    pkgs.nvfetcher
    pkgs.taplo
    pkgs.tesseract
    pkgs.topiary
    pkgs.tree-sitter
    pkgs.typst
    pkgs.trunk
    pkgs.watchexec
    pkgs.wget
  ];
in pkgs.lib.concatLists [ packages ]
