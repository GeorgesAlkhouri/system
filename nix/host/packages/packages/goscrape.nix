{ sources, buildGoModule, ... }:
buildGoModule { inherit (sources.goscrape) pname version src; }
