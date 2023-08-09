{ inputs, cell, }:

let
  inherit (inputs) self cells;
  inherit (inputs.nixpkgs) system;

  pkgs = import inputs.nixpkgs { inherit system; };

  crane = inputs.crane.lib.overrideToolchain cells.repository.rust.toolchain;

  name = "experience";

  crateNameFromCargoToml = crane.crateNameFromCargoToml {
    cargoToml = "${self}/sources/${name}/Cargo.toml";
  };

  libraries = with pkgs; [
    alsa-lib
    libxkbcommon
    udev
    vulkan-loader
    wayland
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
  ];

in {
  default = crane.buildPackage {
    inherit (crateNameFromCargoToml) pname version;

    nativeBuildInputs = with pkgs; [ cmake pkg-config ] ++ libraries;

    src = crane.cleanCargoSource (crane.path "${self}/sources/${name}");
  };

  wrapped = pkgs.symlinkJoin {
    inherit name;

    paths = [ cell.packages.default ];

    buildInputs = [ pkgs.makeWrapper ];

    postBuild = ''
      wrapProgram $out/bin/experience \
        --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath libraries}"
    '';
  };
}
