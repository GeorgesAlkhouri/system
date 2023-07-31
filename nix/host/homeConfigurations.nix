{ inputs, cell, }: {
  default = {
    bee = {
      pkgs = inputs.nixpkgs;
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
