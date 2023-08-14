{
  book = {
    language = "en";
    multilingual = false;
    src = "docs";
    title = "Documentation";
  };
  build = { build-dir = "docs/book"; };
  preprocessor = { kroki-preprocessor = { command = "mdbook-kroki-preprocessor"; }; };
}
