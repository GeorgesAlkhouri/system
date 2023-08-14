{ inputs, cell }:
let
  inherit (inputs) self cells;
  inherit (inputs.nixpkgs) system;
  name = "experience";
  pkgs = import inputs.nixpkgs { inherit system; };
  crane = inputs.crane.lib.overrideToolchain cells.environment.rust.toolchain;
  crateNameFromCargoToml = crane.crateNameFromCargoToml { cargoToml = "${self}/sources/${name}/Cargo.toml"; };
  dependencies = [
    pkgs.alsa-lib
    pkgs.cmake
    pkgs.libxkbcommon
    pkgs.pkg-config
    pkgs.udev
    pkgs.vulkan-loader
    pkgs.wayland
    pkgs.xorg.libX11
    pkgs.xorg.libXcursor
    pkgs.xorg.libXi
    pkgs.xorg.libXrandr
  ];
in {
  default = crane.buildPackage {
    inherit (crateNameFromCargoToml) pname version;
    nativeBuildInputs = dependencies;
    src = crane.cleanCargoSource (crane.path "${self}/sources/${name}");
  };
  wrapped = pkgs.symlinkJoin {
    inherit name;
    paths = [ cell.packages.default ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/experience --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath dependencies}"
    '';
  };
}
