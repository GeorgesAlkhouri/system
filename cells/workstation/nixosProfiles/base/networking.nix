{
  hostName = "nixos";

  firewall = {
    enable = true;

    allowedTCPPorts = [ 5000 ];
    allowedUDPPorts = [ ];
  };
}
