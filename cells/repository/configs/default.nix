{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.std) lib;
in {
  adrgen = lib.dev.mkNixago lib.cfg.adrgen {data = import ./adrgen.nix;};

  editorconfig = lib.dev.mkNixago lib.cfg.editorconfig {
    data = import ./editorconfig.nix;
    hook.mode = "copy";
  };

  conform = lib.dev.mkNixago lib.cfg.conform {data = import ./conform.nix;};

  lefthook =
    lib.dev.mkNixago lib.cfg.lefthook {data = import ./lefthook.nix;};

  mdbook = lib.dev.mkNixago lib.cfg.mdbook {
    data = import ./mdbook.nix;
    hook.mode = "copy";
  };

  treefmt = lib.dev.mkNixago lib.cfg.treefmt {
    data = import ./treefmt.nix;
    packages = [nixpkgs.shfmt nixpkgs.taplo nixpkgs.nixfmt nixpkgs.shfmt nixpkgs.go];
  };

  githubsettings = lib.dev.mkNixago lib.cfg.githubsettings {
    data = import ./githubsettings.nix;
  };
}
