{ config
, pkgs
, ...
}: {
  programs.brave = {
    enable = true;
    commandLineArgs = [
      "--enable-features=VaapiVideoDecodeLinuxGL"
      "--password-store=gnome"
      "--ignore-gpu-blocklist"
      "--profile-directory=Default"
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
    ];
  };
}
