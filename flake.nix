{
  description = "Cognitive Singularity";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    std = {
      url = "github:divnix/std/release/0.23";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    incl = {
      url = "github:divnix/incl";
      inputs.nixlib.follows = "std/dmerge/haumea/nixpkgs";
    };
  };

  outputs = {
    self,
    std,
    incl,
    ...
  } @ inputs: let
    nixpkgsConfig = {
      allowUnfree = true;
    };
  in
    std.growOn {
      inherit inputs nixpkgsConfig;
      cellsFrom = incl ./nix ["repo"];
      cellBlocks = [
        (std.blockTypes.nixago "configs")
        (std.blockTypes.devshells "shells")
      ];
    }
    {
      devShells = std.harvest self ["repo" "shells"];
      packages = std.harvest self ["repo" "packages"];
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
