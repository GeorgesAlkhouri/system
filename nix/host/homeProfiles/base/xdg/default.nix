{inputs}: {
  configFile."nushell/config.nu".source = ./presets/nushell/config.nu;
  configFile."nushell/env.nu".source = ./presets/nushell/env.nu;
  configFile."leftwm/config.ron".source = ./presets/leftwm/config.ron;
  configFile."leftwm/themes/current/theme.ron".source = ./presets/leftwm/theme.ron;
  configFile."leftwm/themes/current/up".executable = true;
  configFile."leftwm/themes/current/up".source = ./presets/leftwm/up.sh;
  configFile."leftwm/themes/current/down".executable = true;
  configFile."leftwm/themes/current/down".source = ./presets/leftwm/down.sh;
  configFile."tree-sitter/config.json".text = inputs.nixpkgs.lib.generators.toJSON {} {
    "parser-directories" = ["/home/nixos/.config/tree-sitter/syntaxes"];
  };
}
