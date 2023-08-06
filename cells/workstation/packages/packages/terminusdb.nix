{ llvmPackages, sources, inputs, makeRustPlatform, fetchzip, stdenv, makeWrapper
, system, fetchFromGitHub, lib, ... }:

let
  pkgs-stable = import inputs.nixpkgs-stable {
    inherit system;

    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ "openssl-1.1.1u" "openssl-1.1.1v" ];
    };
  };

  toolchain = inputs.fenix.packages.${system}.minimal.toolchain;

  rustPlatform = makeRustPlatform {
    cargo = toolchain;
    rustc = toolchain;
  };

  DASHBOARD_VERSION = "0.0.10";

  TUS_VERSION = "0.0.14";

  tus = fetchFromGitHub {
    owner = "terminusdb";
    repo = "tus";
    rev = "v${TUS_VERSION}";
    sha256 = "sha256-v4Viwtyfe4v2z9R9C9vxULGGd6X9v1wM8X0OpLG9VBE=";
  };

  dashboard = fetchzip {
    url =
      "https://github.com/terminusdb/terminusdb-dashboard/releases/download/v${DASHBOARD_VERSION}/release.tar.gz";
    sha256 = "sha256-1dZSrBZe/CfclVQLnMu+ql6ZXpxhgDqWjvMqmbgtQ/U=";
    stripRoot = false;
  };

  swiProlog_withlibs = (pkgs-stable.swiProlog.overrideAttrs
    (finalAttrs: previousAttrs: {
      PKG_CONFIG_PATH =
        lib.makeSearchPath "lib/pkgconfig" previousAttrs.buildInputs;

      buildInputs = previousAttrs.buildInputs;
    })).override {
      extraPacks = map (dep-path: "'file://${dep-path}'") [ tus ];
    };

in stdenv.mkDerivation rec {
  inherit dashboard;
  inherit (sources.terminusdb) pname version src;

  cargoDeps = rustPlatform.importCargoLock {
    lockFile = "${src}/src/rust/Cargo.lock";
    outputHashes = {
      "juniper-0.15.10" = "sha256-TjoT6ELio8BaIOO4frQYUa0FWXNnsjlDmuDKZcIyEa8=";
      "terminusdb-grpc-labelstore-client-0.1.0" =
        "sha256-OfxSnvWpFWwd1N2o9FwXVQ0VMBEqKa7mjtFoJSmPuFk=";
    };
  };

  cargoRoot = "src/rust";

  buildInputs = with inputs.nixpkgs; [
    (with rustPlatform; [ cargoSetupHook cargo rustc rustc.llvmPackages.clang ])
    gmp
    libjwt
    m4
    makeWrapper
    pkg-config
    protobuf
    swiProlog_withlibs
  ];

  LIBCLANG_PATH = "${llvmPackages.libclang.lib}/lib";

  TERMINUSDB_DASHBOARD_PATH = "${placeholder "out"}/dashboard";

  installPhase = ''
    mkdir -p $out/bin
    cp terminusdb $out/bin/
    cp ${dashboard} -r $out/dashboard
  '';

  dontStrip = true;
}
