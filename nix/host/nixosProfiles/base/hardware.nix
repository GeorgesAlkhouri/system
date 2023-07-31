{
  pulseaudio = { enable = false; };
  nvidia = { modesetting = { enable = true; }; };
  opengl = {
    driSupport = true;
    driSupport32Bit = true;
    enable = true;
  };
}
