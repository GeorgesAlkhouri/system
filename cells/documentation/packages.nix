{ inputs, cell, }:
let
  inherit (inputs) std self cells;
  inherit (inputs.nixpkgs) system;

  name = "documentation";

  pkgs = import inputs.nixpkgs { inherit system; };

  libraries = with pkgs; [ openssl ];

  crane = inputs.crane.lib.overrideToolchain cells.environment.rust.toolchain;

  crateNameFromCargoToml = crane.crateNameFromCargoToml {
    cargoToml = "${self}/sources/${name}/Cargo.toml";
  };
in {
  default = crane.buildPackage {
    inherit (crateNameFromCargoToml) pname version;

    nativeBuildInputs = with pkgs; [ cmake pkg-config ] ++ libraries;

    src = crane.cleanCargoSource (crane.path "${self}/sources/${name}");
  };
}
