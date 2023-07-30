{
  inputs,
  cell,
}: {
  default = {
    bee = {
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit (inputs.nixpkgs) system;
        config.allowUnfree = true;
        overlays = [];
      };
      home = inputs.home;
    };

    imports = with cell.nixosProfiles; [
      ./hardware-configuration.nix
      inputs.sops-nix.nixosModules.sops
      inputs.home.nixosModules.home-manager
      base
    ];

    users.nixos = {
      imports = with cell.homeProfiles; [
        inputs.sops-nix.homeManagerModules.sops
        base
        graphical
      ];
    };

    nix.settings.experimental-features = "nix-command flakes";
    nix.settings.trusted-users = ["root" "nixos"];

    i18n.defaultLocale = "en_US.UTF-8";

    services.xserver.enable = true;

    services.xserver.autoRepeatDelay = 250;
    services.xserver.displayManager.autoLogin.enable = true;
    services.xserver.displayManager.autoLogin.user = "nixos";
    services.xserver.displayManager.defaultSession = "none+leftwm";
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.layout = "us";
    services.xserver.windowManager.leftwm.enable = true;

    sound.enable = true;

    hardware.pulseaudio.enable = false;
    hardware.nvidia.modesetting.enable = true;
    hardware.opengl.driSupport = true;
    hardware.opengl.driSupport32Bit = true;
    hardware.opengl.enable = true;

    security.sudo.wheelNeedsPassword = false;
    security.rtkit.enable = true;

    services.openssh.enable = true;
    services.openssh.settings.PasswordAuthentication = true;
    services.openssh.settings.PermitRootLogin = "no";

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    services.xserver.videoDrivers = ["nvidia"];

    virtualisation.docker.enable = true;
    virtualisation.docker.enableOnBoot = true;
    virtualisation.docker.enableNvidia = true;

    users.users.nixos = {
      isNormalUser = true;
      description = "nixos";
      extraGroups = ["wheel" "docker"];
      openssh.authorizedKeys.keys = [];
      shell = inputs.nixpkgs.nushellFull;
    };

    environment.systemPackages = with inputs.nixpkgs; [xclip];

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    networking.firewall.allowedTCPPorts = [];
    networking.firewall.allowedUDPPorts = [];
    networking.firewall.enable = false;

    system.stateVersion = "23.05";
  };
}
