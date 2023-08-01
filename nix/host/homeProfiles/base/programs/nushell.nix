{ inputs, cell }: {
  enable = true;
  configFile = {
    source = inputs.self + "/nix/host/presets/nushell/config.nu";
  };

  extraConfig = ''
    use ${cell.packages.nu-scripts}/share/nu_scripts/custom-completions/btm/btm-completions.nu *
    use ${cell.packages.nu-scripts}/share/nu_scripts/custom-completions/cargo/cargo-completions.nu *
    use ${cell.packages.nu-scripts}/share/nu_scripts/custom-completions/git/git-completions.nu *
    use ${cell.packages.nu-scripts}/share/nu_scripts/custom-completions/nix/nix-completions.nu *
    use ${cell.packages.nu-scripts}/share/nu_scripts/custom-completions/tealdeer/tldr-completions.nu *
  '';

  envFile = { source = inputs.self + "/nix/host/presets/nushell/env.nu"; };
  loginFile = { source = inputs.self + "/nix/host/presets/nushell/login.nu"; };
}
