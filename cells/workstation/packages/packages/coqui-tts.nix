{ lib, system, inputs, sources, ... }:

let
  pkgs = import inputs.nixpkgs {
    inherit system;

    config = { allowUnfree = true; };
  };

  python = pkgs.python3.override {
    packageOverrides = self: super: {
      torch = super.torch-bin;
      torchvision = super.torchvision-bin;
    };
  };
in python.pkgs.buildPythonApplication {
  inherit (sources.coqui-tts) pname version src;

  format = "pyproject";

  postPatch = let
    relaxedConstraints = [
      "bnunicodenormalizer"
      "cython"
      "gruut"
      "inflect"
      "librosa"
      "mecab-python3"
      "numba"
      "numpy"
      "unidic-lite"
      "trainer"
    ];
  in ''
    sed -r -i \
      ${
        lib.concatStringsSep "\n"
        (map (package: "-e 's/${package}.*[<>=]+.*/${package}/g' \\")
          relaxedConstraints)
      }
    requirements.txt
    # only used for notebooks and visualization
    sed -r -i -e '/umap-learn/d' requirements.txt
  '';

  nativeBuildInputs = with python.pkgs; [ cython packaging ];

  propagatedBuildInputs = with python.pkgs; [
    anyascii
    bangla
    bnnumerizer
    bnunicodenormalizer
    coqpit
    einops
    encodec
    flask
    fsspec
    g2pkk
    gdown
    gruut
    inflect
    jamo
    jieba
    k-diffusion
    librosa
    matplotlib
    mecab-python3
    nltk
    numba
    packaging
    pandas
    pypinyin
    pysbd
    scipy
    soundfile
    tensorflow
    torch-bin
    torchaudio-bin
    tqdm
    trainer
    transformers
    unidic-lite
    webrtcvad
  ];

  postInstall = ''
    cp -r TTS/server/templates/ $out/${python.sitePackages}/TTS/server
    (
      cd TTS/tts/utils/monotonic_align
      ${python.pythonForBuild.interpreter} setup.py install --prefix=$out
    )
  '';

  doCheck = false;
}
