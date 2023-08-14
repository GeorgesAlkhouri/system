{
  sudo = { wheelNeedsPassword = false; };
  rtkit = { enable = true; };
  pam = {
    loginLimits = [{
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "262144";
    }];
  };
}
