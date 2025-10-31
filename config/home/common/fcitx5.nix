{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.fcitx5;

  # ["foo" "bar"] => { "0" = "foo"; "1" = "bar"; }
  numbered = a:
    if lib.length a == 0
    then { }
    else if lib.length a == 1
    then { "0" = lib.last a; }
    else builtins.listToAttrs (lib.map (x: lib.nameValuePair (builtins.toString x.fst) x.snd) (lib.zipLists (lib.range 0 (lib.length a - 1)) a));
in
{
  options.configs.fcitx5.enable = lib.mkEnableOption "Fcitx5";

  config = lib.mkIf cfg.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-gtk
          kde.fcitx5-qt
          fcitx5-rose-pine
          fcitx5-mozc
          kde.fcitx5-chinese-addons
        ];
        waylandFrontend = true;
        settings = {
          globalOptions = {
            "Hotkey" = {
              "EnumerateWithTriggerKeys" = true;
              "EnumerateSkipFirst" = false;
              "EnumerateGroupForwardKeys" = "";
              "EnumerateGroupBackwardKeys" = "";
              "ActivateKeys" = "";
              "DeactivateKeys" = "";
              "TogglePreedit" = "";
              "ModifierOnlyKeyTimeout" = 250;
            };
            "Hotkey/TriggerKeys" = numbered [ "Super+space" ];
            "Hotkey/AltTriggerKeys" = numbered [ "Alt_R" ];
            "Hotkey/EnumerateForwardKeys" = numbered [ "Alt+Down" ];
            "Hotkey/EnumerateBackwardKeys" = numbered [ "Alt+Up" ];
            "Hotkey/PrevPage" = numbered [ "Alt+Left" ];
            "Hotkey/NextPage" = numbered [ "Alt+Right" ];
            "Hotkey/PrevCandidate" = numbered [ "Shift+Tab" ];
            "Hotkey/NextCandidate" = numbered [ "Tab" ];
            "Behavior" = {
              "ActiveByDefault" = false;
              "resetStateWhenFocusIn" = "No";
              "ShareInputState" = "No";
              "PreeditEnabledByDefault" = true;
              "ShowInputMethodInformation" = true;
              "showInputMethodInformationWhenFocusIn" = false;
              "CompactInputMethodInformation" = true;
              "ShowFirstInputMethodInformation" = true;
              "DefaultPageSize" = 5;
              "OverrideXkbOption" = false;
              "CustomXkbOption" = "";
              "EnabledAddons" = "";
              "PreloadInputMethod" = true;
              "AllowInputMethodForPassword" = false;
              "ShowPreeditForPassword" = false;
              "AutoSavePeriod" = 30;
            };
            "Behavior/DisabledAddons" = numbered [
              "clipboard"
              "imselector"
              "quickphrase"
              "cloudpinyin"
            ];
          };
          inputMethod = {
            "GroupOrder" = numbered [ "Default" ];
            "Groups/0" = {
              "Name" = "Default";
              "Default Layout" = "au";
              "DefaultIm" = "mozc";
            };
            "Groups/0/Items/0" = {
              "Name" = "keyboard-au";
              "Layout" = "";
            };
            "Groups/0/Items/1" = {
              "Name" = "mozc";
              "Layout" = "";
            };
            "Groups/0/Items/2" = {
              "Name" = "pinyin";
              "Layout" = "";
            };
          };
          addons = {
            classicui = {
              globalSection = {
                "Vertical Candidate List" = false;
                "WheelForPaging" = true;
                "Font" = "Sans 12";
                "MenuFont" = "Sans 12";
                "TrayFont" = "Sans Bold 12";
                "TrayOutlineColor" = "#000000";
                "TrayTextColor" = "#ffffff";
                "PreferTextIcon" = false;
                "ShowLayoutNameInIcon" = true;
                "UseInputMethodLanguageToDisplayText" = true;
                "Theme" = "rose-pine";
                "DarkTheme" = "rose-pine";
                "UseDarkTheme" = true;
                "UseAccentColor" = true;
                "PerScreenDPI" = true;
                "ForceWaylandDPI" = 0;
                "EnableFractionalScale" = true;
              };
            };
            # TODO: Keyboard longpress

            # Looks like this:
            # [Entries/0]
            # Key=a
            # Enable=True
            #
            # [Entries/0/Candidates]
            # 0=à
            # 1=á
            # 2=â
            # 3=ä
            # 4=æ
            # 5=ã
            # 6=å
            # 7=ā
            #
            # [Entries/1]
            # Key=c
            # Enable=True
            #
            # [Entries/1/Candidates]
            # 0=ç
            # 1=ć
            # 2=č
            keyboard-longpress = { };
            keyboard = {
              globalSection = {
                "PageSize" = 9;
                "EnableEmoji" = true;
                "EnableQuickPhraseEmoji" = true;
                "Choose Modifier" = "Alt";
                "EnableHintByDefault" = false;
                "UseNewComposeBehavior" = true;
                "EnableLongPress" = true;
              };
              sections = {
                "PrevCandidate" = numbered [ "Shift+Tab" ];
                "NextCandidate" = numbered [ "Tab" ];
                "Hint Trigger" = numbered [ "Alt+End" ];
                "One Time Hint Trigger" = numbered [ "Alt+Shift+End" ];
                "LongPressBlocklist" = numbered [ "kitty" ];
              };
            };
            mozc = {
              globalSection = {
                "InitialMode" = "Hiragana";
                "InputState" = "Follow Global Configuration";
                "Vertical" = false;
                "ExpandMode" = "On Focus";
                "PreeditCursorPositionAtBeginning" = false;
                "ExpandKey" = "Alt+End";
              };
            };
            spell = {
              sections = {
                "ProviderOrder" = numbered [ "Presage" "Custom" "Enchant" ];
              };
            };
            pinyin = {
              globalSection = {
                "ShuangpinProfile" = "Ziranma";
                "ShowShuangpinMode" = true;
                "PageSize" = 9;
                "SpellEnabled" = true;
                "SymbolsEnabled" = true;
                "ChaiziEnabled" = true;
                "ExtBEnabled" = true;
                "CloudPinyinEnabled" = false;
                "CloudPinyinIndex" = 2;
                "CloudPinyinAnimation" = true;
                "KeepCloudPinyinPlaceHolder" = false;
                "PreeditMode" = "Composing pinyin";
                "PreeditCursorPositionAtBeginning" = true;
                "PinyinInPreedit" = false;
                "Prediction" = false;
                "PredictionSize" = 49;
                "SwitchInputMethodBehavior" = "Commit current preedit";
                "SecondCandidate" = "";
                "ThirdCandidate" = "";
                "UseKeypadAsSelection" = true;
                "BackSpaceToUnselect" = true;
                "Number of sentence" = 2;
                "LongWordLengthLimit" = 4;
                "QuickPhraseKey" = "";
                "VAsQuickphrase" = false;
                "FirstRun" = false;
              };
              sections = {
                "ForgetWord" = numbered [ "Control+7" ];
                "PrevPage" = numbered [ "Up" ];
                "NextPage" = numbered [ "Down" ];
                "PrevCandidate" = numbered [ "Shift+Tab" ];
                "NextCandidate" = numbered [ "Tab" ];
                "CurrentCandidate" = numbered [ "space" ];
                "CommitRawInput" = numbered [ "return" ];
                "ChooseCharFromPhrase" = numbered [ "bracketleft" "bracketright" ];
                "FilterByStroke" = numbered [ "grave" ];
                "QuickPhraseTriggerRegex" = numbered [ ];
                "Fuzzy" = {
                  # ue -> ve
                  "VE_UE" = true;
                  # Common Typo
                  "NG_GN" = true;
                  # Inner Segment (xian -> xi'an)
                  "Inner" = true;
                  # Inner Segment for Short Pinyin (qie -> qi'e)
                  "InnerShort" = true;
                  # Match partial finals (e -> en, eng, ei)
                  "PartialFinal" = true;
                  # Match partial shuangpin if input length is longer than 4
                  "PartialSp" = false;
                  # u <-> v
                  "V_U" = false;
                  # an <-> ang
                  "AN_ANG" = false;
                  # en <-> eng
                  "EN_ENG" = false;
                  # ian <-> iang
                  "IAN_IANG" = false;
                  # in <-> ing
                  "IN_ING" = false;
                  # u <-> ou
                  "U_OU" = false;
                  # uan <-> uang
                  "UAN_UANG" = false;
                  # c <-> ch
                  "C_CH" = false;
                  # f <-> h
                  "F_H" = false;
                  # l <-> n
                  "L_N" = false;
                  # s <-> sh
                  "S_SH" = false;
                  # z <-> zh
                  "Z_ZH" = false;
                  # Correction Layout
                  "Correction" = "None";
                };
              };
            };
          };
        };
      };
    };
  };
}
