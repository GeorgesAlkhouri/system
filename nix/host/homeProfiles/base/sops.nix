{
  defaultSopsFile = ../../secrets/secrets.yml;
  age.sshKeyPaths = ["/home/nixos/.ssh/id_ed25519"];
  secrets.gh_token = {
    path = "/home/nixos/.config/gh/gh_token";
  };
}
