{ inputs, cell, }:

let
  inherit (inputs) cells nixpkgs;

  l = inputs.nixpkgs.lib // builtins;

  pkgs = import inputs.nixpkgs { inherit (inputs.nixpkgs) system; };

  build = with pkgs; [ cmake gcc gnumake mold pkgconfig ];

  runtime = with pkgs; [
    alsa-lib
    glibc
    glibc.out
    libtorch-bin
    libxkbcommon
    openblas
    openssl
    stdenv.cc
    stdenv.cc.cc
    stdenv.cc.cc.lib
    udev
    vulkan-loader
    wayland
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
    zlib
  ];

  packages = build ++ runtime;

  PKG_CONFIG_PATH = l.makeSearchPathOutput "dev" "lib/pkgconfig" packages;

  LD_LIBRARY_PATH = l.makeLibraryPath packages;

  LIBTORCH = with pkgs;
    symlinkJoin {
      name = "torch-join";
      paths = [ libtorch-bin.dev libtorch-bin.out ];
    };

  NIX_LIBGCC_S_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";

  NIX_GLIBC_PATH = "${pkgs.glibc.out}/lib";

in {
  inherit packages;

  name = "devshell";

  motd = l.mkForce ''
    Entered development environment.
  '';

  imports = [
    inputs.std.std.devshellProfiles.default
    "${inputs.std.inputs.devshell}/extra/language/rust.nix"
  ];

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
      value = PKG_CONFIG_PATH;
    }
    {
      name = "LD_LIBRARY_PATH";
      value = LD_LIBRARY_PATH;
    }
    {
      name = "LIBTORCH";
      value = LIBTORCH;
    }
    {
      name = "NIX_LIBGCC_S_PATH";
      value = NIX_LIBGCC_S_PATH;
    }
    {
      name = "NIX_GLIBC_PATH";
      value = NIX_GLIBC_PATH;
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
      command = ''
        cargo run --manifest-path $PRJ_ROOT/sources/experience/Cargo.toml;
      '';
    }
    {
      category = "applications";
      name = "processor";
      command = ''
        cargo run --manifest-path $PRJ_ROOT/sources/processor/Cargo.toml;
      '';
    }
    {
      category = "applications";
      name = "documentation";
      command = ''
        trunk serve --open $PRJ_ROOT/sources/documentation/index.html
      '';
    }
    {
      category = "environments";
      name = "cuda-env";
      command = ''
        nix develop .#cuda --command nu
      '';
    }
  ] ++ rustCmds;
}
