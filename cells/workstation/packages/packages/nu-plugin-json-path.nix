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
    inherit (sources.nu_plugin_json_path) pname version src;
  }
