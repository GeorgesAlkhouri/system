{
  inputs,
  cell,
  config,
}: let
  username = "nixos";
  homeDirRoot = "/home";
  homeDirectory = "${homeDirRoot}/${username}";
in {
  inherit username homeDirectory;
  stateVersion = "23.05";
}
