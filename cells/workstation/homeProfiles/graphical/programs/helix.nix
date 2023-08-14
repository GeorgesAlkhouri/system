{ inputs, cell }: {
  enable = true;
  package = inputs.helix.packages.${inputs.nixpkgs.system}.default;
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
      whitespace = {
        render = {
          space = "none";
          tab = "none";
          newline = "none";
        };
        characters = {
          space = "·";
          nbsp = "⍽";
          tab = "→";
          newline = "⏎";
          tabpad = "·";
        };
      };
      file-picker = { hidden = false; };
      line-number = "relative";
      indent-guides = {
        render = true;
        character = "┊";
      };
      statusline = {
        left = [ "mode" "spinner" "file-name" ];
        center = [ ];
        right = [ "diagnostics" "selections" "position" "file-encoding" "file-line-ending" "file-type" ];
        separator = "│";
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
      insert = { C-n = [ "normal_mode" "extend_line" ":insert-output echo 'FILL_THIS'" ]; };
    };
    theme = "base16_transparent";
  };
  languages = {
    language-server = {
      typst-lsp = { command = "${inputs.nixpkgs.typst-lsp}/bin/typst-lsp"; };
      typescript-language-server = with inputs.nixpkgs.nodePackages; {
        command = "${typescript-language-server}/bin/typescript-language-server";
        args = [ "--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib" ];
      };
    };
    language = [
      {
        name = "rust";
        auto-format = true;
      }
      {
        name = "nickel";
        auto-format = true;
      }
      {
        name = "nix";
        auto-format = true;
        formatter = {
          command = "${inputs.nixpkgs.nixfmt}/bin/nixfmt";
          args = [ "--width" "160" ];
        };
      }
      {
        name = "typst";
        scope = "source.typst";
        auto-format = true;
        formatter = { command = "${inputs.nixpkgs.typst-fmt}/bin/typst-fmt"; };
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
