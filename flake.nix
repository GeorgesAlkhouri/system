{
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } ({ flake-parts-lib, ... }:
      let flakeModules.hive = flake-parts-lib.importApply ./hive-flake-module.nix { inherit (inputs) hive; };
      in {
        imports = [ inputs.std.flakeModule inputs.hercules-ci-effects.flakeModule flakeModules.hive ];
        systems = import inputs.systems;
        perSystem = { config, system, ... }: { };
        std = {
          grow = {
            cellsFrom = ./cells;
            cellBlocks = with inputs.hive.blockTypes;
              with inputs.std.blockTypes; [
                nixosConfigurations
                homeConfigurations
                colmenaConfigurations
                (functions "nixosProfiles")
                (functions "homeProfiles")
                (functions "lib")
                (runnables "entrypoints")
                (installables "packages")
                (nixago "configs")
                (devshells "shells")
                (pkgs "rust")
              ];
          };
          harvest = {
            devShells = [[ "environment" "shells" ]];
            packages = [ [ "documentation" "packages" ] [ "experience" "packages" ] [ "environment" "packages" ] [ "workstation" "packages" ] ];
          };
        };
        hive.collect = [ "nixosConfigurations" "homeConfigurations" ];
        flake = {
          colmenaHive = inputs.hive.collect inputs.self "colmenaConfigurations";
          default = flakeModules.hive;
        };
      });
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-fork.url = "github:cognitive-singularity/nixpkgs";
    nixpkgs-unfree.url = "github:numtide/nixpkgs-unfree";
    nixpkgs-unfree.inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs = {
    std.url = "github:divnix/std";
    std.inputs.nixpkgs.follows = "nixpkgs";
    std.inputs.devshell.follows = "devshell";
    std.inputs.nixago.follows = "nixago";
    std.inputs.devshell.url = "github:numtide/devshell";
    std.inputs.nixago.url = "github:nix-community/nixago";
    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    nixago.url = "github:nix-community/nixago";
    nixago.inputs.nixpkgs.follows = "nixpkgs";
    nixago.inputs.nixago-exts.follows = "";
    hive.url = "github:divnix/hive";
    hive.inputs.nixpkgs.follows = "nixpkgs";
    hive.inputs.colmena.follows = "colmena";
    hive.inputs.disko.follows = "disko";
  };
  inputs = {
    crane.url = "github:ipetkov/crane";
    crane.inputs.nixpkgs.follows = "nixpkgs";
    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager-unstable.url = "github:nix-community/home-manager";
    home-manager-stable.url = "github:nix-community/home-manager/release-23.05";
    home-manager-fork.url = "github:cognitive-singularity/home-manager";
  };
  inputs = {
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nvfetcher.url = "github:berberman/nvfetcher";
    nvfetcher.inputs.nixpkgs.follows = "nixpkgs";
    nvfetcher.inputs.flake-utils.follows = "flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    haumea.url = "github:nix-community/haumea";
    haumea.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit-hooks.inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    pre-commit-hooks.inputs.flake-utils.follows = "flake-utils";
    hercules-ci-effects.url = "github:hercules-ci/hercules-ci-effects";
    hercules-ci-effects.inputs.nixpkgs.follows = "nixpkgs";
    devenv.url = "github:cachix/devenv";
    devenv.inputs.pre-commit-hooks.follows = "pre-commit-hooks";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
    colmena.url = "github:zhaofengli/colmena";
    colmena.inputs.flake-utils.follows = "flake-utils";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    nix2container.url = "github:nlewo/nix2container";
    nix2container.inputs.nixpkgs.follows = "nixpkgs";
    nix2container.inputs.flake-utils.follows = "flake-utils";
    mk-shell-bin.url = "github:rrbutani/nix-mk-shell-bin";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    systems.url = "github:nix-systems/x86_64-linux";
    dream2nix.url = "github:nix-community/dream2nix";
    dream2nix.inputs.nixpkgs.follows = "nixpkgs";
    poetry2nix.url = "github:nix-community/poetry2nix";
    poetry2nix.inputs.nixpkgs.follows = "nixpkgs";
    nix-init.url = "github:nix-community/nix-init";
    nix-init.inputs.nixpkgs.follows = "nixpkgs";
    advisory-db.url = "github:rustsec/advisory-db";
    advisory-db.flake = false;
    nix-std.url = "github:chessai/nix-std";
    helix.url = "github:helix-editor/helix";
    helix.inputs.nixpkgs.follows = "nixpkgs";
    llama-cpp.url = "github:ggerganov/llama.cpp";
    llama-cpp.inputs.nixpkgs.follows = "nixpkgs";
    typst.url = "github:typst/typst";
    typst.inputs.nixpkgs.follows = "nixpkgs";
    typst-lsp.url = "github:nvarner/typst-lsp";
    typst-lsp.inputs.nixpkgs.follows = "nixpkgs";
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
    rust-overlay.inputs.flake-utils.follows = "flake-utils";
    nickel.url = "github:tweag/nickel";
    nickel.inputs.nixpkgs.follows = "nixpkgs";
    nickel.inputs.rust-overlay.follows = "rust-overlay";
    nickel.inputs.flake-utils.follows = "flake-utils";
    nil.url = "github:oxalica/nil";
    nil.inputs.nixpkgs.follows = "nixpkgs";
    nil.inputs.rust-overlay.follows = "rust-overlay";
    nil.inputs.flake-utils.follows = "flake-utils";
    topiary.url = "github:tweag/topiary";
    topiary.inputs.nixpkgs.follows = "nixpkgs";
    nixd.url = "github:nix-community/nixd";
    nixd.inputs.nixpkgs.follows = "nixpkgs";
    ml-pkgs.url = "github:nixvital/ml-pkgs";
    ml-pkgs.inputs.nixpkgs.follows = "nixpkgs";
    ml-pkgs.inputs.utils.follows = "flake-utils";
  };
  inputs = {
    nickel-nix.url = "github:nickel-lang/nickel-nix";
    tf-ncl.url = "github:tweag/tf-ncl";
    tf-ncl.inputs.nixpkgs.follows = "nixpkgs";
    terranix.url = "github:terranix/terranix";
    terranix.inputs.nixpkgs.follows = "nixpkgs";
    terranix.inputs.terranix-examples.follows = "";
    terraform-providers.url = "github:numtide/nixpkgs-terraform-providers-bin";
    terraform-providers.inputs.nixpkgs.follows = "nixpkgs";
    kubenix.url = "github:hall/kubenix";
  };
  nixConfig = {
    extra-experimental-features = "nix-command flakes";
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://ai.cachix.org"
      "https://numtide.cachix.org"
      "https://nickel-nix.cachix.org"
      "https://cache.divnix.com"
      "https://helix.cachix.org"
      "https://cognitive-singularity.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      "nickel-nix.cachix.org-1:/Ziozgt3g0CfGwGS795wyjRa9ArE89s3tbz31S6xxFM="
      "cache.divnix.com:sx7ojBrBUtdNmAMzNhiucTX+pqLzNTs4ISNb5qhh5OI="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "cognitive-singularity.cachix.org-1:grkAm+geNEakMShqNnEnVsEbK3m4reSNpPf8Rxza3Xw="
    ];
  };
}
