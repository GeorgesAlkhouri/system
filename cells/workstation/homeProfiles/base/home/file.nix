{ inputs }:
let tomlFormat = inputs.nixpkgs.formats.toml { };
in {
  ".ignore".source = inputs.self + "/configs/ignore";
  ".cargo/config".source = tomlFormat.generate "cargo-config" {
    net = { git-fetch-with-cli = true; };
  };
}
