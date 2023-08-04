{ sources, stdenvNoCC, ... }:
stdenvNoCC.mkDerivation {
  inherit (sources.infy-scroll) pname version src;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/infy-scroll
    mv ./src/base/* $out/share/infy-scroll
    runHook postInstall
  '';
}
