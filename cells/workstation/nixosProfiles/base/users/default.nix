{ inputs }: {
  users = {
    nixos = {
      isNormalUser = true;

      description = "nixos";

      extraGroups = [ "wheel" "docker" ];

      openssh = { authorizedKeys = { keys = [ ]; }; };

      shell = inputs.nixpkgs.nushellFull;
    };
  };
}
