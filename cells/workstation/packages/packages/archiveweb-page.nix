{
  sources,
  buildNpmPackage,
  inputs,
  ...
}:
buildNpmPackage {
  inherit (sources.archiveweb-page) pname version src;

  npmDepsHash = "sha256-4LhQCxyDow41KoflGUGX00syx8h8rkqGRmw47vawQhk=";

  buildInputs = with inputs.nixpkgs; [nodePackages.node-gyp-build];

  npmFlags = ["--legacy-peer-deps"];

  makeCacheWritable = true;

  PYTHON = "${inputs.nixpkgs.python3}/bin/python";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/archiveweb-page
    mv ./dist/ext/* $out/share/archiveweb-page
    runHook postInstall
  '';
}
