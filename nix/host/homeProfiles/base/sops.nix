{ inputs }: {
  defaultSopsFile = inputs.self + "/nix/host/secrets/secrets.yml";
  age = { sshKeyPaths = [ "/home/nixos/.ssh/id_ed25519" ]; };
  secrets = {
    gh_token = { path = "/home/nixos/.config/gh/gh_token"; };
    gh_token_org = { path = "/home/nixos/.config/gh/gh_token_org"; };
    terminusdb_access_token = {
      path = "/home/nixos/.config/terminusdb/terminusdb_access_token";
    };
  };
}
