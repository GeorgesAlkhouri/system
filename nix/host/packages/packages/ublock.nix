{ sources, stdenvNoCC, ... }:
stdenvNoCC.mkDerivation {
  inherit (sources.ublock) pname version src;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/ublock
    mv ./* $out/share/ublock
    runHook postInstall
  '';
}
