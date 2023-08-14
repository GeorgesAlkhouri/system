{ appimageTools, sources, ... }:
let
  pname = "enso";
  appimageContents = appimageTools.extractType2 {
    inherit pname;
    inherit (sources.enso-appimage) version src;
  };
in appimageTools.wrapType2 rec {
  inherit pname;
  inherit (sources.enso-appimage) version src;
  extraInstallCommands = ''
    mv $out/bin/${pname}-${version} $out/bin/${pname}
    install -m 444 -D ${appimageContents}/${pname}.desktop $out/share/applications/koodo-reader.desktop
    substituteInPlace $out/share/applications/koodo-reader.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
  '';
}
