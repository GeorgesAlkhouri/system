{
  sources,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  inherit (sources.oled-chrome) pname version src;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/oled-chrome
    mv ./* $out/share/oled-chrome

    runHook postInstall
  '';
}
