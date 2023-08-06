{ sources, stdenvNoCC, ... }:

stdenvNoCC.mkDerivation {
  inherit (sources.wgsl_analyzer) pname version src;

  phases = [ "installPhase" ];

  installPhase = "install -m755 -D $src $out/bin/wgsl_analyzer ";
}
