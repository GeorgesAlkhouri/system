{
  enable = true;
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
      lsp = { display-messages = true; };
      soft-wrap = { enable = true; };
    };
    keys = {
      normal = {
        "C-k" = ":buffer-previous";
        "C-j" = ":buffer-next";
        space = {
          q = ":q";
          ret = ":w";
        };
      };
    };
    theme = "base16_transparent";
  };
  languages = {
    language = [{
      name = "nix";
      formatter = { command = "nixfmt"; };
      auto-format = true;
    }];
  };
}
