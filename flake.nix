{
  outputs = {
    self,
    std,
    ...
  } @ inputs: let
    nixpkgsConfig = {
      allowUnfree = true;
    };
  in
    std.growOn {
      inherit inputs nixpkgsConfig;
      cellsFrom = ./nix;
      cellBlocks = [
        (std.blockTypes.nixago "configs")
        (std.blockTypes.devshells "shells")
      ];
    }
    {
      devShells = std.harvest self ["repo" "shells"];
      packages = std.harvest self ["repo" "packages"];
    };
  inputs = {
    std.url = "github:divnix/std";
    std.inputs.devshell.url = "github:numtide/devshell";
    std.inputs.nixago.url = "github:nix-community/nixago";
    nixpkgs.follows = "std/nixpkgs";
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
