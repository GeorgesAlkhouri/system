{
  autoPatchelfHook,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "wgsl_analyzer";

  version = "0.7.0";

  src = builtins.fetchurl {
    url = "https://github.com/wgsl-analyzer/wgsl-analyzer/releases/download/v${version}/wgsl_analyzer-linux-x64";
    sha256 = "sha256-HvQfvfvXcgkfk3Ly47eam0PpaIOQaMEZp6dqVnQgrAY=";
  };

  nativeBuildInputs = [autoPatchelfHook];

  phases = ["installPhase"];

  installPhase = ''
    install -m755 -D $src $out/bin/wgsl_analyzer
  '';
}
