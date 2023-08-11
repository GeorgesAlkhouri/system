{
  inputs,
  cell,
}: let
  inherit (inputs.std) std;
  inherit (inputs) nixpkgs;
  inherit (inputs) cells;

  l = inputs.nixpkgs.lib // builtins;
  # pkgs = inputs.nixpkgs.appendOverlays [ ];

  pkgs = import inputs.nixpkgs {
    inherit (inputs.nixpkgs) system;

    config = {allowUnfree = true;};
  };

  build-deps = with pkgs; [pkgconfig mold gcc];
  runtime-deps = with pkgs; [
    (opencv4.override {
      enableGtk3 = true;
      enableFfmpeg = true;
      enableCuda = true;
      enableUnfree = true;
    })
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
    libtorch-bin
    linuxPackages.nvidia_x11
    m4
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
    xorg.libX11
    xorg.libXcursor
    xorg.libXext
    xorg.libXi
    xorg.libXmu
    xorg.libXrandr
    xorg.libXv
    zlib
  ];

  all-deps = runtime-deps ++ build-deps;

  PKG_CONFIG_PATH = l.makeSearchPathOutput "dev" "lib/pkgconfig" all-deps;
  LD_LIBRARY_PATH = l.makeLibraryPath all-deps;
  CUDA_PATH = pkgs.cudatoolkit;
  EXTRA_LDFLAGS = "-L${pkgs.linuxPackages.nvidia_x11}/lib";
in
  l.mapAttrs (_: inputs.std.lib.dev.mkShell) {
    default = {
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
          name = "CUDA_PATH";
          value = CUDA_PATH;
        }
        {
          name = "EXTRA_LDFLAGS";
          value = EXTRA_LDFLAGS;
        }
        {
          name = "LIBTORCH";
          value = with pkgs;
            symlinkJoin {
              name = "torch-join";
              paths = [libtorch-bin.dev libtorch-bin.out];
            };
        }
        {
          name = "RUSTFLAGS";
          value = "-C link-arg=-fuse-ld=mold";
        }
      ];

      packages = all-deps;

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
          tools = ["toolchain"];
        };
      };

      devshell.startup.link-cargo-home = {
        deps = [];
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
        }) ["rustc" "cargo" "rustfmt" "rust-analyzer"];
      in
        [
          {
            package = nixpkgs.treefmt;
            category = "repo tools";
          }
          {
            package = nixpkgs.alejandra;
            category = "repo tools";
          }
          {
            package = std.cli.default;
            category = "std";
          }
          {
            package = pkgs.nvfetcher;
            category = "repository";
          }
          {
            package = cells.workstation.packages.terminusdb;
            category = "storage";
          }
          {
            category = "development";
            name = "experience";
            command = ''
              cargo run --manifest-path $PRJ_ROOT/sources/experience/Cargo.toml;
            '';
          }
          {
            category = "development";
            name = "processor";
            command = ''
              cargo run --manifest-path $PRJ_ROOT/sources/processor/Cargo.toml;
            '';
          }
          {
            category = "development";
            name = "documentation";
            command = ''
              trunk serve --open $PRJ_ROOT/sources/documentation/index.html
            '';
          }
        ]
        ++ rustCmds;
    };
  }
