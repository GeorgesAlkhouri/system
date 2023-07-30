{
  inputs,
  cell,
}: {
  useGlobalPkgs = true;
  useUserPackages = true;
  extraSpecialArgs = {inherit inputs;};
  users.nixos = {
    imports = with cell.homeProfiles; [
      inputs.sops-nix.homeManagerModules.sops
      base
      graphical
    ];

    systemd.user.startServices = "sd-switch";

    sops.defaultSopsFile = ./secrets/secrets.yml;
    sops.age.sshKeyPaths = ["/home/nixos/.ssh/id_ed25519"];

    xdg.configFile."nushell/config.nu".source = ./presets/nushell/config.nu;
    xdg.configFile."nushell/env.nu".source = ./presets/nushell/env.nu;
    xdg.configFile."leftwm/config.ron".source = ./presets/leftwm/config.ron;
    xdg.configFile."leftwm/themes/current/theme.ron".source = ./presets/leftwm/theme.ron;
    xdg.configFile."leftwm/themes/current/up".executable = true;
    xdg.configFile."leftwm/themes/current/up".source = ./presets/leftwm/up.sh;
    xdg.configFile."leftwm/themes/current/down".executable = true;
    xdg.configFile."leftwm/themes/current/down".source = ./presets/leftwm/down.sh;
    xdg.configFile."tree-sitter/config.json".text = inputs.nixpkgs.lib.generators.toJSON {} {
      "parser-directories" = ["/home/nixos/.config/tree-sitter/syntaxes"];
    };
  };
}
