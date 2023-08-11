{
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; }

    ({ flake-parts-lib, ... }:
      let
        inherit (flake-parts-lib) importApply;

        flakeModules.hive =
          importApply ./hive-flake-module.nix { inherit (inputs) hive; };
      in {
        debug = true;

        imports = [ inputs.std.flakeModule flakeModules.hive ];

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

            packages = [
              [ "documentation" "packages" ]
              [ "experience" "packages" ]
              [ "environment" "packages" ]
              [ "workstation" "packages" ]
            ];
          };
        };
        hive.collect = [ "nixosConfigurations" "homeConfigurations" ];

        flake = {
          colmenaHive = inputs.hive.collect inputs.self "colmenaConfigurations";
          default = flakeModules.hive;
        };
      });

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-fork.url = "github:cognitive-singularity/nixpkgs";
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
    home.url = "github:nix-community/home-manager";
    home-stable.url = "github:nix-community/home-manager/release-23.05";
    home-fork.url = "github:cognitive-singularity/home-manager";
    home.inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs = {
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs-unstable";

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

    helix.url = "github:helix-editor/helix";
    helix.inputs.nixpkgs.follows = "nixpkgs";

    nix-std.url = "github:chessai/nix-std";
  };

  inputs = {
    nickel-nix.url = "github:nickel-lang/nickel-nix";

    tf-ncl.url = "github:tweag/tf-ncl";
    tf-ncl.inputs.nixpkgs.follows = "nixpkgs";
    tf-ncl.inputs.topiary.follows = "";
    nickel.follows = "tf-ncl/nickel";

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
      "https://nickel-nix.cachix.org"
      "https://cognitive-singularity.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nickel-nix.cachix.org-1:/Ziozgt3g0CfGwGS795wyjRa9ArE89s3tbz31S6xxFM="
      "cognitive-singularity.cachix.org-1:grkAm+geNEakMShqNnEnVsEbK3m4reSNpPf8Rxza3Xw="
    ];
  };
}
