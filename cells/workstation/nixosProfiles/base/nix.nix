{ inputs }: {
  package = inputs.nixpkgs.lib.mkForce inputs.nixpkgs.nixUnstable;
  settings = {
    auto-optimise-store = true;
    experimental-features = "nix-command flakes";
    trusted-users = [ "root" "nixos" ];
    allow-dirty = true;
    warn-dirty = false;
  };
}
