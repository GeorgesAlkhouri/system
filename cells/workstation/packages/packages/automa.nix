{
  sources,
  buildNpmPackage,
  ...
}:
buildNpmPackage {
  inherit (sources.automa) pname version src;

  npmDepsHash = "sha256-U9CLl0IygP/UXEijLLXqcIilcPRhY688B06xtgqhpQQ=";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/automa
    mv ./build/* $out/share/automa
    runHook postInstall
  '';
}
