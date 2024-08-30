{ config
, lib
, myLib
, pkgs
, ...
}:
let
  cfg = config.configs.cli;
in
{
  imports = myLib.importIn ./.;

  options.configs.cli = {
    commonPackages = lib.mkEnableOption "common CLI packages" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.commonPackages {
    home.packages = with pkgs; [
      neofetch # I could not bother to use anything
      glow # Markdown reader
      ripgrep # faster grep
      imagemagick # image manipulation
      cloc # code line counter
      fontpreview
      dust # disk usage visualizer
      ncdu # disk usage file browser
      chafa # image visualizer
      ffmpeg
      hexyl # hex editor
      custom.scripts
      mypkgs.lexurgy
      mypkgs.crt
      jq # JSON parser
      ouch # archiving tool
      poppler_utils # PDF
    ];

    xdg.configFile = {
      "glow/glow.yml".text = ''
        style: "auto"
        local: false
        mouse: true
        pager: true
        width: 80
      '';

      "neofetch/config.conf".text = ''
        print_info() {
          prin " ''${cl0}╭──┄''${cl1}┄╌─⊙─╌┄''${cl2}┄╌─⊙─╌┄''${cl3}┄╌─⊙─╌┄''${cl4}┄╌─⊙─╌┄''${cl5}┄╌─⊙─╌┄''${cl6}┄╌─⊙─╌┄''${cl7}┄┈┈"
          info "''${cl0}│''${cl6}  ╭─" distro
          info "''${cl0}│''${cl6}  ├─" kernel
          info "''${cl0}│''${cl6}  ├─" uptime
          prin "''${cl0}│''${cl6}  ╰─" "$(timeinfo age)"
          prin "''${cl0}│"
          info "''${cl0}│''${cl4}  ╭─" users
          prin "''${cl0}│''${cl4}  ├─" "$(hostname)"
          info "''${cl0}│''${cl4}  ├─" shell
          info "''${cl0}│''${cl4}  ╰─󰏗" packages
          prin "''${cl0}│"
          info "''${cl0}│''${cl5}  ╭─" de
          info "''${cl0}│''${cl5}  ├─" term
          info "''${cl0}│''${cl5}  ├─" theme
          info "''${cl0}│''${cl5}  ╰─󰜡" icons
          prin "''${cl0}│"
          info "''${cl0}│''${cl3}  ╭─" cpu
          info "''${cl0}│''${cl3}  ├─󰍹" gpu
          info "''${cl0}│''${cl3}  ├─󰍛" memory
          info "''${cl0}│''${cl3}  ╰─" disk
          # info cols
          prin " ''${cl0}╰──┄''${cl1}┄╌─∗─╌┄''${cl2}┄╌─∗─╌┄''${cl3}┄╌─∗─╌┄''${cl4}┄╌─∗─╌┄''${cl5}┄╌─∗─╌┄''${cl6}┄╌─∗─╌┄''${cl7}┄┈┈"
        }

        # Colors
        reset="\033[0m"
        default="\033[1;39m"
        cl0="\033[1;30m"
        cl1="\033[1;31m"
        cl2="\033[1;32m"
        cl3="\033[1;33m"
        cl4="\033[1;34m"
        cl5="\033[1;35m"
        cl6="\033[1;36m"
        cl7="\033[1;37m"

        # Title
        title_fqdn="off"

        # Kernel
        kernel_shorthand="off"

        # Distro
        distro_shorthand="off"
        os_arch="off"

        # Uptime
        uptime_shorthand="tiny"

        # Memory
        memory_percent="on"
        memory_unit="mib"

        # Packages
        package_managers="on"

        # Shell
        shell_path="off"
        shell_version="on"

        # CPU
        speed_type="bios_limit"
        speed_shorthand="on"
        cpu_brand="on"
        cpu_speed="on"
        cpu_cores="logical"
        cpu_temp="off"

        # GPU
        gpu_brand="on"
        gpu_type="all"

        # Resolution
        refresh_rate="on"

        # Gtk Theme / Icons / Font
        gtk_shorthand="on"
        gtk2="off"
        gtk3="on"

        # IP Address
        public_ip_host="http://ident.me"
        public_ip_timeout=2
        local_ip_interface=('auto')

        # Desktop Environment
        de_version="on"

        # Disk
        disk_show=('/')
        disk_subtitle="none"
        disk_percent="on"

        # Song
        music_player="auto"
        song_format="%artist% - %album% - %title%"
        song_shorthand="off"
        mpc_args=()

        # Text Colors
        colors=(distro)

        # Text Options
        bold="on"
        underline_enabled="on"
        underline_char="-"
        separator=" "

        # Color Blocks
        block_range=(0 7)
        color_blocks="on"
        block_width=6
        block_height=1
        col_offset="auto"

        # Progress Bars
        bar_char_elapsed="-"
        bar_char_total="="
        bar_border="on"
        bar_length=15
        bar_color_elapsed="distro"
        bar_color_total="distro"
        memory_display="off"
        battery_display="off"
        disk_display="off"

        # Backend Settings
        image_backend="ascii"
        image_source="auto"

        # Ascii Options
        ascii_distro="auto"
        ascii_colors=(distro)
        ascii_bold="on"

        # Image Options
        image_loop="off"
        thumbnail_dir="''${XDG_CACHE_HOME:-''${HOME}/.cache}/thumbnails/neofetch"
        crop_mode="normal"
        crop_offset="center"
        image_size="auto"
        catimg_size="2"
        gap=3
        yoffset=0
        xoffset=0
        background_color=

        # Misc Options
        stdout="off"
      '';
    };
  };
}
