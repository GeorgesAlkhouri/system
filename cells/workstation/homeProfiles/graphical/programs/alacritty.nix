{ inputs, cell }: {
  enable = true;
  package = inputs.nixpkgs.alacritty;
  settings = {
    font = {
      normal = { family = "Iosevka Term Nerd Font"; };
      size = 12;
      offset = {
        x = 0;
        y = 0;
      };
    };
    window = { opacity = 0; };
    mouse = { hide_when_typing = true; };
    scrolling = { history = 100000; };
  };
}
