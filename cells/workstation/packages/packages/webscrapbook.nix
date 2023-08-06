{ sources, stdenvNoCC, ... }:

stdenvNoCC.mkDerivation {
  inherit (sources.webscrapbook) pname version src;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/webscrapbook
    mv ./src/* $out/share/webscrapbook

    runHook postInstall
  '';
}
