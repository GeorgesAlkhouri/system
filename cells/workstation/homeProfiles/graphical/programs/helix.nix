{
  inputs,
  cell,
}: {
  enable = true;
  package = inputs.helix.packages.${inputs.nixpkgs.system}.default;
  settings = {
    editor = {
      auto-info = false;
      auto-save = true;
      auto-format = true;

      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
      line-number = "relative";

      lsp = {display-messages = true;};

      soft-wrap = {enable = true;};
    };

    keys = {
      normal = {
        C-n = ["extend_line" ":insert-output echo 'FILL_THIS'"];
        C-k = ":buffer-previous";
        C-j = ":buffer-next";
        C-l = [":pipe sort | uniq"];

        space = {
          space = "file_picker";
          q = ":q";
          x = ":format";
          ret = ":w";
        };

        esc = ["collapse_selection" "keep_primary_selection"];

        ret = ["open_below" "normal_mode"];
      };

      insert = {
        C-n = ["normal_mode" "extend_line" ":insert-output echo 'FILL_THIS'"];
      };
    };

    theme = "base16_transparent";
  };

  languages = {
    typescript-language-server = with inputs.nixpkgs.nodePackages; {
      command = "${typescript-language-server}/bin/typescript-language-server";
      args = [
        "--stdio"
        "--tsserver-path=${typescript}/lib/node_modules/typescript/lib"
      ];
    };

    language = [
      {
        name = "nix";
        formatter = {command = "nixfmt";};
        auto-format = true;
      }
      {
        name = "rust";
        auto-format = true;
      }
    ];
  };
}
