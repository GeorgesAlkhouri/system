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

    imports = [
      ./hardware-configuration.nix
      inputs.sops-nix.nixosModules.sops
      inputs.home.nixosModules.home-manager
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.extraSpecialArgs = {inherit inputs;};
    home-manager.users.nixos.systemd.user.startServices = "sd-switch";
    home-manager.users.nixos = {
      imports = with cell.homeProfiles; [base graphical];
    };

    home-manager.users.nixos.xdg.configFile."nushell/config.nu".source = ./presets/nushell/config.nu;
    home-manager.users.nixos.xdg.configFile."nushell/env.nu".source = ./presets/nushell/env.nu;
    home-manager.users.nixos.xdg.configFile."leftwm/config.ron".source = ./presets/leftwm/config.ron;
    home-manager.users.nixos.xdg.configFile."leftwm/theme.ron".source = ./presets/leftwm/theme.ron;
    home-manager.users.nixos.xdg.configFile."leftwm/themes/current/up".executable = true;
    home-manager.users.nixos.xdg.configFile."leftwm/themes/current/up".source = ./presets/leftwm/up.sh;
    home-manager.users.nixos.xdg.configFile."leftwm/themes/current/down".executable = true;
    home-manager.users.nixos.xdg.configFile."leftwm/themes/current/down".source = ./presets/leftwm/down.sh;
    home-manager.users.nixos.xdg.configFile."tree-sitter/config.json".text = inputs.nixpkgs.lib.generators.toJSON {} {
      "parser-directories" = ["/home/nixos/.config/tree-sitter/syntaxes"];
    };

    networking.hostName = "nixos";

    fonts = {
      fontDir.enable = true;
      packages = [inputs.nixpkgs.nerdfonts];
    };

    time.timeZone = "Europe/Warsaw";

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
