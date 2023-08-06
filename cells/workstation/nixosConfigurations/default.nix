{ inputs, cell }:

{
  default = {
    bee = {
      inherit (inputs.nixpkgs) system;

      pkgs = import inputs.nixpkgs {
        inherit (inputs.nixpkgs) system;

        config = { allowUnfree = true; };
      };

      home = inputs.home;
    };

    imports = with cell.nixosProfiles; [
      ./hardware-configuration.nix

      inputs.sops-nix.nixosModules.sops
      inputs.home.nixosModules.home-manager

      base
    ];

    home-manager.users.nixos = {
      imports = with cell.homeProfiles; [
        inputs.sops-nix.homeManagerModules.sops

        base
        graphical
      ];
    };
  };
}
