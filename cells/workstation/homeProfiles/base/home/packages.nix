{ inputs }:
let
  inherit (inputs.nixpkgs) system;
  pkgs = import inputs.nixpkgs { inherit system; };
  packages = [
    # inputs.cells.workstation.packages.wgsl-analyzer
    # inputs.cells.workstation.packages.goscrape
    # inputs.cells.workstation.packages.pywebscrapbook
    # inputs.cells.workstation.packages.llama-cpp
    # inputs.cells.workstation.packages.terminusdb
    # inputs.cells.workstation.packages.terminusdb-semantic-indexer
    # inputs.cells.workstation.packages.tg-archive
    # inputs.cells.workstation.packages.whisper-cpp
    inputs.cells.workstation.packages.tortoise-tts
    pkgs.cachix
    pkgs.ffmpeg
    pkgs.nickel
    pkgs.nix-init
    pkgs.nvfetcher
    pkgs.tesseract
    pkgs.tree-sitter
    pkgs.typst
    pkgs.trunk
    pkgs.watchexec
    pkgs.wget
  ];
in pkgs.lib.concatLists [ packages ]
