{ sources, python3Packages, ... }:
python3Packages.buildPythonApplication {
  inherit (sources.pywebscrapbook) pname version src;
  propagatedBuildInputs = with python3Packages; [
    flask
    werkzeug
    jinja2
    lxml
    CommonMark
    cryptography
  ];
}
