{
  enable = true;

  autoRepeatDelay = 250;

  displayManager = {
    autoLogin = {
      enable = true;
      user = "nixos";
    };

    defaultSession = "none+leftwm";

    lightdm = {enable = true;};
  };

  layout = "us";

  windowManager = {leftwm = {enable = true;};};

  videoDrivers = ["nvidia"];
}
