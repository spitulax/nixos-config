{ config
, ...
}: {
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "${config.xdg.configHome}/btop/catppuccin-mocha.theme";
      theme_background = false;
      truecolor = true;
      force_tty = false;
      presets = "cpu:0:default,proc:0:default cpu:0:default,mem:0:default,net:0:default";
      vim_keys = true;
      rounded_corners = true;
      graph_symbol = "braille";
      graph_symbol_cpu = "default";
      graph_symbol_gpu = "default";
      graph_symbol_mem = "default";
      graph_symbol_net = "default";
      graph_symbol_proc = "default";
      shown_boxes = "mem net cpu proc";
      update_ms = 1000;
      proc_sorting = "memory";
      proc_reversed = false;
      proc_tree = false;
      proc_colors = true;
      proc_gradient = false;
      proc_per_core = false;
      proc_mem_bytes = true;
      proc_cpu_graphs = false;
      proc_info_smaps = false;
      proc_left = false;
      proc_filter_kernel = false;
      proc_aggregate = false;
      cpu_graph_upper = "Auto";
      cpu_graph_lower = "Auto";
      show_gpu_info = "Auto";
      cpu_invert_lower = true;
      cpu_single_graph = true;
      cpu_bottom = false;
      show_uptime = true;
      check_temp = true;
      cpu_sensor = "Auto";
      show_coretemp = true;
      cpu_core_map = "";
      temp_scale = "celsius";
      base_10_sizes = false;
      show_cpu_freq = true;
      clock_format = "%X";
      background_update = true;
      custom_cpu_name = "";
      disks_filter = "";
      mem_graphs = true;
      mem_below_net = true;
      zfs_arc_cached = true;
      show_swap = true;
      swap_disk = true;
      show_disks = true;
      only_physical = true;
      use_fstab = true;
      zfs_hide_datasets = false;
      disk_free_priv = false;
      show_io_stat = true;
      io_mode = false;
      io_graph_combined = false;
      io_graph_speeds = "";
      net_download = 32;
      net_upload = 32;
      net_auto = false;
      net_sync = true;
      net_iface = "";
      show_battery = true;
      selected_battery = "Auto";
      log_level = "WARNING";
      nvml_measure_pcie_speeds = true;
      gpu_mirror_graph = true;
      custom_gpu_name0 = "";
      custom_gpu_name1 = "";
      custom_gpu_name2 = "";
      custom_gpu_name3 = "";
      custom_gpu_name4 = "";
      custom_gpu_name5 = "";
    };
  };

  # https://github.com/catppuccin/btop/blob/main/themes/catppuccin_mocha.theme
  xdg.configFile."btop/catppuccin-mocha.theme".text = ''
    # Main background, empty for terminal default, need to be empty if you want transparent background
    theme[main_bg]="#1E1E2E"

    # Main text color
    theme[main_fg]="#CDD6F4"

    # Title color for boxes
    theme[title]="#CDD6F4"

    # Highlight color for keyboard shortcuts
    theme[hi_fg]="#89B4FA"

    # Background color of selected item in processes box
    theme[selected_bg]="#45475A"

    # Foreground color of selected item in processes box
    theme[selected_fg]="#89B4FA"

    # Color of inactive/disabled text
    theme[inactive_fg]="#7F849C"

    # Color of text appearing on top of graphs, i.e uptime and current network graph scaling
    theme[graph_text]="#F5E0DC"

    # Background color of the percentage meters
    theme[meter_bg]="#45475A"

    # Misc colors for processes box including mini cpu graphs, details memory graph and details status text
    theme[proc_misc]="#F5E0DC"

    # CPU, Memory, Network, Proc box outline colors
    theme[cpu_box]="#cba6f7" #Mauve
    theme[mem_box]="#a6e3a1" #Green
    theme[net_box]="#eba0ac" #Maroon
    theme[proc_box]="#89b4fa" #Blue

    # Box divider line and small boxes line color
    theme[div_line]="#6C7086"

    # Temperature graph color (Green -> Yellow -> Red)
    theme[temp_start]="#a6e3a1"
    theme[temp_mid]="#f9e2af"
    theme[temp_end]="#f38ba8"

    # CPU graph colors (Teal -> Lavender)
    theme[cpu_start]="#94e2d5"
    theme[cpu_mid]="#74c7ec"
    theme[cpu_end]="#b4befe"

    # Mem/Disk free meter (Mauve -> Lavender -> Blue)
    theme[free_start]="#cba6f7"
    theme[free_mid]="#b4befe"
    theme[free_end]="#89b4fa"

    # Mem/Disk cached meter (Sapphire -> Lavender)
    theme[cached_start]="#74c7ec"
    theme[cached_mid]="#89b4fa"
    theme[cached_end]="#b4befe"

    # Mem/Disk available meter (Peach -> Red)
    theme[available_start]="#fab387"
    theme[available_mid]="#eba0ac"
    theme[available_end]="#f38ba8"

    # Mem/Disk used meter (Green -> Sky)
    theme[used_start]="#a6e3a1"
    theme[used_mid]="#94e2d5"
    theme[used_end]="#89dceb"

    # Download graph colors (Peach -> Red)
    theme[download_start]="#fab387"
    theme[download_mid]="#eba0ac"
    theme[download_end]="#f38ba8"

    # Upload graph colors (Green -> Sky)
    theme[upload_start]="#a6e3a1"
    theme[upload_mid]="#94e2d5"
    theme[upload_end]="#89dceb"

    # Process box color gradient for threads, mem and cpu usage (Sapphire -> Mauve)
    theme[process_start]="#74C7EC"
    theme[process_mid]="#89DCEB"
    theme[process_end]="#cba6f7"
  '';
}
