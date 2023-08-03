{ sources, buildGoModule, ... }:
buildGoModule {
  inherit (sources.goscrape) pname version src;
  vendorSha256 = "sha256-1Ie/xpln7xu9NmaWGn2rJvRzvrie/xF1xatSN4oL05E=";
}
