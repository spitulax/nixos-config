{ config
, outputs
, lib
, ...
}: {
  imports = [
    outputs.homeManagerModules.webApps
  ];

  programs.brave = {
    enable = true;
    commandLineArgs =
      let
        # PLEASE, IF YOU ONLY INCLUDE VaapiVideoDecodeLinuxGL THE VIDEO DECODING WORKS FINE UNTIL YOU ADD MORE ONTO THIS FLAG
        enabledFeatures = [
          "VaapiVideoDecodeLinuxGL"
          # "VaapiIgnoreDriverChecks"
          # "UseOzonePlatform"
        ];
      in
      [
        "--enable-features=${lib.concatStringsSep "," enabledFeatures}"
        "--password-store=gnome"
        "--profile-directory=Default"
        "--ozone-platform=wayland"
        # "--ignore-gpu-blocklist"
        "--enable-wayland-ime"
        # "--gtk-version=4"
        "--force-device-scale-factor=1.0" # without this sometimes tab bar gets unusually big at least on KDE Plasma Wayland
      ];
    extensions = [
      { id = "kfhgpagdjjoieckminnmigmpeclkdmjm"; } # Automatic Twitch
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
      { id = "gebbhagfogifgggkldgodflihgfeippi"; } # Return YouTube Dislike
      { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock for YouTube
    ];
  };

  programs.brave.webApps = {
    enable = true;
    inherit (config.programs.brave) commandLineArgs package;
    # You must install it in your profile first and I don't know how to automate that
    # I suppose I can use the --app switch instead but it's kinda meh
    apps = {
      YouTube = {
        id = "agimnkijcaahngcdmfeangaknmldooml";
        actions = {
          Subscriptions = "https://www.youtube.com/feed/subscriptions?feature=app_shortcuts";
        };
      };
      GitHub.id = "mjoklplbddabcmpepnokjaffbmgbkkgg";
      Spotify.id = "pjibgclleladliembfgfagdaldikeohf";
      Twitch.id = "comkdlimbkhemidbbpchhepidbmjpnhh";
      Discord.id = "pliiebkcmokkgndfalahlmimanmbjlab";
      Syncthing.id = "mfinobjnbcnohnemakjeccbjljpebmlm"; # on port 8384
      Anilist.id = "nhpkhfhppiampjblenncchhnipmeafgd";
      Bitwarden.id = "hophjnbpmamkldmdaeggjlnpfechpkfl";
      "Telegram Web".id = "majiogicmcnmdhhlgmkahaleckhjbmlk";
      "Proton Mail".id = "jnpecgipniidlgicjocehkhajgdnjekh";
      "WhatsApp Web".id = "hnpfjngllnobngcgfapefoaidbinmjnm";
    };
  };
}
