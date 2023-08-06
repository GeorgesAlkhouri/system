{ inputs, cell, }:

let
  inherit (inputs) std self cells;
  inherit (inputs.nixpkgs) system;

  pkgs = import inputs.nixpkgs { inherit system; };

  crane = inputs.crane.lib.overrideToolchain cells.repository.rust.toolchain;

  name = "experience";

  crateNameFromCargoToml = crane.crateNameFromCargoToml {
    cargoToml = "${self}/sources/${name}/Cargo.toml";
  };

  libraries = with pkgs; [
    alsa-lib
    udev
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
    openssl
    vulkan-loader
    wayland
    libxkbcommon
  ];

in {
  default = crane.buildPackage {
    inherit (crateNameFromCargoToml) pname version;

    nativeBuildInputs = with pkgs; [ cmake pkgconfig ] ++ libraries;

    src = std.incl self [
      "${self}/Cargo.lock"
      "${self}/Cargo.toml"
      "${self}/sources/${name}/Cargo.toml"
      "${self}/sources/${name}/src"
    ];
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
