{ inputs, cell }:

{
  base = inputs.hive.load {
    inherit inputs cell;

    src = ./base;
  };

  graphical = inputs.hive.load {
    inherit inputs cell;

    src = ./graphical;
  };
}
