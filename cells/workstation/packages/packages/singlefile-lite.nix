{ sources, buildNpmPackage, ... }:

buildNpmPackage {
  inherit (sources.singlefile-lite) pname version src;

  npmDepsHash = "sha256-BDnt0iUC8PA+KOQf03tpwBodAmU/oOkqdpsZ5gm+X9o=";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/singlefile-lite
    mv ./* $out/share/singlefile-lite

    runHook postInstall
  '';
}
