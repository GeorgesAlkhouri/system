{ inputs, cell }: {
  base = inputs.hive.load {
    inherit inputs cell;
    src = ./base;
  };
}
