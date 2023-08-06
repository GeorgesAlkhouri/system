{ sources, python3, nix-update-script, ... }:

python3.pkgs.buildPythonApplication {
  inherit (sources.shell_gpt) pname version src;

  format = "pyproject";

  nativeBuildInputs = with python3.pkgs; [
    python3.pkgs.pythonRelaxDepsHook
    python3
    pip
  ];

  propagatedBuildInputs = with python3.pkgs; [
    markdown-it-py
    rich
    distro
    typer
    requests
    hatchling
  ];

  pythonRelaxDeps = [ "requests" "rich" "distro" "typer" ];

  passthru.updateScript = nix-update-script { };

  doCheck = false;
}
