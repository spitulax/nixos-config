{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.configs.desktop.sway;

  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkDefault
    ;

  inherit (config.configs.env) defaultPrograms;

  run = cmd: cmd;
  runTerm = cmd: run "${defaultPrograms.terminal} ${cmd}";
  runner = {
    inherit (defaultPrograms) fileManager;
    browser = run defaultPrograms.browser;
    btop = runTerm "btop";
    clipboard = run "rofi -modi \"clipboard:${../rofi/modes/clipboard.sh}\" -show clipboard";
    colourPicker = "hyprpicker -a -f hex";
    command = run "rofi -show run";
    gripper = args: "gripper ${args}";
    hyprmon = args: "hyprmon ${args}";
    nvtop = runTerm "nvtop";
    runner = run "rofi -show drun";
    terminal = run defaultPrograms.terminal;
    volume = run "pwvucontrol";
    windows = run "rofi -show window";
    obsidian = run "obsidian";
  };

  # TODO: global theming
  colors = {
    base = "#191724";
    surface = "#1f1d2e";
    overlay = "#26233a";
    muted = "#6e6a86";
    subtle = "#908caa";
    text = "#e0def4";
    love = "#eb6f92";
    gold = "#f6c177";
    rose = "#ebbcba";
    pine = "#31748f";
    foam = "#9ccfd8";
    iris = "#c4a7e7";
    highlightLow = "#21202e";
    highlightMed = "#403d52";
    highlightHigh = "#524f67";
  };
in
{
  imports = [
    ./swaypaper.nix
  ];

  options.configs.desktop.sway = {
    enable = mkEnableOption "Sway Wayland compositor";
    monitor = mkOption {
      type = types.attrsOf (types.attrsOf types.str);
      description = "The monitor configuration";
    };
  };

  config = lib.mkIf cfg.enable {
    configs.desktop = {
      cliphist.enable = mkDefault true;
      gammastep.enable = mkDefault true;
      screenshot.enable = mkDefault true;
      udiskie.enable = mkDefault true;
      brightness.enable = mkDefault true;
      volume.enable = mkDefault true;
      mako = {
        enable = mkDefault true;
        simple = mkDefault true;
      };
    };

    home.packages = with pkgs; [
      hyprpicker
      hyprpolkitagent
    ];

    # TODO:
    # - Test if mako still works
    # - Swaylock
    # - Tofi `programs.tofi.enable` <https://github.com/philj56/tofi>
    # - Don't use notification, but maybe use IPC and swaybar protocol to display stuff directly on the status bar
    #   For volume, brightness and screenshot
    # - Warn low battery using swaynag (-y overlay)
    wayland.windowManager.sway = {
      enable = true;
      # checkConfig = false;
      swaynag.enable = true;
      wrapperFeatures.gtk = true;
      # TODO: Duplicated from hyprland
      extraSessionCommands = ''
        export XCURSOR_SIZE=${builtins.toString config.home.pointerCursor.size}
        export QT_QPA_PLATFORMTHEME=qt6ct
        export NIXOS_OZONE_WL=1
        export _JAVA_AWT_WM_NONREPARENTING=1
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export QT_QPA_PLATFORM=wayland
        export GDK_BACKEND=wayland
        export SDL_VIDEODRIVER=wayland
      '';
      config =
        let
          mod = "Mod4";
        in
        {
          output = cfg.monitor;
          modifier = mod;
          inherit (defaultPrograms) terminal;
          gaps = {
            outer = 5;
            inner = 3;
          };
          focus.wrapping = "force";
          workspaceAutoBackAndForth = true;
          workspaceLayout = "tabbed";

          keybindings = {
            # Core
            "--no-repeat ${mod}+alt+backspace" = "exit";
            "--no-repeat ctrl+alt+escape" = "reload";
            # Workspace
            "--no-repeat ${mod}+x" = "layout toggle split";
            "--no-repeat ${mod}+m" = "layout toggle split tabbed";
            "--no-repeat ${mod}+comma" = "workspace prev";
            "--no-repeat ${mod}+period" = "workspace next";
            "--no-repeat ${mod}+1" = "workspace 1";
            "--no-repeat ${mod}+2" = "workspace 2";
            "--no-repeat ${mod}+3" = "workspace 3";
            "--no-repeat ${mod}+4" = "workspace 4";
            "--no-repeat ${mod}+5" = "workspace 5";
            "--no-repeat ${mod}+6" = "workspace 6";
            "--no-repeat ${mod}+7" = "workspace 7";
            "--no-repeat ${mod}+8" = "workspace 8";
            "--no-repeat ${mod}+9" = "workspace 9";
            # Window
            "--no-repeat ${mod}+c" = "kill";
            "--no-repeat ${mod}+f" = "floating toggle";
            "--no-repeat ${mod}+shift+f" = "fullscreen toggle";
            "--no-repeat ${mod}+h" = "focus left";
            "--no-repeat ${mod}+j" = "focus down";
            "--no-repeat ${mod}+k" = "focus up";
            "--no-repeat ${mod}+l" = "focus right";
            "--no-repeat ${mod}+shift+1" = "move container to workspace 1";
            "--no-repeat ${mod}+shift+2" = "move container to workspace 2";
            "--no-repeat ${mod}+shift+3" = "move container to workspace 3";
            "--no-repeat ${mod}+shift+4" = "move container to workspace 4";
            "--no-repeat ${mod}+shift+5" = "move container to workspace 5";
            "--no-repeat ${mod}+shift+6" = "move container to workspace 6";
            "--no-repeat ${mod}+shift+7" = "move container to workspace 7";
            "--no-repeat ${mod}+shift+8" = "move container to workspace 8";
            "--no-repeat ${mod}+shift+9" = "move container to workspace 9";
            "--no-repeat ${mod}+shift+h" = "mark _swap, focus left, swap container with mark _swap, focus left";
            "--no-repeat ${mod}+shift+j" = "mark _swap, focus down, swap container with mark _swap, focus down";
            "--no-repeat ${mod}+shift+k" = "mark _swap, focus up, swap container with mark _swap, focus up";
            "--no-repeat ${mod}+shift+l" = "mark _swap, focus right, swap container with mark _swap, focus right";
            "--no-repeat ${mod}+shift+comma" = "move container to workspace prev";
            "--no-repeat ${mod}+shift+period" = "move container to workspace next";
            # Monitor
            "--no-repeat ${mod}+ctrl+h" = "focus output left";
            "--no-repeat ${mod}+ctrl+l" = "focus output right";
            "--no-repeat ${mod}+ctrl+comma" = "move workspace to output left";
            "--no-repeat ${mod}+ctrl+period" = "move workspace to output right";
            # Scratchpad
            "--no-repeat ${mod}+s" = "scratchpad show";
            "--no-repeat ${mod}+shift+s" = "move container to scratchpad";
            # Launch shortcuts
            "--no-repeat ${mod}+return" = "exec ${defaultPrograms.terminal}";
            "--no-repeat ${mod}+shift+q" = "exec ${defaultPrograms.terminal}";
            # "--no-repeat ${mod}+v" = "exec ${runner.clipboard}";
            "--no-repeat ${mod}+shift+v" = "exec ${runner.volume}";
            "--no-repeat ${mod}+b" = "exec ${runner.browser}";
            "--no-repeat ${mod}+e" = "exec ${runner.fileManager}";
            # "--no-repeat ${mod}+r" = "exec ${runner.runner}";
            # "--no-repeat ${mod}+w" = "exec ${runner.windows}";
            # "--no-repeat ${mod}+q" = "exec ${runner.command}";
            "--no-repeat ${mod}+escape" = "exec ${runner.btop}";
            "--no-repeat ${mod}+shift+escape" = "exec ${runner.nvtop}";
            "--no-repeat ${mod}+ctrl+p" = "exec ${runner.colourPicker}";
            "--no-repeat ${mod}+o" = "exec ${runner.obsidian}";
            # Screenshot
            "--no-repeat print" = "exec ${runner.gripper "full -c"}";
            "--no-repeat ${mod}+print" = "exec ${runner.gripper "region"}";
            "--no-repeat shift+print" = "exec ${runner.gripper "last-region"}";
            "--no-repeat ctrl+print" = "exec ${runner.gripper "active-window -c"}";
            "--no-repeat pause" = "exec ${runner.gripper "full -c --copy"}";
            "--no-repeat ${mod}+pause" = "exec ${runner.gripper "region --copy"}";
            "--no-repeat shift+pause" = "exec ${runner.gripper "last-region --copy"}";
            "--no-repeat ctrl+pause" = "exec ${runner.gripper "active-window -c --copy"}";
            # Fn keys
            # TODO: swaymon
            "--no-repeat xf86audiomute" = "exec volume toggle";
            "--no-repeat xf86audiomicmute" = "exec volume toggle-mic";
            "xf86audioraisevolume" = "exec volume inc";
            "xf86audiolowervolume" = "exec volume dec";
            "xf86monbrightnessup" = "exec brightness inc";
            "xf86monbrightnessdown" = "exec brightness dec";
          };

          # bars = [
          #   # TODO: man 5 sway-bar, man 7 swaybar-protocol
          #   {
          #     position = "top";
          #     statusCommand = "myswaybar";
          #     trayOutput = "*";
          #     colors = {
          #       background = colors.base;
          #       statusline = colors.text;
          #       separator = colors.highlightHigh;
          #       focusedWorkspace = {
          #         border = colors.love;
          #         background = colors.highlightMed;
          #         text = colors.text;
          #       };
          #       activeWorkspace = {
          #         border = colors.pine;
          #         background = colors.highlightMed;
          #         text = colors.text;
          #       };
          #       inactiveWorkspace = {
          #         border = colors.muted;
          #         background = colors.highlightLow;
          #         text = colors.text;
          #       };
          #       urgentWorkspace = {
          #         border = colors.love;
          #         background = colors.love;
          #         text = colors.text;
          #       };
          #     };
          #     extraConfig = ''
          #       icon_theme ${config.gtk.iconTheme.name}
          #     '';
          #   }
          # ];

          # TODO: Duplicated from hyprland
          input = {
            "type:keyboard" = {
              repeat_delay = "300";
              xkb_layout = "us";
            };
            "type:touchpad" = {
              accel_profile = "adaptive";
              pointer_accel = "0.4";
              drag = "enabled";
              dwt = "enabled";
              middle_emulation = "enabled";
              natural_scroll = "enabled";
              scroll_factor = "0.5";
              scroll_method = "two_finger";
              tap = "enabled";
              tap_button_map = "lrm";
            };
            "type:pointer" = {
              accel_profile = "flat";
              pointer_accel = "0.4";
              middle_emulation = "disabled";
            };
          };

          seat."*" = {
            xcursor_theme = "${config.home.pointerCursor.name} ${builtins.toString config.home.pointerCursor.size}";
          };

          colors =
            let
              genColor = col1: col2: {
                inherit (colors) text;
                background = col2;
                border = col1;
                childBorder = col1;
                indicator = col1;
              };
            in
            {
              background = colors.base;
              focused = genColor colors.love colors.highlightMed;
              focusedInactive = genColor colors.pine colors.highlightMed;
              placeholder = genColor colors.overlay colors.overlay;
              unfocused = genColor colors.muted colors.highlightLow;
              urgent = genColor colors.love colors.love;
            };
        };
      extraConfig = ''
        titlebar_border_thickness 2

        bindgesture swipe:3:right workspace prev
        bindgesture swipe:3:left workspace next

        title_align center

        for_window [app_id="com\.saivert\.pwvucontrol"] floating enable
        for_window [app_id="qt6ct|qt5ct|nwg-look"] floating enable
        for_window [app_id="org\.kde\.gwenview"] floating enable
        for_window [app_id="zenity"] floating enable
        for_window [app_id="org\.kde\.polkit-kde-authentication-agent-1"] floating enable
        for_window [app_id="pinentry-.*"] focus
      '';
    };

    home.sessionVariables = {
      # XCURSOR_SIZE = builtins.toString config.home.pointerCursor.size;
      QT_QPA_PLATFORMTHEME = lib.mkForce "qt6ct";
      #   NIXOS_OZONE_WL = "1";
      #   _JAVA_AWT_WM_NONREPARENTING = "1";
      #   QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      #   QT_QPA_PLATFORM = "wayland";
      #   GDK_BACKEND = "wayland";
      #   SDL_VIDEODRIVER = "wayland";
    };
  };
}
