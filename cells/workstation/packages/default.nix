{ inputs, cell }:

let
  inherit (inputs) haumea nixpkgs;

  l = inputs.nixpkgs.lib // builtins;

  sources = nixpkgs.callPackage ./_sources/generated.nix { };

in l.mapAttrs (_: v: nixpkgs.callPackage v { inherit sources cell inputs; })

(haumea.lib.load {
  src = ./packages;
  loader = haumea.lib.loaders.path;
})
