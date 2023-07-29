{
  outputs = inputs @ {...}:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} ({flake-parts-lib, ...}: let
      inherit (flake-parts-lib) importApply;
      flakeModules.hive = importApply ./hive-flake-module.nix {inherit (inputs) hive;};
    in {
      imports = [
        flakeModules.hive

        inputs.std.flakeModule
        inputs.treefmt-nix.flakeModule
        inputs.devenv.flakeModule
      ];
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      perSystem = {
        config,
        system,
        ...
      }: {
        treefmt.programs.alejandra.enable = true;
        treefmt.projectRootFile = ".git/config";
        devenv.shells.devenv = {
          pre-commit = {
            hooks = {
              shfmt.enable = true;
              shellcheck.enable = true;
              alejandra.enable = true;
              deadnix.enable = false;
              nil.enable = true;
              black.enable = true;
              commitizen.enable = true;
            };
          };
          packages = [
            config.treefmt.build.wrapper
            inputs.std.packages.${system}.std
            inputs.colmena.packages.${system}.colmena
            inputs.nvfetcher.packages.${system}.default
          ];
        };
      };
      std = {
        grow = {
          cellsFrom = ./nix;
          cellBlocks = with inputs.hive.blockTypes;
          with inputs.std.blockTypes; [
            nixosConfigurations
            homeConfigurations
            colmenaConfigurations
            (functions "homeProfiles")
            (functions "lib")
            (nixago "configs")
            (devshells "shells")
          ];
          nixpkgsConfig = {allowUnfree = true;};
        };
        harvest = {
          devShells = ["repo" "shells"];
          packages = ["repo" "packages"];
        };
      };
      hive.collect = [
        "nixosConfigurations"
        "homeConfigurations"
        "colmenaConfigurations"
      ];
      flake = {
        colmenaHive = inputs.hive.collect inputs.self "colmenaConfigurations";
        default = flakeModules.hive;
      };
    });

  inputs.flake-utils.url = "github:numtide/flake-utils";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs-unstable";

    nvfetcher.url = "github:berberman/nvfetcher";
    nvfetcher.inputs.nixpkgs.follows = "nixpkgs";
    nvfetcher.inputs.flake-utils.follows = "flake-utils";
  };

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    haumea.url = "github:nix-community/haumea";
    haumea.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit-hooks.inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    pre-commit-hooks.inputs.flake-utils.follows = "flake-utils";

    devenv.url = "github:cachix/devenv";
    devenv.inputs.pre-commit-hooks.follows = "pre-commit-hooks";
    devenv.inputs.nixpkgs.follows = "nixpkgs";

    std.url = "github:divnix/std";
    std.inputs.nixpkgs.follows = "nixpkgs";
    std.inputs.devshell.url = "github:numtide/devshell";
    std.inputs.nixago.url = "github:nix-community/nixago";

    colmena.url = "github:zhaofengli/colmena";
    colmena.inputs.flake-utils.follows = "flake-utils";

    hive.url = "github:divnix/hive";
    hive.inputs.nixpkgs.follows = "nixpkgs";
    hive.inputs.colmena.follows = "colmena";
    hive.inputs.disko.follows = "disko";

    home.url = "github:nix-community/home-manager";
    home.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:LnL7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nix2container.url = "github:nlewo/nix2container";
    nix2container.inputs.nixpkgs.follows = "nixpkgs";
    nix2container.inputs.flake-utils.follows = "flake-utils";

    mk-shell-bin.url = "github:rrbutani/nix-mk-shell-bin";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.inputs.nixpkgs-stable.follows = "nixpkgs-stable";
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
