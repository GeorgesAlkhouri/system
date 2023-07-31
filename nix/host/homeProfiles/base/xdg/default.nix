{ inputs }: {
  configFile."leftwm/config.ron".source = inputs.self
    + "/nix/host/presets/leftwm/config.ron";

  configFile."leftwm/themes/current/theme.ron".source = inputs.self
    + "/nix/host/presets/leftwm/theme.ron";

  configFile."leftwm/themes/current/up".executable = true;
  configFile."leftwm/themes/current/up".source = inputs.self
    + "/nix/host/presets/leftwm/up.sh";

  configFile."leftwm/themes/current/down".executable = true;
  configFile."leftwm/themes/current/down".source = inputs.self
    + "/nix/host/presets/leftwm/down.sh";

  configFile."tree-sitter/config.json".text =
    inputs.nixpkgs.lib.generators.toJSON { } {
      "parser-directories" = [ "/home/nixos/.config/tree-sitter/syntaxes" ];
    };
}
