{ inputs, cell }: {
  default = {
    bee = {
      inherit (inputs.nixpkgs) system;
      pkgs = import inputs.nixpkgs {
        inherit (inputs.nixpkgs) system;
        config = {
          allowUnfreePredicate = pkg:
            builtins.elem (inputs.nixpkgs.lib.getName pkg) [
              "nvidia-x11"
              "nvidia-settings"
              "nvidia-persistenced"
            ];
        };
      };
      home = inputs.home-manager;
    };
    imports = [
      ./hardware-configuration.nix
      inputs.sops-nix.nixosModules.sops
      inputs.home-manager.nixosModules.home-manager
      cell.nixosProfiles.base
    ];
    home-manager.users.nixos = {
      imports = [
        inputs.sops-nix.homeManagerModules.sops
        cell.homeProfiles.base
        cell.homeProfiles.graphical
      ];
    };
  };
}
