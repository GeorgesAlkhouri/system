{
  enable = true;

  enableNushellIntegration = false;

  nix-direnv = { enable = true; };

  config = {
    strict_env = true;
    warn_timeout = "30s";
  };
}
