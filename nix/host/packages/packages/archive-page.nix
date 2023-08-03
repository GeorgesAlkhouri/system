{ sources, stdenvNoCC, ... }:
stdenvNoCC.mkDerivation {
  inherit (sources.archive-page) pname version src;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/archive-page
    mv ./* $out/share/archive-page
    runHook postInstall
  '';
}
