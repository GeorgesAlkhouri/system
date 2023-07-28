{
  inputs,
  cell,
}: let
  l = inputs.nixpkgs.lib // builtins;
in
  l.mapAttrs (_: inputs.std.lib.dev.mkShell) {
    default = {
      name = "hive-example";

      imports = [inputs.std.std.devshellProfiles.default];

      nixago = [
        inputs.std.lib.cfg.conform
        (inputs.std.lib.cfg.treefmt cell.configs.treefmt)
        (inputs.std.lib.cfg.editorconfig cell.configs.editorconfig)
        (inputs.std.lib.cfg.lefthook cell.configs.lefthook)
      ];
    };
  }
