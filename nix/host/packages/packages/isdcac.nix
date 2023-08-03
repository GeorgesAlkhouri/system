{ sources, stdenvNoCC, ... }:
stdenvNoCC.mkDerivation {
  inherit (sources.isdcac) pname version src;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/isdcac
    mv ./src/* $out/share/isdcac
    runHook postInstall
  '';
}
