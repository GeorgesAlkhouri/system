{
  enable = true;
  autoRepeatDelay = 250;
  displayManager.autoLogin.enable = true;
  displayManager.autoLogin.user = "nixos";
  displayManager.defaultSession = "none+leftwm";
  displayManager.lightdm.enable = true;
  layout = "us";
  windowManager.leftwm.enable = true;
  videoDrivers = ["nvidia"];
}
