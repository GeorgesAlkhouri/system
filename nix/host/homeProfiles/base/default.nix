{}: {
  sops.defaultSopsFile = ./secrets/secrets.yml;
  sops.age.sshKeyPaths = ["/home/nixos/.ssh/id_ed25519"];

  # # sops.secrets.gh_token = {};
  # #   home.sessionVariables = {
  # #     GH_TOKEN = "$(cat ${cell.nixosConfigurations.default.sops.secrets.gh_token.path})";
  # #   };
}
