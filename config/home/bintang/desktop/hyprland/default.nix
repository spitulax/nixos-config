{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.configs.desktop.hyprland;

  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    mapAttrsToList
    types
    lists
    mkDefault
    ;

  inherit (config.configs.env) defaultPrograms;

  run = cmd: "uwsm app -- ${cmd}";
  runTerm = cmd: run "${defaultPrograms.terminal} ${cmd}";
  runner = {
    inherit (defaultPrograms) fileManager;
    browser = run defaultPrograms.browser;
    btop = runTerm "btop";
    clipboard = run "rofi -modi \"clipboard:${../rofi/modes/clipboard.sh}\" -show clipboard";
    colourPicker = "${./scripts/colourpicker.sh}";
    command = run "rofi -show run";
    emoji = run "rofi -modi emoji -show emoji -emoji-mode copy";
    gripper = args: "gripper ${args}";
    hyprmon = args: "hyprmon ${args}";
    nvtop = runTerm "nvtop";
    runner = run "rofi -show drun";
    terminal = run defaultPrograms.terminal;
    volume = run "pwvucontrol";
    windows = run "rofi -show window";
  };
in
{
  imports = [
    ./hyprpaper.nix
  ];

  options.configs.desktop.hyprland = {
    enable = mkEnableOption "Hyprland Wayland compositor";
    monitor = mkOption {
      type = types.str;
      description = "The monitor configuration as defined in <https://wiki.hyprland.org/Configuring/Monitors/>.";
    };
  };

  config = mkIf cfg.enable {
    configs.desktop = {
      waybar.enable = mkDefault true;
      mako.enable = mkDefault true;
      rofi.enable = mkDefault true;
      hyprlock.enable = mkDefault true;
      cliphist.enable = mkDefault true;
      gammastep.enable = mkDefault true;
      easyeffects.enable = mkDefault true;
      screenshot.enable = mkDefault true;
      udiskie.enable = mkDefault true;
      warn-low-battery.enable = mkDefault true;
    };

    home.packages = with pkgs; [
      hyprpicker
      hyprpolkitagent
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd = {
        enable = false;
        variables = [ "--all" ];
      };
      package = pkgs.inputs.hyprland.hyprland;
      plugins = [
        pkgs.inputs.hyprspace.Hyprspace
      ];

      settings = {
        source = [
          "${./catppuccin-mocha.conf}"
        ];

        exec-once = [
          "[workspace special:dock silent] ${run "brave --app-id=hnpfjngllnobngcgfapefoaidbinmjnm"}"
          # Autostart this slow app so I won't have to wait for it to load when I want it to open quickly.
          "[workspace special:dock silent] ${run "dolphin"}"
        ];

        # GENERAL

        inherit (cfg) monitor;

        env = mapAttrsToList (n: v: n + "," + (toString v)) config.home.sessionVariables ++ [
          "XCURSOR_SIZE,${builtins.toString config.home.pointerCursor.size}"
          "QT_QPA_PLATFORMTHEME,qt5ct"
          "NIXOS_OZONE_WL,1"
          "_JAVA_AWT_WM_NONREPARENTING,1"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "QT_QPA_PLATFORM,wayland"
          "GDK_BACKEND,wayland"
        ];

        "$mainMod" = "SUPER";

        general = {
          gaps_in = 3;
          gaps_out = 8;
          border_size = 2;
          "col.active_border" = "0xdd$blueAlpha 0xdd$redAlpha 45deg";
          "col.inactive_border" = "0x80$surface2Alpha";
          "col.nogroup_border" = "0xdd$lavenderAlpha 0xdd$textAlpha 45deg";
          "col.nogroup_border_active" = "0x80$surface0Alpha";
          layout = "dwindle";
          allow_tearing = "false";
        };

        decoration = {
          rounding = 2;
          shadow = {
            enabled = false;
          };
          blur = {
            enabled = true;
            size = 2;
            passes = 1;
          };
        };

        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        input = {
          kb_layout = "us";
          sensitivity = 0.4;
          scroll_method = "2fg";
          follow_mouse = 1;
          mouse_refocus = false;
          repeat_delay = 300;
          touchpad = {
            natural_scroll = true;
            middle_button_emulation = false;
            tap_button_map = "lrm";
            drag_lock = true;
            tap-and-drag = true;
            scroll_factor = 0.5;
          };
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_distance = 200;
          workspace_swipe_use_r = true;
        };

        group = {
          "col.border_active" = "0xdd$blueAlpha 0xdd$redAlpha 45deg";
          "col.border_inactive" = "0x80$surface2Alpha";
          "col.border_locked_active" = "0xdd$redAlpha 0xdd$blueAlpha 45deg";
          "col.border_locked_inactive" = "0x80$surface0Alpha";
          groupbar = {
            font_family = "monospace";
            font_size = 10;
            text_color = "$base";
            "col.active" = "0xdd$blueAlpha";
            "col.inactive" = "0x80$overlay2Alpha";
            "col.locked_active" = "0xdd$redAlpha";
            "col.locked_inactive" = "0x80$overlay0Alpha";
          };
        };

        misc = {
          disable_hyprland_logo = true;
          force_default_wallpaper = 0;
          "col.splash" = "$text";
          splash_font_family = "monospace";
          disable_autoreload = true;
        };

        # LAYOUTS

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master = {
          mfact = 0.6;
        };

        # WINDOW/LAYER RULES

        windowrulev2 = [
          "tag +term, class:kitty"
          "suppressevent maximize, class:.*"
          "float, class:com\\.saivert\\.pwvucontrol"
          "float, class:qt6ct|qt5ct|nwg-look"
          "float, class:org\\.kde\\.gwenview"
          "float, class:zenity"
          "float, class:org\\.kde\\.polkit-kde-authentication-agent-1"
          "float, class:org\\.freedesktop\\.impl\\.portal\\.desktop\\.kde"
          "stayfocused, class:pinentry-.*"
        ];

        layerrule = [
          "blur, waybar"
          "blur, rofi"
          "blur, hyprshell_overview"
          "blur, hyprshell_launcher"
          # TODO: Could not get `btop` to float <https://wiki.hyprland.org/Configuring/Window-Rules/#rules>
          # This is because I can only filter btop by title but float is a static rule
        ];

        # HYPRSPACE

        "plugin:overview" = {
          workspaceActiveBorder = "0xdd$blueAlpha";
          panelHeight = 120;
          overrideGaps = false;
          switchOnDrop = true;
        };

        # KEYBINDINGS

        bind = [
          # Layouts
          "$mainMod CTRL, H, layoutmsg, preselect l"
          "$mainMod CTRL, J, layoutmsg, preselect d"
          "$mainMod CTRL, K, layoutmsg, preselect u"
          "$mainMod CTRL, L, layoutmsg, preselect r"
          "$mainMod CTRL, M, layoutmsg, swapwithmaster"
        ] ++ [
          # Core
          "$mainMod ALT, BackSpace, exit,"
          "$mainMod CTRL, Z, exec, uwsm app -- hyprlock & sleep 1 && systemctl suspend"
          "$mainMod CTRL, L, exec, pidof hyprlock || uwsm app -- hyprlock"
          "CTRL ALT, Escape, exec, hyprctl reload config-only"
          "$mainMod ALT, K, exec, hyprctl kill"
        ] ++ [
          # Hard restart waybar
          "$mainMod SHIFT, F2, exec, systemctl --user restart waybar.service"
          # Toggle waybar
          "$mainMod CTRL, F2, exec, pkill -USR1 waybar"
          # Reload waybar
          "$mainMod, F2, exec, systemctl --user reload waybar.service"
        ] ++ [
          # Workspace
          "$mainMod, P, pseudo, # dwindle"
          "$mainMod, X, togglesplit, # dwindle"
          "$mainMod, comma, workspace, -1"
          "$mainMod, period, workspace, +1"
          "$mainMod SHIFT, comma, workspace, e-1"
          "$mainMod SHIFT, period, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
          "$mainMod, mouse_down, workspace, e+1"
        ]
        ++ map (x: "$mainMod, ${toString x}, workspace, ${toString x}") (lists.range 1 9)
        ++ map (x: "$mainMod SHIFT, ${toString x}, movetoworkspace, ${toString x}") (lists.range 1 9)
        ++ map (x: "$mainMod CTRL, ${toString x}, movetoworkspacesilent, ${toString x}") (lists.range 1 9)
        ++ [
          # Monitors
          "$mainMod CTRL, comma, movecurrentworkspacetomonitor, l"
          "$mainMod CTRL, period, movecurrentworkspacetomonitor, r"
        ] ++ [
          # Window
          "$mainMod, C, killactive,"
          "$mainMod, F, togglefloating,"
          "$mainMod, M, fullscreen, 1" # maximize window
          "$mainMod SHIFT, F, fullscreen, 0" # fullscreen
          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"
          "$mainMod SHIFT, h, swapwindow, l"
          "$mainMod SHIFT, l, swapwindow, r"
          "$mainMod SHIFT, k, swapwindow, u"
          "$mainMod SHIFT, j, swapwindow, d"
          "$mainMod, A, focusurgentorlast,"
          # ] ++ [
          # Tab/Group
          # bind = $mainMod, T, togglegroup
          # bind = $mainMod ALT, P, changegroupactive, b
          # bind = $mainMod ALT, N, changegroupactive, f
          # bind = $mainMod CTRL, Tab, changegroupactive, b
          # bind = $mainMod CTRL SHIFT, Tab, changegroupactive, f
          # bind = $mainMod ALT, M, moveoutofgroup
          # bind = $mainMod ALT, L, lockactivegroup, toggle
          # bind = $mainMod ALT, D, denywindowfromgroup, toggle
        ] ++ [
          # Scratchpad
          "$mainMod, S, togglespecialworkspace, scratchpad"
          "$mainMod SHIFT, S, movetoworkspace, special:scratchpad"
          "$mainMod CTRL, S, movetoworkspacesilent, special:scratchpad"
          "$mainMod, grave, togglespecialworkspace, dock"
          "$mainMod SHIFT, grave, movetoworkspace, special:dock"
          "$mainMod CTRL, grave, movetoworkspacesilent, special:dock"
        ] ++ [
          # Launch shortcuts
          "$mainMod, V, exec, ${runner.clipboard}"
          "$mainMod, Semicolon, exec, ${runner.emoji}"
          "$mainMod SHIFT, V, exec, ${runner.volume}"
          "$mainMod ALT, Return, exec, ${defaultPrograms.terminal}" # Just in case
          "$mainMod, Return, exec, ${runner.terminal}"
          "$mainMod SHIFT, Q, exec, ${runner.terminal}"
          "$mainMod, B, exec, ${runner.browser}"
          "$mainMod, E, exec, ${runner.fileManager}"
          "$mainMod, R, exec, ${runner.runner}"
          "$mainMod, W, exec, ${runner.windows}"
          "$mainMod, Q, exec, ${runner.command}"
          "$mainMod, Escape, exec, ${runner.btop}"
          "$mainMod SHIFT, Escape, exec, ${runner.nvtop}"
          "$mainMod CTRL, P, exec, ${runner.colourPicker}"
        ] ++ [
          # Screenshot
          ",      Print, exec, ${runner.gripper "full -c"}"
          "SUPER, Print, exec, ${runner.gripper "region"}"
          "SHIFT, Print, exec, ${runner.gripper "last-region"}"
          "CTRL , Print, exec, ${runner.gripper "active-window -c"}"
          ",      Pause, exec, ${runner.gripper "full -c --copy"}"
          "SUPER, Pause, exec, ${runner.gripper "region --copy"}"
          "SHIFT, Pause, exec, ${runner.gripper "last-region --copy"}"
          "CTRL , Pause, exec, ${runner.gripper "active-window -c --copy"}"
        ] ++ [
          # Keyboard fn keys
          ",      XF86Display, exec, ${runner.hyprmon "-m auto"}"
          "SUPER, XF86Display, exec, ${runner.hyprmon "-i"}"
          ",      XF86AudioMute, exec, volume toggle"
          ",      XF86AudioMicMute, exec, volume toggle-mic"
        ] ++ [
          # Global keybinds
          "SUPER, F12, pass, class:com\\.obsproject\\.Studio"
          "SUPER SHIFT, F12, pass, class:com\\.obsproject\\.Studio"
        ] ++ [
          # Hyprspace
          "$mainMod, O, overview:toggle"
          "$mainMod SHIFT, O, overview:toggle, all"
        ];

        binde = [
          # Keyboard fn keys
          ", XF86AudioRaiseVolume, exec, volume inc"
          ", XF86AudioLowerVolume, exec, volume dec"
          ", XF86MonBrightnessUp, exec, brightness inc"
          ", XF86MonBrightnessDown, exec, brightness dec"
        ];

        bindm = [
          # Mouse
          "$mainMod, mouse:272, movewindow"
          "$mainMod SHIFT, mouse:272, resizewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
      };
    };

    # home.file = {
    # ".config/hypr/scripts" = {
    #   source = ./scripts;
    #   recursive = true;
    # };
    # ".config/hypr/catppuccin-mocha.conf".source = ./catppuccin-mocha.conf;
    # };
  };
}
