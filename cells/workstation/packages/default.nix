{ inputs, cell }:
let
  inherit (inputs) haumea;
  l = inputs.nixpkgs.lib // builtins;
  pkgs = import inputs.nixpkgs {
    inherit (inputs.nixpkgs) system;
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  };
  sources = pkgs.callPackage ./_sources/generated.nix { };
in l.mapAttrs (_: v: pkgs.callPackage v { inherit sources cell inputs; })
(haumea.lib.load {
  src = ./packages;
  loader = haumea.lib.loaders.path;
})
