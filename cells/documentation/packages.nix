{ inputs, cell }:
let
  inherit (inputs) self cells;
  inherit (inputs.nixpkgs) system;
  name = "documentation";
  pkgs = import inputs.nixpkgs { inherit system; };
  crane = inputs.crane.lib.overrideToolchain cells.environment.rust.toolchain;
  crateNameFromCargoToml = crane.crateNameFromCargoToml {
    cargoToml = "${self}/sources/${name}/Cargo.toml";
  };
  build = [ pkgs.cmake pkgs.pkgconfig ];
  runtime = [ pkgs.openssl ];
in {
  default = crane.buildPackage {
    inherit (crateNameFromCargoToml) pname version;
    nativeBuildInputs = build ++ runtime;
    src = crane.cleanCargoSource (crane.path "${self}/sources/${name}");
  };
}
