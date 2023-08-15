{ sources, inputs, system, ... }:
let
  craneLib = inputs.crane.lib.${system}.overrideToolchain
    inputs.fenix.packages.${system}.minimal.toolchain;
in craneLib.buildPackage {
  inherit (sources.nu_plugin_from_parquet) pname version src;
}
