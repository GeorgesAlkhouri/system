{ sources, stdenvNoCC, ... }:
stdenvNoCC.mkDerivation {
  inherit (sources.isdcac) pname version src;

  buildPhase = ''
    cp src/manifest_v2.json src/manifest.json
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/isdcac
    mv ./src/* $out/share/isdcac
    runHook postInstall
  '';
}
