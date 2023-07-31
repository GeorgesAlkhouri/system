{ inputs, cell, }:
let
  username = "nixos";
  homeDirRoot = "/home";
  homeDirectory = "${homeDirRoot}/${username}";
in {
  inherit username homeDirectory;
  stateVersion = "23.05";
}
