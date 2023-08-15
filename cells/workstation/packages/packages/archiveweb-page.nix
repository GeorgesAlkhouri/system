{ sources, buildNpmPackage, python3, nodePackages, ... }:
buildNpmPackage {
  inherit (sources.archiveweb-page) pname version src;
  npmDepsHash = "sha256-JmMr7KqJah782drmGUY6Fg9F2vl3Ous1sF8ZijzulPQ=";
  buildInputs = [ nodePackages.node-gyp-build ];
  npmFlags = [ "--legacy-peer-deps" ];
  makeCacheWritable = true;
  PYTHON = "${python3}/bin/python";
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/archiveweb-page
    mv ./dist/ext/* $out/share/archiveweb-page
    runHook postInstall
  '';
}
