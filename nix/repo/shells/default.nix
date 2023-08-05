{ inputs, cell, }:
let
  inherit (inputs.std) std lib;
  inherit (inputs.cells) app;
  l = inputs.nixpkgs.lib // builtins;
  nixpkgs = inputs.nixpkgs.appendOverlays [ ];
  local = with cell.packages; [ wgsl-analyzer ];
  rust = with inputs.nixpkgs; [
    cargo-watch
    cargo-edit
    cargo-nextest
    cargo-spellcheck
  ];
  python = with inputs.nixpkgs; [ poetry poetry2nix.cli python310 ];
  golang = with inputs.nixpkgs; [
    gnumake
    go
    gotools
    gopls
    go-outline
    gocode
    gopkgs
    gocode-gomod
    godef
    golint
    delve
  ];
  devops = with inputs.nixpkgs; [ terraform ];
in l.mapAttrs (_: inputs.std.lib.dev.mkShell) {
  default = {
    name = "devshell";
    packages =
      inputs.nixpkgs.lib.concatLists [ local rust python golang devops ];
    env = [ ];
    imports = [ inputs.std.std.devshellProfiles.default ];
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
        package = nixpkgs.nvfetcher;
        category = "repo";
      }
      {
        package = inputs.cells.host.packages.terminusdb;
        category = "data";
      }
      {
        package = inputs.nixpkgs.mdbook;
        category = "docs";
      }
    ];
  };
}

