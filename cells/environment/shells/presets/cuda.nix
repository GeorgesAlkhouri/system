{ inputs, cell, }:

let
  l = inputs.nixpkgs.lib // builtins;

  pkgs = import inputs.nixpkgs {
    inherit (inputs.nixpkgs) system;

    config = { allowUnfree = true; };
  };

  packages = with pkgs; [
    alsa-lib
    autoconf
    binutils
    blas
    cmake
    cudaPackages.cudnn
    cudatoolkit
    curl
    file
    freeglut
    gcc
    glib
    gnumake
    gnupg
    gperf
    libconfig
    libGL
    libGLU
    libxkbcommon
    linuxPackages.nvidia_x11
    m4
    mold
    ncurses5
    openssl
    pciutils
    pkgconfig
    procps
    protobuf
    stdenv.cc
    stdenv.cc.cc
    stdenv.cc.cc.lib
    udev
    unzip
    util-linux
    vulkan-headers
    vulkan-loader
    wayland
    xorg.libX11
    xorg.libXcursor
    xorg.libXext
    xorg.libXi
    xorg.libXmu
    xorg.libXrandr
    xorg.libXv
    zlib
    (opencv4.override {
      enableGtk3 = true;
      enableFfmpeg = true;
      enableCuda = true;
      enableUnfree = true;
    })
  ];

  PKG_CONFIG_PATH = l.makeSearchPathOutput "dev" "lib/pkgconfig" packages;

  LD_LIBRARY_PATH = l.makeLibraryPath packages;

  CUDA_PATH = pkgs.cudatoolkit;

  EXTRA_LDFLAGS = "-L${pkgs.linuxPackages.nvidia_x11}/lib";

in {
  inherit packages;

  name = "cuda";

  env = [
    {
      name = "PKG_CONFIG_PATH";
      value = PKG_CONFIG_PATH;
    }
    {
      name = "LD_LIBRARY_PATH";
      value = LD_LIBRARY_PATH;
    }
    {
      name = "CUDA_PATH";
      value = CUDA_PATH;
    }
    {
      name = "EXTRA_LDFLAGS";
      value = EXTRA_LDFLAGS;
    }
    {
      name = "RUSTFLAGS";
      value = "-C link-arg=-fuse-ld=mold";
    }
  ];

  commands = [ ];
}
