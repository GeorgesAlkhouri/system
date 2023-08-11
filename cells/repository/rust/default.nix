{
  inputs,
  cell,
}: let
  inherit (inputs) fenix;

  rustPkgs = builtins.removeAttrs fenix.packages.latest [
    "withComponents"
    "name"
    "type"
  ];
in
  rustPkgs
  // {
    inherit (fenix.packages) rust-analyzer;
    toolchain = fenix.packages.combine [
      (builtins.attrValues rustPkgs)
      fenix.packages.rust-analyzer
      fenix.packages.targets.wasm32-unknown-unknown.latest.rust-std
    ];
  }
