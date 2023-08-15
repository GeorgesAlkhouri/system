{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
  l = inputs.nixpkgs.lib // builtins;
  pkgs = import inputs.nixpkgs {
    inherit (inputs.nixpkgs) system;
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  };
  build = [ pkgs.cmake pkgs.gcc pkgs.gnumake pkgs.mold pkgs.pkgconfig ];
  runtime = [
    (pkgs.opencv4.override {
      enableGtk3 = true;
      enableFfmpeg = true;
      enableCuda = true;
      enableUnfree = true;
    })
    pkgs.blas
    pkgs.cmake
    pkgs.cudaPackages.cudatoolkit
    pkgs.cudaPackages.cudatoolkit.lib
    pkgs.cudaPackages.cudnn
    pkgs.cudatoolkit
    pkgs.freeglut
    pkgs.gcc
    pkgs.glib
    pkgs.glibc
    pkgs.glibc.out
    pkgs.gperf
    pkgs.libconfig
    pkgs.libGL
    pkgs.libGLU
    pkgs.libxkbcommon
    pkgs.linuxPackages.nvidia_x11
    pkgs.openssl
    pkgs.pkgconfig
    pkgs.procps
    pkgs.python3
    pkgs.stdenv.cc
    pkgs.stdenv.cc.cc
    pkgs.stdenv.cc.cc.lib
    pkgs.udev
    pkgs.xorg.libX11
    pkgs.xorg.libXext
    pkgs.xorg.libXi
    pkgs.xorg.libXmu
    pkgs.xorg.libXrandr
    pkgs.xorg.libXv
    pkgs.zlib
  ];
in {
  name = "cude environment";
  imports = [
    inputs.std.std.devshellProfiles.default
    "${inputs.std.inputs.devshell}/extra/language/rust.nix"
  ];
  packages = build ++ runtime;
  env = [
    {
      name = "DEVSHELL_NO_MOTD";
      value = "0";
    }
    {
      name = "CARGO_HOME";
      eval = "$PRJ_DATA_DIR/cargo";
    }
    {
      name = "RUSTUP_HOME";
      eval = "$PRJ_DATA_DIR/rustup";
    }
    {
      name = "RUST_SRC_PATH";
      value = "${cell.rust.toolchain}/lib/rustlib/src/rust/library";
    }
    {
      name = "PKG_CONFIG_PATH";
      value = l.makeSearchPathOutput "dev" "lib/pkgconfig" (build ++ runtime);
    }
    {
      name = "LD_LIBRARY_PATH";
      value = l.makeLibraryPath (build ++ runtime);
    }
    {
      name = "LIBTORCH";
      value = pkgs.symlinkJoin {
        name = "torch-join";
        paths = [ pkgs.libtorch-bin.dev pkgs.libtorch-bin.out ];
      };
    }
    {
      name = "NIX_LIBGCC_S_PATH";
      value = "${pkgs.stdenv.cc.cc.lib}/lib";
    }
    {
      name = "NIX_GLIBC_PATH";
      value = "${pkgs.glibc.out}/lib";
    }
    {
      name = "CUDA_PATH";
      value = pkgs.cudaPackages.cudatoolkit;
    }
    {
      name = "EXTRA_LDFLAGS";
      value = "-L${pkgs.linuxPackages.nvidia_x11}/lib";
    }
    {
      name = "EXTRA_CCFLAGS";
      value = "-I/usr/include";
    }
    {
      name = "RUSTFLAGS";
      value = "-C link-arg=-fuse-ld=mold";
    }
  ];
  nixago = [
    cell.configs.conform
    cell.configs.adrgen
    cell.configs.editorconfig
    cell.configs.lefthook
    cell.configs.treefmt
    cell.configs.githubsettings
  ];
  language = {
    rust = {
      packageSet = cell.rust;
      enableDefaultToolchain = true;
      tools = [ "toolchain" ];
    };
  };
  devshell.startup.link-cargo-home = {
    deps = [ ];
    text = ''
      mkdir -p $PRJ_DATA_DIR/cargo
      ln -snf -t $PRJ_DATA_DIR/cargo $(ls -d ${cell.rust.toolchain}/*)
    '';
  };
  commands = let
    rustCmds = l.map (name: {
      inherit name;
      package = cell.rust.toolchain;
      category = "rust dev";
      help = nixpkgs.${name}.meta.description;
    }) [ "rustc" "cargo" "rustfmt" "rust-analyzer" ];
  in [ ] ++ rustCmds;
}
