{ inputs, cell }:

{
  user = {
    services = {
      fs-server-archive = {
        Unit = { Description = "Archive File Server"; };

        Service = {
          ExecStart = "${inputs.nixpkgs.dufs}/bin/dufs --allow-all --port 5000";

          WorkingDirectory =
            "${cell.homeProfiles.base.home.homeDirectory}/shared";

          Restart = "on-failure";
        };

        Install = { WantedBy = [ "default.target" ]; };
      };
    };

    startServices = "sd-switch";
  };
}
