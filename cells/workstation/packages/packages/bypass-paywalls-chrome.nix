{ sources, stdenvNoCC, ... }:
stdenvNoCC.mkDerivation {
  inherit (sources.bypass-paywalls-chrome) pname version src;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/bypass-paywalls-chrome
    mv ./* $out/share/bypass-paywalls-chrome
    runHook postInstall
  '';
}
