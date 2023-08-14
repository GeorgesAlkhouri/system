{ stdenv, SDL2, makeWrapper, sources, ... }:
stdenv.mkDerivation {
  inherit (sources.whisper-cpp) pname version src;
  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ SDL2 ];
  makeFlags = [ "main" "stream" ];
  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp ./main $out/bin/whisper-cpp
    cp ./stream $out/bin/whisper-cpp-stream
    runHook postInstall
  '';
}
