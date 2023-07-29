{
  inputs,
  cell,
}: {
  base = inputs.hive.load {
    inherit inputs cell;
    src = ./homeProfiles/base;
  };
  graphical = inputs.hive.load {
    inherit inputs cell;
    src = ./homeProfiles/graphical;
  };
}
