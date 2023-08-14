# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }: {
  archiveweb-page = {
    pname = "archiveweb-page";
    version = "2825343c9dcc3152fa6afdca17f3f1d1c18bcd16";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "archiveweb.page";
      rev = "2825343c9dcc3152fa6afdca17f3f1d1c18bcd16";
      fetchSubmodules = false;
      sha256 = "sha256-TD09YLJm8O2FaMrGQu+eGeeP6KTeaExgZuJr00LNnNU=";
    };
    date = "2023-08-04";
  };
  automa = {
    pname = "automa";
    version = "14ba9aacd8f06842991bc57bd5a7e169d52fdd72";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "automa";
      rev = "14ba9aacd8f06842991bc57bd5a7e169d52fdd72";
      fetchSubmodules = false;
      sha256 = "sha256-7W4FhH+3RLskhHzlQxwHeVNKXeY6o7amNMCWv7fhink=";
    };
    date = "2023-08-04";
  };
  bypass-paywalls-chrome = {
    pname = "bypass-paywalls-chrome";
    version = "6880eb968c1985b8bf0ffc1f92802ef464ea30c1";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "bypass-paywalls-chrome";
      rev = "6880eb968c1985b8bf0ffc1f92802ef464ea30c1";
      fetchSubmodules = false;
      sha256 = "sha256-GYF0hOi/veIApoL+fOG2tFm5lyfSM+obOCq7cBN9xwQ=";
    };
    date = "2023-08-04";
  };
  enso-appimage = {
    pname = "enso-appimage";
    version = "2023.2.1-nightly.2023.8.2";
    src = fetchurl {
      url = "https://github.com/enso-org/enso/releases/download/2023.2.1-nightly.2023.8.3/enso-linux-2023.2.1-nightly.2023.8.3.AppImage";
      sha256 = "sha256-r/va4pYGl/OGpBolM3EUInqGLbkt7LD9PmqZdO24Q38=";
    };
  };
  enso-engine = {
    pname = "enso-engine";
    version = "2023.2.1-nightly.2023.8.2";
    src = fetchurl {
      url = "https://github.com/enso-org/enso/releases/download/2023.2.1-nightly.2023.8.3/enso-bundle-2023.2.1-nightly.2023.8.3-linux-amd64.tar.gz";
      sha256 = "sha256-Z5GNzrO83UkBL3NiUOyuxLq/d0Wxeg+GoUneokTCkx4=";
    };
  };
  goscrape = {
    pname = "goscrape";
    version = "f0ddcc87427123b147f3891520994ad93b1f0d57";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "goscrape";
      rev = "f0ddcc87427123b147f3891520994ad93b1f0d57";
      fetchSubmodules = false;
      sha256 = "sha256-EnyWkr+MgbYELeQjRNHwtCm7sHkS9fOH+afllb4Ov9Q=";
    };
    date = "2023-08-02";
  };
  infy-scroll = {
    pname = "infy-scroll";
    version = "7d1d3df5c32966e930288210e3a4ef3e610d46dc";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "infy-scroll";
      rev = "7d1d3df5c32966e930288210e3a4ef3e610d46dc";
      fetchSubmodules = false;
      sha256 = "sha256-LK28PFBJkjB2yWQAtxQsheaRTVzkQwD1euY+HoQGHCk=";
    };
    date = "2023-08-04";
  };
  isdcac = {
    pname = "isdcac";
    version = "88484fdc60a6bb5f0792f858203a588737351727";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "I-Still-Dont-Care-About-Cookies";
      rev = "88484fdc60a6bb5f0792f858203a588737351727";
      fetchSubmodules = false;
      sha256 = "sha256-IV4OkvxqHzlt9fOS1Ks+MpADUU0I5LvhxuV5V/LBK28=";
    };
    date = "2023-07-05";
  };
  llama-cpp = {
    pname = "llama-cpp";
    version = "1013be266a93c439d0441bea8a53f64bd6486dbb";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "llama.cpp";
      rev = "1013be266a93c439d0441bea8a53f64bd6486dbb";
      fetchSubmodules = false;
      sha256 = "sha256-FnLdnWF64jlivQCjk3JE0AXOhap3QI2hN0soISr8dzc=";
    };
    date = "2023-08-13";
  };
  nu_plugin_from_parquet = {
    pname = "nu_plugin_from_parquet";
    version = "ca90a110cfafe2313d75ead6e29757fd06758fb6";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "nu_plugin_from_parquet";
      rev = "ca90a110cfafe2313d75ead6e29757fd06758fb6";
      fetchSubmodules = false;
      sha256 = "sha256-3XDdBO4lZx3xwQJek9y4aEJl9geizLFhh0TgOwI+hBA=";
    };
    date = "2023-08-03";
  };
  nu_plugin_json_path = {
    pname = "nu_plugin_json_path";
    version = "0021f392c5d6b4e7a8a2df8074873b39eae73b88";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "nu_plugin_json_path";
      rev = "0021f392c5d6b4e7a8a2df8074873b39eae73b88";
      fetchSubmodules = false;
      sha256 = "sha256-d51BoPCUSAM+sQPD5eeybw3ZMChbGW467izpHSkBqrs=";
    };
    date = "2023-08-03";
  };
  nu_plugin_regex = {
    pname = "nu_plugin_regex";
    version = "d7b7b13098862515efff161154fdbc2d3fe17fc3";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "nu_plugin_regex";
      rev = "d7b7b13098862515efff161154fdbc2d3fe17fc3";
      fetchSubmodules = false;
      sha256 = "sha256-URomcTJao0Er2JmJNXwOdKMD7jlenhZUt+Rrw+cvB6M=";
    };
    date = "2023-08-03";
  };
  nu_scripts = {
    pname = "nu_scripts";
    version = "1d8457fa9dad1c621a1b1520a380e035258bca7f";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "nu_scripts";
      rev = "1d8457fa9dad1c621a1b1520a380e035258bca7f";
      fetchSubmodules = false;
      sha256 = "sha256-hcraab9EEH866NURIstaAW1RLbQXPWBgUVdAqxZkTD0=";
    };
    date = "2023-08-03";
  };
  nushell = {
    pname = "nushell";
    version = "6756df2895d2973f1d392a209d1f29576af41402";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "nushell";
      rev = "6756df2895d2973f1d392a209d1f29576af41402";
      fetchSubmodules = false;
      sha256 = "sha256-N2GVF1clRcKidm9+YFO+AwhqSGKqK2of9x2PDycSLV4=";
    };
    date = "2023-08-03";
  };
  oled-chrome = {
    pname = "oled-chrome";
    version = "ad4122b9bbfbd4f91a2701f3051d196620dce163";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "oled-chrome";
      rev = "ad4122b9bbfbd4f91a2701f3051d196620dce163";
      fetchSubmodules = false;
      sha256 = "sha256-V610UC4oU7isig+/fwdB5opI05+9QinTzlxisQMbdWE=";
    };
    date = "2022-11-17";
  };
  pywebscrapbook = {
    pname = "pywebscrapbook";
    version = "7e5068a8254328dada4bca25130ed84eb80ddadd";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "PyWebScrapBook";
      rev = "7e5068a8254328dada4bca25130ed84eb80ddadd";
      fetchSubmodules = false;
      sha256 = "sha256-YNVpz7FmSBftCtS/rwbCtY5Q/ZA2FXSLlmCeT9wnc3I=";
    };
    date = "2023-06-17";
  };
  singlefile-lite = {
    pname = "singlefile-lite";
    version = "d838f5d95dd24d1a999124f33a8ccd1678159d58";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "singlefile-lite";
      rev = "d838f5d95dd24d1a999124f33a8ccd1678159d58";
      fetchSubmodules = false;
      sha256 = "sha256-Og1/uZi4ZNPaFvIHBdRK8m2c66mgndo0Feh2hZCPh84=";
    };
    date = "2023-08-03";
  };
  structurizr-cli = {
    pname = "structurizr-cli";
    version = "1.33.1";
    src = fetchurl {
      url = "https://github.com/structurizr/cli/releases/download/v1.33.1/structurizr-cli-1.33.1.zip";
      sha256 = "sha256-xCwytQ3tsssR05YKklfiuCC768x8RE/Q4UexuJYUFAY=";
    };
  };
  terminusdb = {
    pname = "terminusdb";
    version = "27f22f2f3f5a995bec7151b04b19cbdd04a7933f";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "terminusdb";
      rev = "27f22f2f3f5a995bec7151b04b19cbdd04a7933f";
      fetchSubmodules = false;
      sha256 = "sha256-4ck3JGGOaqE+9H9ZLJyGNSsPBKY/SPRVjcD35inotQg=";
    };
    date = "2023-08-09";
  };
  terminusdb-dashboard = {
    pname = "terminusdb-dashboard";
    version = "stable";
    src = fetchurl {
      url = "https://github.com/terminusdb/terminusdb-dashboard/releases/download/v0.0.10/release.tar.gz";
      sha256 = "sha256-DKg4zwd8mG9GeeYSs3JmR6cPiUDj3J0l87x7cgCxYr8=";
    };
  };
  terminusdb-semantic-indexer = {
    pname = "terminusdb-semantic-indexer";
    version = "1071b599387cbfed6b0e742b23fe8ed38ee857f1";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "terminusdb-semantic-indexer";
      rev = "1071b599387cbfed6b0e742b23fe8ed38ee857f1";
      fetchSubmodules = false;
      sha256 = "sha256-lR3BT45R/PQ5EMfwhwcc5LFcFZwyhQjZGnLmc11/2Z8=";
    };
    date = "2023-08-10";
  };
  terminusdb-tus = {
    pname = "terminusdb-tus";
    version = "99fcefc8230590bc9c4e7bc764c603e7986c2b44";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "terminusdb-tus";
      rev = "99fcefc8230590bc9c4e7bc764c603e7986c2b44";
      fetchSubmodules = false;
      sha256 = "sha256-v4Viwtyfe4v2z9R9C9vxULGGd6X9v1wM8X0OpLG9VBE=";
    };
    date = "2023-02-09";
  };
  tg-archive = {
    pname = "tg-archive";
    version = "f8e0cfbbc591405a570365d3af4497bd3125544d";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "tg-archive";
      rev = "f8e0cfbbc591405a570365d3af4497bd3125544d";
      fetchSubmodules = false;
      sha256 = "sha256-8m8E05p5KinqMmWAen2nygBV5daiqWjMwDE29zcNb/A=";
    };
    date = "2023-07-24";
  };
  tortoise-tts = {
    pname = "tortoise-tts";
    version = "3c4d9c51316cd2421cc2dea11ac3a7a2d3394acd";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "tortoise-tts";
      rev = "3c4d9c51316cd2421cc2dea11ac3a7a2d3394acd";
      fetchSubmodules = false;
      sha256 = "sha256-JR8oNCsGpAtUWJSFZEGoEf1x0MhEJKsbITDZ1WB0+lg=";
    };
    date = "2023-07-30";
  };
  uassets-master = {
    pname = "uassets-master";
    version = "5f3c75a3b5a8e3181376d5a4cd57ef8089f47507";
    src = fetchFromGitHub {
      owner = "uBlockOrigin";
      repo = "uAssets";
      rev = "5f3c75a3b5a8e3181376d5a4cd57ef8089f47507";
      fetchSubmodules = false;
      sha256 = "sha256-i1y7gdbrqQ/83KFl4ZkwAoOOS0vCuZ5Akel9MqJvRDo=";
    };
    date = "2023-08-14";
  };
  uassets-prod = {
    pname = "uassets-prod";
    version = "d162d0c3db6bae690a000db098e1431cc00622ec";
    src = fetchFromGitHub {
      owner = "uBlockOrigin";
      repo = "uAssets";
      rev = "d162d0c3db6bae690a000db098e1431cc00622ec";
      fetchSubmodules = false;
      sha256 = "sha256-DRiio0V1pWWT1WOJC9F0cKkd+Gqw+iOTY5zSR9NE1SY=";
    };
    date = "2023-08-14";
  };
  ublock = {
    pname = "ublock";
    version = "cb93f768f6113b4ed3a0d1c1f0bba6e6c159b385";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "uBlock";
      rev = "cb93f768f6113b4ed3a0d1c1f0bba6e6c159b385";
      fetchSubmodules = false;
      sha256 = "sha256-YNCB/mJ5tjgNGJPKSnpjHQR9SIH/LXBjZCH7F5I6mvU=";
    };
    date = "2023-08-04";
  };
  webscrapbook = {
    pname = "webscrapbook";
    version = "c573fff2edb50885d966eeaa91df6cdef83e2fbb";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "webscrapbook";
      rev = "c573fff2edb50885d966eeaa91df6cdef83e2fbb";
      fetchSubmodules = false;
      sha256 = "sha256-CZVRZ2ztZ74jXTR/kfdBwuuisAuKX8Imk/g08rAbj1c=";
    };
    date = "2023-06-21";
  };
  whisper-cpp = {
    pname = "whisper-cpp";
    version = "b948361956739efcf634e3a0ff35a67ed11be61a";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "whisper.cpp";
      rev = "b948361956739efcf634e3a0ff35a67ed11be61a";
      fetchSubmodules = false;
      sha256 = "sha256-0jPfCp6Sy7iCe2ONSUaeB/5y6khDpP60yTiCu7h3VPY=";
    };
    date = "2023-08-03";
  };
}
