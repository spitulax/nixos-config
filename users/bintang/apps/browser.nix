{ config
, pkgs
, ...
}: {
  programs.brave = {
    enable = true;
    extensions = [
      { id = "kfhgpagdjjoieckminnmigmpeclkdmjm"; } # Automatic Twitch
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
      { id = "gebbhagfogifgggkldgodflihgfeippi"; } # Return YouTube Dislike
      { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock for YouTube
      { id = "pachckjkecffpdphbpmfolblodfkgbhl"; } # vidIQ Vision for YouTube
    ];
  };
}
