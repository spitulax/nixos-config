{ config
, pkgs
, ...
}: {
  programs.brave = {
    enable = true;
    commandLineArgs = [
      "--enable-features=VaapiVideoDecodeLinuxGL" # NB: hardware video encoding is not available on Linux
      "--password-store=gnome"
      "--profile-directory=Default"
      "--ozone-platform-hint=wayland"
      # "--ignore-gpu-blocklist"
      "--enable-wayland-ime"
      "--gtk-version=4"
      "--force-device-scale-factor=1.0" # without this sometimes tab bar gets unusually big at least on KDE Plasma Wayland
    ];
    extensions = [
      { id = "kfhgpagdjjoieckminnmigmpeclkdmjm"; } # Automatic Twitch
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
      { id = "gebbhagfogifgggkldgodflihgfeippi"; } # Return YouTube Dislike
      { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock for YouTube
      { id = "pachckjkecffpdphbpmfolblodfkgbhl"; } # vidIQ Vision for YouTube
    ];
  };

  programs.chromium.webApps = {
    enable = true;
    defaultBrowserName = "brave";
    defaultBrowserExec = "${pkgs.brave}/opt/brave.com/brave/brave-browser";
    defaultProfile = "Default";
    # You must install it in your profile first and I don't know how to automate that
    # I suppose I can use the --app switch instead but it's kinda meh
    apps = [
      {
        name = "GitHub";
        id = "mjoklplbddabcmpepnokjaffbmgbkkgg";
      }
      {
        name = "YouTube";
        id = "agimnkijcaahngcdmfeangaknmldooml";
        actions = {
          "Subscriptions".launchUrl = "https://www.youtube.com/feed/subscriptions?feature=app_shortcuts";
        };
      }
      {
        name = "Spotify";
        id = "pjibgclleladliembfgfagdaldikeohf";
      }
      {
        name = "Twitch";
        id = "comkdlimbkhemidbbpchhepidbmjpnhh";
      }
      {
        name = "Discord";
        id = "pliiebkcmokkgndfalahlmimanmbjlab";
      }
      {
        name = "Syncthing";
        id = "mfinobjnbcnohnemakjeccbjljpebmlm"; # on port 8384
      }
      {
        name = "Anilist";
        id = "nhpkhfhppiampjblenncchhnipmeafgd";
      }
    ];
  };
}
