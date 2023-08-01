{ inputs, cell, }: {
  default = {
    bee = {
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit (inputs.nixpkgs) system;
        config.allowUnfree = true;
      };
    };
    deployment = {
      allowLocalDeployment = true;
      targetHost = "127.0.0.1";
    };
    imports = [ cell.nixosConfigurations.default ];
  };
}
