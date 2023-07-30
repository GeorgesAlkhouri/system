{configs}: {
  defaultSopsFile = ../../../secrets/secrets.yml;
  age.sshKeyPaths = ["/home/nixos/.ssh/id_ed25519"];
  secrets.gh_token = {};

  # home.sessionVariables = {
  #   GH_TOKEN = "$(cat ${config.sops.secrets.gh_token.path})";
  # };
}
