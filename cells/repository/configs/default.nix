{ inputs, cell, }: {

  editorconfig = {
    data = {
      root = true;

      "*" = {
        end_of_line = "lf";
        insert_final_newline = true;
        trim_trailing_whitespace = true;
        charset = "utf-8";
        indent_style = "space";
        indent_size = 2;
      };

      "*.{diff,patch}" = {
        end_of_line = "unset";
        insert_final_newline = "unset";
        trim_trailing_whitespace = "unset";
        indent_size = "unset";
      };

      "*.md" = {
        max_line_length = "off";
        trim_trailing_whitespace = false;
      };

      "{LICENSES/**,LICENSE}" = {
        end_of_line = "unset";
        insert_final_newline = "unset";
        trim_trailing_whitespace = "unset";
        charset = "unset";
        indent_style = "unset";
        indent_size = "unset";
      };
    };
  };

  treefmt = {
    packages =
      [ inputs.nixpkgs.nixfmt inputs.nixpkgs.shfmt inputs.nixpkgs.taplo ];

    data = {
      formatter = {
        nix = {
          command = "nixfmt";
          includes = [ "*.nix" ];
        };

        toml = {
          command = "taplo";
          options = [ "format" ];
          includes = [ "*.toml" ];
        };

        shell = {
          command = "shfmt";
          options = [ "-i" "2" "-s" "-w" ];
          includes = [ "*.sh" ];
        };
      };
    };
  };

  lefthook = {
    data = {
      commit-msg = {
        commands = {
          conform = {
            run = ''
              [[ "$(head -n 1 {1})" =~ ^WIP(:.*)?$|^wip(:.*)?$|fixup\!.*|squash\!.* ]] ||
              conform enforce --commit-msg-file {1}'';
            skip = [ "merge" "rebase" ];
          };
        };
      };

      pre-commit = {
        commands = {
          treefmt = {
            run = "treefmt --fail-on-change {staged_files}";
            skip = [ "merge" "rebase" ];
          };
        };
      };
    };
  };
}
