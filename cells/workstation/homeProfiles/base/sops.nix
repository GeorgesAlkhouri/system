{ inputs }: {
  defaultSopsFile = inputs.self + "/cells/workstation/secrets/secrets.yml";
  age = { sshKeyPaths = [ "/home/nixos/.ssh/id_ed25519" ]; };
  secrets = {
    GITHUB_TOKEN = { path = "/home/nixos/.config/gh/gh_token"; };
    GITHUB_TOKEN_PERSONAL = { path = "/home/nixos/.config/gh/gh_token_personal"; };
    TERMINUSDB_ACCESS_TOKEN = { path = "/home/nixos/.config/terminusdb/terminusdb_access_token"; };
  };
}
