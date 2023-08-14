{ inputs }: {
  fontDir = { enable = true; };
  packages = with inputs.nixpkgs; [ (nerdfonts.override { fonts = [ "Iosevka" "IosevkaTerm" ]; }) ];
}
