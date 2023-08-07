{ inputs, cell, }:

let
  inherit (inputs) cells;
  inherit (inputs.std) lib;

  l = inputs.nixpkgs.lib // builtins;

  pkgs = inputs.nixpkgs.appendOverlays [ ];

  libraries = with pkgs; [
    alsa-lib
    libclang.lib
    libxkbcommon
    openssl
    protobuf
    udev
    vulkan-loader
    wayland
    wayland-protocols
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
  ];

  LIBTORCH = with pkgs;
    symlinkJoin {
      name = "torch-join";
      paths = [ libtorch-bin.dev libtorch-bin.out ];
    };

  LD_LIBRARY_PATH = l.makeLibraryPath libraries;

  PKG_CONFIG_PATH = l.makeSearchPathOutput "dev" "lib/pkgconfig" libraries;

  MOLD_PATH = "${pkgs.mold.out}/bin/mold";

  NIX_PATH = "nixpkgs=" + pkgs.path;

  RUSTC_WRAPPER = "${pkgs.sccache}/bin/sccache";

  PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";

  RUSTFLAGS = inputs.nix-std.lib.string.concatSep " " [
    "-Clink-arg=-fuse-ld=${MOLD_PATH}"
    "-Clinker=${pkgs.llvmPackages_latest.clang}/bin/clang"
    "-Zshare-generics=y"
  ];

  SHADERC_LIBRARY_PATH = "${pkgs.shaderc.lib}/lib";

in l.mapAttrs (_: inputs.std.lib.dev.mkShell) {
  default = {
    name = "devshell";

    packages = with pkgs; [ pkg-config ];

    language.rust = {
      packageSet = cell.rust;
      enableDefaultToolchain = false;
      tools = [ "toolchain" ];
    };

    devshell.startup.link-cargo-home = {
      deps = [ ];
      text = ''
        mkdir -p $PRJ_DATA_DIR/cargo
        ln -snf -t $PRJ_DATA_DIR/cargo $(ls -d ${cell.rust.toolchain}/*)
      '';
    };

    env = [
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
        name = "RUST_BACKTRACE";
        value = "1";
      }
      {
        name = "LD_LIBRARY_PATH";
        value = LD_LIBRARY_PATH;
      }
      {
        name = "PKG_CONFIG_PATH";
        value = PKG_CONFIG_PATH;
      }
      {
        name = "PKG_CONFIG_SYSROOT_DIR";
        value = "/";
      }
      {
        name = "LIBTORCH";
        value = LIBTORCH;
      }
      {
        name = "RUSTC_WRAPPER";
        value = RUSTC_WRAPPER;
      }
      {
        name = "NIX_PATH";
        value = NIX_PATH;
      }
      {
        name = "PLAYWRIGHT_BROWSERS_PATH";
        value = PLAYWRIGHT_BROWSERS_PATH;
      }
      {
        name = "PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD";
        value = "1";
      }
      {
        name = "MOLD_PATH";
        value = MOLD_PATH;
      }
      {
        name = "RUSTFLAGS";
        value = RUSTFLAGS;
      }
      {
        name = "SHADERC_LIBRARY_PATH";
        value = SHADERC_LIBRARY_PATH;
      }
    ];

    imports = [
      inputs.std.std.devshellProfiles.default

      "${inputs.std.inputs.devshell}/extra/language/c.nix"
      "${inputs.std.inputs.devshell}/extra/language/rust.nix"
      "${inputs.std.inputs.devshell}/extra/language/go.nix"
    ];

    nixago = [
      ((lib.dev.mkNixago lib.cfg.conform) {
        data = { inherit (inputs) cells; };
      })
      ((lib.dev.mkNixago lib.cfg.treefmt) cell.configs.treefmt)
      ((lib.dev.mkNixago lib.cfg.editorconfig) cell.configs.editorconfig)
      (lib.dev.mkNixago lib.cfg.lefthook)
    ];

    commands = let
      rustCmds = l.map (name: {
        inherit name;
        package = cell.rust.toolchain;
        category = "rust";
        help = pkgs.${name}.meta.description;
      }) [ "rustc" "cargo" "rustfmt" "rust-analyzer" ];
    in [
      {
        package = pkgs.nvfetcher;
        category = "repository";
      }
      {
        package = cells.workstation.packages.terminusdb;
        category = "storage";
      }
      {
        package = pkgs.mdbook;
        category = "documentation";
      }
      {
        package = pkgs.kubectl;
        category = "cluster";
      }
      {
        package = pkgs.kubectx;
        category = "cluster";
      }
      {
        package = pkgs.kubernetes-helm;
        category = "cluster";
      }
      {
        package = pkgs.terraform;
        category = "infrastructure";
      }
      {
        package = pkgs.fluxcd;
        category = "cluster";
      }
      {
        category = "rust";
        name = "udeps";
        command = "cargo udeps";
        help = pkgs.cargo-udeps.meta.description;
      }
      {
        category = "rust";
        name = "outdated";
        command = "cargo-outdated outdated";
        help = pkgs.cargo-outdated.meta.description;
      }
      {
        category = "rust";
        name = "audit";
        command = "cargo-audit audit";
        help = pkgs.cargo-audit.meta.description;
      }
      {
        category = "development";
        name = "experience";
        command =
          "cargo run --bin experience --manifest-path $PRJ_ROOT/sources/experience/Cargo.toml";
      }
      {
        category = "development";
        name = "documentation";
        command = ''
          RUSTFLAGS=""
          LD_LIBRARY_PATH=""
          trunk serve --open $PRJ_ROOT/sources/documentation/index.html
        '';
      }

    ] ++ rustCmds;
  };
}
