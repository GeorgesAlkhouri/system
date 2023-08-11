{ inputs, cell, }:
let
  inherit (inputs.std) std;
  inherit (inputs) nixpkgs;
  inherit (inputs) cells;

  l = inputs.nixpkgs.lib // builtins;

  pkgs = inputs.nixpkgs.appendOverlays [ ];

  build = with pkgs; [ pkgconfig mold gcc ];

  runtime = with pkgs; [
    alsa-lib
    libtorch-bin
    libxkbcommon
    openssl
    stdenv.cc.cc
    udev
    vulkan-loader
    wayland
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
  ];

  packages = build ++ runtime;

  PKG_CONFIG_PATH = l.makeSearchPathOutput "dev" "lib/pkgconfig" packages;

  LD_LIBRARY_PATH = l.makeLibraryPath packages;

  LIBTORCH = with pkgs;
    symlinkJoin {
      name = "torch-join";
      paths = [ libtorch-bin.dev libtorch-bin.out ];
    };

in {
  inherit packages;

  name = "devshell";

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
      name = "env-cuda";
      command = ''
        nix develop .#cuda --command nu
      '';
    }
  ] ++ rustCmds;
}
