{ sources, stdenvNoCC, ... }:

stdenvNoCC.mkDerivation {
  inherit (sources.nu_scripts) pname version src;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/nu_scripts
    mv ./* $out/share/nu_scripts

    runHook postInstall
  '';
}
