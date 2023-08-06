{ inputs }:

{
  systemPackages = with inputs.nixpkgs; [ xclip ];
}
