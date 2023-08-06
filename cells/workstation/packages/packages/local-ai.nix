{ sources, stdenv, ... }:

stdenv.mkDerivation {
  inherit (sources.local-ai) pname version src;

  phases = [ "installPhase" "patchPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/local-ai
    chmod +x $out/bin/local-ai
  '';
}
