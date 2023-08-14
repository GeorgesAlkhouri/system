{ inputs, cell }: {
  configFile = {
    "leftwm/config.ron".source = inputs.self + "/configs/leftwm/config.ron";
    "leftwm/themes/current/theme.ron".source = inputs.self + "/configs/leftwm/theme.ron";
    "leftwm/themes/current/up".executable = true;
    "leftwm/themes/current/up".source = inputs.self + "/configs/leftwm/up.sh";
    "leftwm/themes/current/down".executable = true;
    "leftwm/themes/current/down".source = inputs.self + "/configs/leftwm/down.sh";
    "tree-sitter/config.json".text = inputs.nixpkgs.lib.generators.toJSON { } { "parser-directories" = [ "/home/nixos/.config/tree-sitter/syntaxes" ]; };
    # "autostart/monitor.desktop".text =
    #   inputs.nixpkgs.lib.generators.toINI { } {
    #     "Desktop Entry" = {
    #       Type = "Application";
    #       Name = "Monitor";
    #       Exec =
    #         "alacritty --working-directory ${cell.homeProfiles.base.home.homeDirectory}/system --class monitor --command nu start.nu monitor";
    #     };
    #   };
    # "autostart/experience.desktop".text =
    #   inputs.nixpkgs.lib.generators.toINI { } {
    #     "Desktop Entry" = {
    #       Type = "Application";
    #       Name = "Experience";
    #       Exec = "${inputs.cells.experience.packages.wrapped}/bin/experience";
    #     };
    #   };
  };
}
