{ inputs, cell }:
let
  l = inputs.nixpkgs.lib // builtins;
  pkgs = import inputs.nixpkgs { inherit (inputs.nixpkgs) system; };
in {
  enable = true;
  package =
    inputs.helix.packages.${pkgs.hostPlatform.system}.default.overrideAttrs
    (self: {
      makeWrapperArgs = self.makeWrapperArgs or [ ] ++ [
        "--suffix"
        "PATH"
        ":"
        (l.makeBinPath [
          pkgs.black
          pkgs.clang-tools
          pkgs.luajitPackages.lua-lsp
          pkgs.marksman
          pkgs.nil
          pkgs.nixfmt
          pkgs.nls
          pkgs.nodePackages.bash-language-server
          pkgs.nodePackages.prettier
          pkgs.nodePackages.vscode-css-languageserver-bin
          pkgs.nodePackages.vscode-langservers-extracted
          pkgs.python3Packages.python-lsp-black
          pkgs.python3Packages.python-lsp-ruff
          pkgs.python3Packages.python-lsp-server
          pkgs.rust-analyzer
          pkgs.rustfmt
          pkgs.shellcheck
          pkgs.taplo
          pkgs.topiary
        ])
      ];
    });

  settings = {
    editor = {
      auto-info = false;
      auto-save = true;
      auto-format = true;
      auto-pairs = true;
      true-color = true;
      cursorline = true;
      color-modes = false;
      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
      file-picker = { hidden = false; };
      line-number = "relative";
      indent-guides = {
        render = true;
        character = "┊";
      };
      lsp = {
        enable = true;
        display-messages = true;
        display-inlay-hints = true;
        snippets = true;
      };
      soft-wrap = { enable = true; };
    };
    keys = {
      normal = {
        C-n = [ "extend_line" ":insert-output echo 'FILL_THIS'" ];
        C-k = ":buffer-previous";
        C-j = ":buffer-next";
        C-l = [ ":pipe sort | uniq" ];
        space = {
          space = "file_picker";
          q = ":q";
          x = ":format";
          c = ":reload";
          ret = ":w";
        };
        esc = [ "collapse_selection" "keep_primary_selection" ];
        ret = [ "open_below" "normal_mode" ];
      };
      insert = {
        C-n = [ "normal_mode" "extend_line" ":insert-output echo 'FILL_THIS'" ];
      };
    };
    theme = "base16_transparent_alternative";
  };
  themes = {
    base16_transparent_alternative = {
      inherits = "base16_transparent";
      "ui.selection" = { bg = "#222222"; };
    };
  };
  languages = {
    language-server = {
      typst-lsp = { command = "${pkgs.typst-lsp}/bin/typst-lsp"; };
    };
    language = [
      {
        name = "bash";
        auto-format = true;
        formatter = {
          command = l.getExe pkgs.shfmt;
          args = [ "-i" "2" "-" ];
        };
      }
      {
        name = "nix";
        auto-format = true;
        formatter = {
          command = l.getExe pkgs.nixfmt;
          args = [ ];
        };
      }
      {
        name = "rust";
        auto-format = true;
        formatter = { command = "${pkgs.rustfmt}/bin/rustfmt"; };
      }
      {
        name = "nickel";
        auto-format = true;
      }
      {
        name = "typst";
        scope = "source.typst";
        auto-format = true;
        formatter = { command = "${pkgs.typst-fmt}/bin/typest-fmt"; };
        injection-regex = "typst";
        file-types = [ "typst" "typ" ];
        roots = [ ];
        comment-token = "//";
        language-servers = [ "typst-lsp" ];
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }
    ];
    grammar = [{
      name = "typst";
      source = {
        git = "https://github.com/SeniorMars/tree-sitter-typst";
        rev = "2e66ef4b798a26f0b82144143711f3f7a9e8ea35";
      };
    }];
  };
}
