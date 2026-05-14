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

  run = cmd: "'${cmd}'";
  runTerm = cmd: run "${defaultPrograms.terminal} ${cmd}";
  runner = {
    inherit (defaultPrograms) fileManager;
    browser = run defaultPrograms.browser;
    btop = runTerm "btop";
    clipboard = run "${./scripts/clipboard.sh}";
    colourPicker = "hyprpicker -a -f hex";
    command = run "tofi-run | xargs swaymsg exec -- kitty";
    gripper = args: "gripper ${args}";
    hyprmon = args: "hyprmon ${args}";
    nvtop = runTerm "nvtop";
    runner = run "tofi-drun | xargs swaymsg exec --";
    terminal = run defaultPrograms.terminal;
    volume = run "pwvucontrol";
    windows = run "${./scripts/windows.sh}";
    obsidian = run "obsidian";
    poweroff = run "${./scripts/poweroff.sh}";
    swaylock = run "swaylock & sleep 1 && systemctl suspend";
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
      brightness.enable = mkDefault true;
      volume.enable = mkDefault true;
      mako.enable = mkDefault true;
      tofi.enable = mkDefault true;
    };

    home.packages = with pkgs; [
      hyprpicker
      hyprpolkitagent
      swaylock
    ];

    # TODO:
    # - swaymon
    wayland.windowManager.sway = {
      enable = true;
      # checkConfig = false;
      swaynag.enable = true;
      wrapperFeatures.gtk = true;
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
            outer = 0;
            inner = 0;
          };
          focus.wrapping = "force";
          workspaceAutoBackAndForth = true;
          workspaceLayout = "tabbed";
          fonts = {
            names = [ "monospace" ];
            size = 10.0;
          };

          keybindings = {
            # Core
            "--no-repeat ${mod}+alt+q" = "exit";
            "--no-repeat ${mod}+alt+r" = "reload";
            "--no-repeat ${mod}+z" = "exec ${runner.swaylock}";
            "--no-repeat ${mod}+x" = "exec ${runner.poweroff}";
            # Workspace
            "--no-repeat ${mod}+shift+m" = "layout toggle split";
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
            "--no-repeat ${mod}+a" = "focus prev";
            "--no-repeat ${mod}+d" = "focus next";
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
            "--no-repeat ${mod}+v" = "exec ${runner.clipboard}";
            "--no-repeat ${mod}+shift+v" = "exec ${runner.volume}";
            "--no-repeat ${mod}+b" = "exec ${runner.browser}";
            "--no-repeat ${mod}+e" = "exec ${runner.fileManager}";
            "--no-repeat ${mod}+r" = "exec ${runner.runner}";
            "--no-repeat ${mod}+w" = "exec ${runner.windows}";
            "--no-repeat ${mod}+q" = "exec ${runner.command}";
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
            "--no-repeat xf86audiomute" = "exec volume toggle";
            "--no-repeat xf86audiomicmute" = "exec volume toggle-mic";
            "xf86audioraisevolume" = "exec volume inc";
            "xf86audiolowervolume" = "exec volume dec";
            "xf86monbrightnessup" = "exec brightness inc";
            "xf86monbrightnessdown" = "exec brightness dec";
          };

          bars = [
            {
              position = "bottom";
              statusCommand = "${pkgs.i3status}/bin/i3status";
              trayOutput = "*";
              fonts.size = 10.0;
              colors = {
                background = colors.base;
                statusline = colors.text;
                separator = colors.highlightHigh;
                focusedWorkspace = {
                  border = colors.iris;
                  background = colors.highlightMed;
                  text = colors.text;
                };
                activeWorkspace = {
                  border = colors.pine;
                  background = colors.highlightMed;
                  text = colors.text;
                };
                inactiveWorkspace = {
                  border = colors.muted;
                  background = colors.highlightLow;
                  text = colors.text;
                };
                urgentWorkspace = {
                  border = colors.love;
                  background = colors.love;
                  text = colors.text;
                };
              };
              extraConfig = ''
                icon_theme ${config.gtk.iconTheme.name}
              '';
            }
          ];

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
              focused = genColor colors.iris colors.highlightMed;
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

        exec_always 'systemctl --user start swaypaper.service'
      '';
    };

    xdg.configFile."tofi/common".text = ''
      font = "monospace"
      font-size = 12

      text-color = ${colors.text}

      prompt-color = ${colors.base}
      prompt-background = ${colors.love}
      prompt-background-padding = 0, 8
      prompt-background-corner-radius = 0

      placeholder-color = ${colors.text}a8
      placeholder-background = ${colors.base}
      placeholder-background-padding = 0
      placeholder-background-corner-radius = 0

      input-background = ${colors.base}
      input-background-padding = 0
      input-background-corner-radius = 0

      default-result-background = ${colors.base}
      default-result-background-padding = 0
      default-result-background-corner-radius = 0

      alternate-result-color = ${colors.subtle}
      alternate-result-background = ${colors.base}
      alternate-result-background-padding = 0
      alternate-result-background-corner-radius = 0

      selection-color = ${colors.base}
      selection-background = ${colors.love}
      selection-background-padding = 0, 4
      selection-background-corner-radius = 0
      selection-match-color = ${colors.base}

      text-cursor = true
      text-cursor-style = block

      prompt-text = "RUN"
      prompt-padding = 16
      result-spacing = 20
      horizontal = true
      min-input-width = 128

      width = 100%
      height = 24
      background-color = ${colors.base}
      outline-width = 0
      border-width = 0
      padding-top = 0
      padding-bottom = 0
      padding-left = 0
      padding-right = 0

      anchor = bottom
    '';

    xdg.configFile."tofi/config".text = ''
      include = "./common"
    '';

    xdg.configFile."tofi/vertical".text = ''
      include = "./common"

      anchor = bottom
      result-spacing = 4
      width = 100%
      height = 256
      horizontal = false
    '';

    xdg.configFile."i3status/config".text = ''
      general {
          output_format = "i3bar"
          colors = true
          interval = 1
      }

      order += "volume master"
      order += "ethernet enp0s31f6"
      order += "wireless wlp1s0"
      order += "battery 0"
      order += "load"
      #order += "cpu_temperature 0"
      order += "memory"
      order += "time"
      order += "tztime utc"

      wireless wlp1s0 {
          format_up = "[W] %essid %frequency %quality %ip"
          format_down = "[W]"
          format_quality = "%d%%"
      }

      ethernet enp0s31f6 {
          format_up = "[E] %ip"
          format_down = "[E]"
      }

      battery 0 {
          format = "[B] %status %percentage"
          format_down = "[B]"
          low_threshold = 20
          status_chr = "+"
          status_bat = "-"
          status_unk = "?"
          status_full = "~"
          status_idle = "@"
          format_percentage = "%.00f%s"
          last_full_capacity = true
      }

      load {
          format = "[C] %1min"
          #separator = false
          #separator_block_width = 0
      }
      cpu_temperature 0 {
          format = " %degrees°C"
          path = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp1_input"
      }

      memory {
          format = "[M] %used %percentage_used"
          decimals = 2
      }

      time {
          format = "%a %m/%d %H:%M:%S %Z"
          separator = false
          separator_block_width = 0
      }
      tztime utc {
          format = " %m/%d %H:%M:%S %Z"
          timezone = "Etc/UTC"
          hide_if_equals_localtime = true
          separator = false
      }

      volume master {
          format = "[V] %volume"
          format_muted = "[V] %volume M"
      }
    '';

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
