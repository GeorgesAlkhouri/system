{ inputs, cell }: {
  default = {
    bee = {
      inherit (inputs.nixpkgs) system;
      pkgs = import inputs.nixpkgs { inherit (inputs.nixpkgs) system; };
      home = inputs.home-manager;
    };
    imports = [
      inputs.sops-nix.homeManagerModules.sops
      cell.homeProfiles.base
      cell.homeProfiles.graphical
    ];
  };
}
