{ inputs, cell, }:

let
  inherit (inputs.std) lib;

  l = inputs.nixpkgs.lib // builtins;

in l.mapAttrs (_: lib.dev.mkShell) {
  default = import ./presets/default.nix { inherit cell inputs; };
  cuda = import ./presets/cuda.nix { inherit cell inputs; };
}
