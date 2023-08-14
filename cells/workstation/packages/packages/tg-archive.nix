{ sources, python3Packages, ... }:
python3Packages.buildPythonApplication {
  inherit (sources.tg-archive) pname version src;
  postPatch = "sed -i 's/==/>=/' requirements.txt ";
  propagatedBuildInputs = with python3Packages; [ cryptg feedgen jinja2 pillow python-magic pytz pyyaml setuptools telethon ];
}
