# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  nu_plugin_json_path = {
    pname = "nu_plugin_json_path";
    version = "252e120d64b586a10e39ed3b545383936492d37f";
    src = fetchFromGitHub {
      owner = "cognitive-singularity";
      repo = "nu_plugin_json_path";
      rev = "252e120d64b586a10e39ed3b545383936492d37f";
      fetchSubmodules = false;
      sha256 = "sha256-q7aisxwx1vVPXyxXZKz2k2YaNo4llLYAxzEGWNMO9bc=";
    };
    date = "2023-07-27";
  };
}
