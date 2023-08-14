{ inputs, cell }: {
  enable = true;
  configFile = { source = inputs.self + "/configs/nushell/config.nu"; };
  extraConfig = ''
    register ${cell.packages.nu-plugin-formats}/bin/nu_plugin_formats;
    register ${cell.packages.nu-plugin-from-parquet}/bin/nu_plugin_from_parquet;
    register ${cell.packages.nu-plugin-gstat}/bin/nu_plugin_gstat;
    register ${cell.packages.nu-plugin-json-path}/bin/nu_plugin_json_path;
    register ${cell.packages.nu-plugin-query}/bin/nu_plugin_query;
    register ${cell.packages.nu-plugin-regex}/bin/nu_plugin_regex;
    use ${cell.packages.nu-scripts}/share/nu_scripts/custom-completions/btm/btm-completions.nu *
    use ${cell.packages.nu-scripts}/share/nu_scripts/custom-completions/cargo/cargo-completions.nu *
    use ${cell.packages.nu-scripts}/share/nu_scripts/custom-completions/git/git-completions.nu *
    use ${cell.packages.nu-scripts}/share/nu_scripts/custom-completions/nix/nix-completions.nu *
    use ${cell.packages.nu-scripts}/share/nu_scripts/custom-completions/tealdeer/tldr-completions.nu *
  '';
  envFile = { source = inputs.self + "/configs/nushell/env.nu"; };
  loginFile = { source = inputs.self + "/configs/nushell/login.nu"; };
}
