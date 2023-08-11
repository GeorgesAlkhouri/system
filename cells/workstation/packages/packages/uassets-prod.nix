{
  sources,
  stdenv,
  ...
}:
stdenv.mkDerivation {
  inherit (sources.uassets-prod) pname version src;

  configurePhase = ''
    mkdir -p build/validate
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/uassets-prod
    mv ./* $out/share/uassets-prod

    runHook postInstall
  '';
}
