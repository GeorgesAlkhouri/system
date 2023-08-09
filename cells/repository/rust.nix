{ inputs, cell, }: {
  toolchain = inputs.fenix.packages.combine [
    inputs.fenix.packages.rust-analyzer
    inputs.fenix.packages.targets.wasm32-unknown-unknown.latest.rust-std
  ];
}
