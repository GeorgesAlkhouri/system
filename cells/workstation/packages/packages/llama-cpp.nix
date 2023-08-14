{ stdenv, makeWrapper, sources, ... }:
stdenv.mkDerivation {
  inherit (sources.llama-cpp) pname version src;
  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ ];
  makeFlags = [ "main" ];
  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp ./main $out/bin/llama
    runHook postInstall
  '';
}
