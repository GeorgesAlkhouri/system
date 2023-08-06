{ stdenv, lib, autoPatchelfHook, sources, unzip, jre, makeWrapper, ... }:

stdenv.mkDerivation {
  inherit (sources.structurizr-cli) src pname version;

  nativeBuildInputs = lib.optionals stdenv.hostPlatform.isLinux [
    autoPatchelfHook
    unzip
    jre
    makeWrapper
  ];

  unpackPhase = "unzip $src";

  dontStrip = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mv {lib,docs} $out/bin
    mv structurizr* $out/bin

    wrapProgram $out//bin/structurizr.sh \
     --prefix PATH : ${lib.makeBinPath [ jre ]} \

    runHook postInstall
  '';
}
