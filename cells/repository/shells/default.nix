{ inputs, cell, }:

let
  inherit (inputs) cells;

  inherit (inputs.std) lib;

  l = inputs.nixpkgs.lib // builtins;
  pkgs = inputs.nixpkgs.appendOverlays [ ];

in l.mapAttrs (_: inputs.std.lib.dev.mkShell) {
  default = {
    name = "devshell";

    imports = [ inputs.std.std.devshellProfiles.default ];

    env = [{
      name = "DEVSHELL_NO_MOTD";
      value = "1";
    }];

    packages = with pkgs; [ pkg-config ];

    nixago = [
      ((lib.dev.mkNixago lib.cfg.conform) {
        data = { inherit (inputs) cells; };
      })
      ((lib.dev.mkNixago lib.cfg.treefmt) cell.configs.treefmt)
      ((lib.dev.mkNixago lib.cfg.editorconfig) cell.configs.editorconfig)
      (lib.dev.mkNixago lib.cfg.lefthook)
    ];

    commands = [
      {
        package = pkgs.nvfetcher;
        category = "repository";
      }
      {
        package = cells.workstation.packages.terminusdb;
        category = "storage";
      }
      {
        category = "development";
        name = "experience";
        command =
          "cargo run --bin experience --manifest-path $PRJ_ROOT/sources/experience/Cargo.toml";
      }
      {
        category = "development";
        name = "languages";
        command =
          "cargo run --bin experience --manifest-path $PRJ_ROOT/sources/experience/Cargo.toml";
      }
      {
        category = "development";
        name = "documentation";
        command = ''
          RUSTFLAGS=""
          LD_LIBRARY_PATH=""
          trunk serve --open $PRJ_ROOT/sources/documentation/index.html
        '';
      }
    ];
  };
}
