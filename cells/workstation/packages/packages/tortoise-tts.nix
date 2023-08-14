{ sources, python3Packages, ... }:
python3Packages.buildPythonApplication {
  inherit (sources.tg-archive) pname version src;
  propagatedBuildInputs = with python3Packages; [ telethon jinja2 pyyaml cryptg pillow feedgen python-magic setuptools pytz ];
}
