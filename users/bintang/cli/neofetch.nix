{ config
, pkgs
, ...
}: {
  home.packages = [ pkgs.neofetch ];
  home.file.".config/neofetch/config.conf".text = ''
    print_info() {
        info title
        info underline

        info "OS" distro
        info "Host" model
        info "Kernel" kernel
        info "Uptime" uptime
        info "Packages" packages
        info "Shell" shell
        info "Resolution" resolution
        info "DE" de
        info "WM" wm
        info "WM Theme" wm_theme
        # info "Theme" theme
        # info "Icons" icons
        # info "Terminal" term
        # info "Terminal Font" term_font
        info "CPU" cpu
        info "GPU" gpu
        info "Memory" memory
        # info "GPU Driver" gpu_driver
        info "Disk" disk
        # info "Battery" battery
        # info "Font" font
        # info "Song" song
        # [[ "$player" ]] && prin "Music Player" "$player"
        # info "Local IP" local_ip
        # info "Public IP" public_ip
        # info "Users" users
        # info "Locale" locale  # This only works on glibc systems.
        info cols
    }

    title_fqdn="off"
    kernel_shorthand="on"
    distro_shorthand="off"
    os_arch="on"
    uptime_shorthand="tiny"
    memory_percent="on"
    memory_unit="mib"
    package_managers="on"
    shell_path="off"
    shell_version="on"
    speed_type="bios_limit"
    speed_shorthand="on"
    cpu_brand="on"
    cpu_speed="on"
    cpu_cores="logical"
    cpu_temp="on"
    gpu_brand="on"
    gpu_type="all"
    refresh_rate="on"
    gtk_shorthand="off"
    gtk2="on"
    gtk3="on"
    public_ip_host="http://ident.me"
    public_ip_timeout=2
    local_ip_interface=('auto')
    de_version="on"
    disk_show=('/')
    disk_subtitle="mount"
    disk_percent="on"
    music_player="auto"
    song_format="%artist% - %album% - %title%"
    song_shorthand="off"
    mpc_args=()
    colors=(distro)
    bold="on"
    underline_enabled="on"
    underline_char="-"
    separator=":"
    block_range=(0 15)
    color_blocks="off"
    block_width=3
    block_height=1
    col_offset="auto"
    bar_char_elapsed="-"
    bar_char_total="="
    bar_border="on"
    bar_length=15
    bar_color_elapsed="distro"
    bar_color_total="distro"
    memory_display="none"
    battery_display="none"
    disk_display="none"
    image_backend="ascii"
    image_source="auto"
    ascii_distro="auto"
    ascii_colors=(distro)
    ascii_bold="on"
    image_loop="off"
    thumbnail_dir="\$\{XDG_CACHE_HOME:-\$\{HOME}/.cache}/thumbnails/neofetch"
    crop_mode="normal"
    crop_offset="center"
    image_size="auto"
    catimg_size="2"
    gap=3
    yoffset=0
    xoffset=0
    background_color=
    stdout="off"
  '';
}
