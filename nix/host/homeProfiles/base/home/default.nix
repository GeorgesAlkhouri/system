{inputs}: let
  username = "nixos";
  homeDirRoot = "/home";
  homeDirectory = "${homeDirRoot}/${username}";
in {
  inherit username homeDirectory;

  stateVersion = "23.05";

  # home.sessionVariables = {
  #   GH_TOKEN = "$(cat ${config.sops.secrets.gh_token.path})";
  # };
}
