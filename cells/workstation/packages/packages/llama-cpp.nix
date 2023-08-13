{ stdenv, SDL2, makeWrapper, sources, ... }:

stdenv.mkDerivation {
  inherit (sources.llama-cpp) pname version src;

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = [ SDL2 ];

  makeFlags = [ "main" ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp ./main $out/bin/llama

    runHook postInstall
  '';
}
