{
  hostName = "nixos";
  firewall = {
    allowedTCPPorts = [ 5000 ];
    allowedUDPPorts = [ ];
    enable = true;
  };
}
