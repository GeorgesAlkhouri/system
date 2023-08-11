{
  sources,
  inputs,
  system,
  ...
}: let
  craneLib =
    inputs.crane.lib.${system}.overrideToolchain
    inputs.fenix.packages.${system}.minimal.toolchain;
in
  craneLib.buildPackage {
    inherit (sources.terminusdb-semantic-indexer) pname version src;

    buildInputs = with inputs.nixpkgs; [pkg-config openssl];
  }
