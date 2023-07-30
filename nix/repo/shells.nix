{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.std) lib;
  l = inputs.nixpkgs.lib // builtins;
in
  l.mapAttrs (_: inputs.std.lib.dev.mkShell) {
    default = {
      name = "devshell";

      imports = [inputs.std.std.devshellProfiles.default];

      nixago = [
        ((lib.dev.mkNixago lib.cfg.conform) {data = {inherit (inputs) cells;};})
        ((lib.dev.mkNixago lib.cfg.treefmt) cell.configs.treefmt)
        ((lib.dev.mkNixago lib.cfg.editorconfig) cell.configs.editorconfig)
        (lib.dev.mkNixago lib.cfg.lefthook)
      ];

      commands = [
        {
          package = nixpkgs.jq;
        }
        {
          package = inputs.nixpkgs.nvfetcher;
          category = "versioning";
        }
        {
          package = inputs.nixpkgs.sops;
          category = "secrets";
        }

        {
          package = inputs.nixpkgs.age;
          category = "secrets";
        }
      ];
    };
  }
