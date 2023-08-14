{ stdenv, sources, inputs, cell, ... }:
stdenv.mkDerivation {
  inherit (sources.ublock) pname version src;
  buildInputs = with inputs.nixpkgs; [ zip python3 git ];
  PYTHON = "${inputs.nixpkgs.python3}/bin/python";
  buildPhase = ''
    mkdir -p dist/build/uAssets
    mkdir -p dist/build/uBlock0.chromium
    cp --no-preserve=mode,ownership -r ${cell.packages.uassets-master}/share/uassets-master dist/build/uAssets/main
    cp --no-preserve=mode,ownership -r ${cell.packages.uassets-prod}/share/uassets-prod dist/build/uAssets/prod
    ${inputs.nixpkgs.bash}/bin/bash tools/make-assets.sh dist/build/uBlock0.chromium
    ${inputs.nixpkgs.bash}/bin/bash tools/make-chromium.sh all
  '';
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/ublock
    mv ./dist/build/uBlock0.chromium/* $out/share/ublock
    runHook postInstall
  '';
}
