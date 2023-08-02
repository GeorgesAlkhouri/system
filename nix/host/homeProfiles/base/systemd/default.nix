{ inputs, cell }: {
  user = {
    services = {
      configs = {
        Install.WantedBy = [ "default.target" ];
        Service.ExecStart =
          "${inputs.nixpkgs.dufs}/bin/dufs --allow-all --port 5000";
        Service.WorkingDirectory =
          "${cell.homeProfiles.base.home.homeDirectory}/shared";
        Unit.Description = "Archive";
      };
    };
    startServices = "sd-switch";
  };
}
