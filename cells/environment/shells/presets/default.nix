{ inputs, cell }:
let
  inherit (inputs) cells nixpkgs;
  l = inputs.nixpkgs.lib // builtins;
  pkgs = import inputs.nixpkgs { inherit (inputs.nixpkgs) system; };
  build = [ pkgs.cmake pkgs.gcc pkgs.gnumake pkgs.mold pkgs.pkgconfig ];
  runtime = [
    pkgs.alsa-lib
    pkgs.glibc
    pkgs.glibc.out
    pkgs.libtorch-bin
    pkgs.libxkbcommon
    pkgs.openblas
    pkgs.openssl
    pkgs.stdenv.cc
    pkgs.stdenv.cc.cc
    pkgs.stdenv.cc.cc.lib
    pkgs.udev
    pkgs.vulkan-loader
    pkgs.wayland
    pkgs.xorg.libX11
    pkgs.xorg.libXcursor
    pkgs.xorg.libXi
    pkgs.xorg.libXrandr
    pkgs.zlib
  ];
in {
  name = "environment";
  imports = [ inputs.std.std.devshellProfiles.default "${inputs.std.inputs.devshell}/extra/language/rust.nix" ];
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
      name = "RUSTFLAGS";
      value = "-C link-arg=-fuse-ld=mold";
    }
  ];
  nixago = [ cell.configs.conform cell.configs.adrgen cell.configs.editorconfig cell.configs.lefthook cell.configs.treefmt cell.configs.githubsettings ];
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
  in [
    {
      package = pkgs.nvfetcher;
      category = "general commands";
    }
    {
      package = cells.workstation.packages.terminusdb;
      category = "storage";
    }
    {
      category = "applications";
      name = "experience";
      command = "cargo run --manifest-path $PRJ_ROOT/sources/experience/Cargo.toml; ";
    }
    {
      category = "applications";
      name = "processor";
      command = "cargo run --manifest-path $PRJ_ROOT/sources/processor/Cargo.toml; ";
    }
    {
      category = "applications";
      name = "documentation";
      command = "trunk serve --open $PRJ_ROOT/sources/documentation/index.html ";
    }
    {
      category = "environments";
      name = "cuda-env";
      command = "nix develop .#cuda --command nu ";
    }
  ] ++ rustCmds;
}
