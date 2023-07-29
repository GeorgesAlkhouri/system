{
  enable = true;
  settings = {
    editor.auto-info = false;
    editor.auto-save = true;
    editor.auto-format = true;
    editor.cursor-shape.insert = "bar";
    editor.cursor-shape.normal = "block";
    editor.cursor-shape.select = "underline";
    editor.line-number = "relative";
    editor.lsp.display-messages = true;
    editor.soft-wrap.enable = true;
    keys.normal.space.q = ":q";
    keys.normal."C-k" = ":buffer-previous";
    keys.normal."C-j" = ":buffer-next";
    keys.normal.space.ret = ":w";
    theme = "base16_transparent";
  };
  languages.language = [
    {
      name = "nix";
      formatter.command = "alejandra";
      auto-format = true;
    }
  ];
}
