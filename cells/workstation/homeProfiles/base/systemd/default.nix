{ inputs, cell }: {
  user = {
    services = {
      # fs-server-archive = {
      #   Unit = { Description = "Archive File Server"; };
      #   Service = {
      #     ExecStart = "${inputs.nixpkgs.dufs}/bin/dufs --allow-all --port 5000";
      #     WorkingDirectory =
      #       "${cell.homeProfiles.base.home.homeDirectory}/shared";
      #     Restart = "on-failure";
      #   };
      #   Install = { WantedBy = [ "default.target" ]; };
      # };
      # browser-controller = {
      #   Unit = { Description = "Archive File Server"; };
      #   Service = {
      #     ExecStart = "${inputs.nixpkgs.dufs}/bin/dufs --allow-all --port 5000";
      #     WorkingDirectory =
      #       "${cell.homeProfiles.base.home.homeDirectory}/shared";
      #     Restart = "on-failure";
      #   };
      #   Install = { WantedBy = [ "default.target" ]; };
      # };
      # llama-inference = {
      #   Unit = { Description = "Archive File Server"; };
      #   Service = {
      #     ExecStart = "${inputs.nixpkgs.dufs}/bin/dufs --allow-all --port 5000";
      #     WorkingDirectory =
      #       "${cell.homeProfiles.base.home.homeDirectory}/shared";
      #     Restart = "on-failure";
      #   };
      #   Install = { WantedBy = [ "default.target" ]; };
      # };
      # llama-embedding = {
      #   Unit = { Description = "Archive File Server"; };
      #   Service = {
      #     ExecStart = "${inputs.nixpkgs.dufs}/bin/dufs --allow-all --port 5000";
      #     WorkingDirectory =
      #       "${cell.homeProfiles.base.home.homeDirectory}/shared";
      #     Restart = "on-failure";
      #   };
      #   Install = { WantedBy = [ "default.target" ]; };
      # };
      # terminusdb-semantic-indexer = {
      #   Unit = { Description = "Archive File Server"; };
      #   Service = {
      #     ExecStart = "${inputs.nixpkgs.dufs}/bin/dufs --allow-all --port 5000";
      #     WorkingDirectory =
      #       "${cell.homeProfiles.base.home.homeDirectory}/shared";
      #     Restart = "on-failure";
      #   };
      #   Install = { WantedBy = [ "default.target" ]; };
      # };
      # terminusdb = {
      #   Unit = { Description = "Archive File Server"; };
      #   Service = {
      #     ExecStart = "${inputs.nixpkgs.dufs}/bin/dufs --allow-all --port 5000";
      #     WorkingDirectory =
      #       "${cell.homeProfiles.base.home.homeDirectory}/shared";
      #     Restart = "on-failure";
      #   };
      #   Install = { WantedBy = [ "default.target" ]; };
      # };
    };
    startServices = "sd-switch";
  };
}
