{ sources, inputs, system, ... }:
let
  craneLib = inputs.crane.lib.${system}.overrideToolchain
    inputs.fenix.packages.${system}.minimal.toolchain;
in craneLib.buildPackage {
  inherit (sources.nushell) pname version src;
  buildInputs = with inputs.nixpkgs; [ pkg-config openssl ];
  cargoExtraArgs = "-p nu_plugin_gstat";
}
