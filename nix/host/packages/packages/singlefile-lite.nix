{ sources, stdenvNoCC, ... }:
stdenvNoCC.mkDerivation {
  inherit (sources.singlefile-lite) pname version src;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/singlefile-lite
    mv ./* $out/share/singlefile-lite
    runHook postInstall
  '';
}
