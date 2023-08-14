{
  formatter = {
    nix = {
      command = "nixfmt";
      options = [ "--width" "160" ];
      includes = [ "*.nix" ];
    };
    toml = {
      command = "taplo";
      options = [ "format" ];
      includes = [ "*.toml" ];
    };
    go = {
      command = "gofmt";
      options = [ "-w" ];
      includes = [ "*.go" ];
    };
    shell = {
      command = "shfmt";
      options = [ "-i" "2" "-s" "-w" ];
      includes = [ "*.sh" ];
    };
  };
}
