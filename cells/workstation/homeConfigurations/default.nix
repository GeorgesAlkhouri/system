{
  inputs,
  cell,
}: {
  default = {
    bee = {
      inherit (inputs.nixpkgs) system;

      pkgs = import inputs.nixpkgs {inherit (inputs.nixpkgs) system;};

      home = inputs.home;
    };

    imports = with cell.homeProfiles; [
      inputs.sops-nix.homeManagerModules.sops
      base
      graphical
    ];
  };
}
