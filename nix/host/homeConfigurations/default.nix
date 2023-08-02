{ inputs, cell, }: {
  default = {
    bee = {
      pkgs = import inputs.nixpkgs {
        inherit (inputs.nixpkgs) system;
        config = { allowUnfree = true; };
      };
      home = inputs.home;
      inherit (inputs.nixpkgs) system;
    };
    imports = with cell.homeProfiles; [
      inputs.sops-nix.homeManagerModules.sops
      base
      graphical
    ];
  };
}
