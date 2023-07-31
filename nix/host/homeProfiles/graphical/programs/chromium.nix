{ inputs }:
let inherit (inputs.nixpkgs) lib;
in {
  enable = true;
  commandLineArgs = [
    "--disable-background-timer-throttling"
    "--disable-backgrounding-occluded-windows"
    "--disable-notifications"
    "--disable-smooth-scrolling"
    "--disable-speech-api"
    "--disable-speech-synthesis-api"
    "--disable-sync"
    "--disable-sync-preferences"
    "--disable-translate"
    "--disable-wake-on-wifi"
    "--enable-accelerated-video-decode"
    "--enable-parallel-downloading"
    "--url about:blank"
    "--enable-features=${
      lib.concatStringsSep "," [ "OverlayScrollbar" "VaapiVideoDecoder" ]
    }"
    "--disable-features=${
      lib.concatStringsSep "," [
        "MediaEngagementBypassAutoplayPolicies"
        "PreloadMediaEngagementData"
      ]
    }"
  ];
}
