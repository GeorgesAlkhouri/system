{ inputs }:

{
  fontDir = { enable = true; };

  packages = [ inputs.nixpkgs.nerdfonts ];
}
