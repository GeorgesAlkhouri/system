{ inputs, cell, }:

{
  default = {
    bee = {
      inherit (inputs.nixpkgs) system;

      pkgs = import inputs.nixpkgs { inherit (inputs.nixpkgs) system; };
    };

    deployment = {
      allowLocalDeployment = true;
      targetHost = "127.0.0.1";
    };

    imports = [ cell.nixosConfigurations.default ];
  };
}
