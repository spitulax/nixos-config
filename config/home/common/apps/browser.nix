{ config
, outputs
, lib
, ...
}:
let
  cfg = config.configs.apps.browser;
in
{
  imports = [
    outputs.homeManagerModules.webApps
  ];

  options.configs.apps.browser = {
    brave = lib.mkEnableOption "Brave Browser";
  };

  config = lib.mkIf cfg.brave {
    programs.brave = {
      enable = true;
      commandLineArgs =
        [
          "--password-store=gnome"
          "--profile-directory=Default"
          "--enable-features=AcceleratedVideoDecodeLinuxZeroCopyGL,AcceleratedVideoDecodeLinuxGL"
          # "--ignore-gpu-blocklist"
          # "--gtk-version=4"
          # "--force-device-scale-factor=1.0" # without this sometimes tab bar gets unusually big at least on KDE Plasma Wayland
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
        GitHub = "mjoklplbddabcmpepnokjaffbmgbkkgg";
        Spotify = "pjibgclleladliembfgfagdaldikeohf";
        Twitch = "comkdlimbkhemidbbpchhepidbmjpnhh";
        Discord = "pliiebkcmokkgndfalahlmimanmbjlab";
        Syncthing = "mfinobjnbcnohnemakjeccbjljpebmlm"; # on port 8384
        Anilist = "nhpkhfhppiampjblenncchhnipmeafgd";
        Bitwarden = "hophjnbpmamkldmdaeggjlnpfechpkfl";
        "Telegram Web" = "majiogicmcnmdhhlgmkahaleckhjbmlk";
        "Proton Mail" = "jnpecgipniidlgicjocehkhajgdnjekh";
        "WhatsApp Web" = "hnpfjngllnobngcgfapefoaidbinmjnm";
        Gmail = "fmgjjmmmlfnkbppncabfkddbjimcfncm";
      };
    };
  };
}
