{
  sources,
  stdenv,
  ...
}:
stdenv.mkDerivation {
  inherit (sources.uassets-master) pname version src;

  configurePhase = ''
    mkdir -p build/validate
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/uassets-master
    mv ./* $out/share/uassets-master

    runHook postInstall
  '';
}
