<h1 align="center">spitulax's NixOS Config</h1>

This is my [NixOS](https://nixos.org/) configuration for my systems with
[Nix Flake](https://nixos.wiki/wiki/Flakes). If you want to grab something from here, feel free!

## Screenshot

![](./assets/screenshot.png)

## Components

Here are some of the programs configured in this repo.

#### Desktop

- **Display Manager**: [GDM]
- **Window Manager (Wayland)**: [Hyprland]

#### CLI Tools

- **Terminal Emulator**: [Kitty]
- **Terminal Multiplexer**: [Tmux]
- **Shell**: [Fish] [(details)](./modules/home/bintang/cli/fish)
- **Shell Prompt**: [Starship]
- **Resource Monitoring**: [Btop]

#### GUI Apps

- **Browser**: [Brave]
- **Screen Recording**: [OBS]
- **WhatsApp Client**: [ZapZap]
- **Password Manager**: [Bitwarden]
- **File Manager**: [Dolphin]
- **Screenshot**: [Gripper]
- **Media Player**: [Mpv]
- **Painting**: [Krita]
- **Image Viewer**: [Nomacs]
- **PDF Viewer**: [Zathura]

#### Development

- **Text Editor**: [Neovim] [(details)](./modules/home/bintang/nvim)
- **Some toolings**: [(details)](./modules/home/bintang/dev)

#### Misc

- **Terminal Colorschemes**: [Catppuccin]
- **GTK Theme**: [Fluent GTK Theme]
- **Qt Theme**: [Materia KDE]
- **Font**: [Iosevka] with [Nerd Fonts]
- **File Syncing**: [Syncthing]
- **Key Remapper**: [Keymapper]
- **Secret Management**: [sops.nix]

#### And More!

## Cool Dotfiles

Dotfiles by other people that massively helped my nix journey.

- <https://github.com/librephoenix/nixos-config>
- <https://github.com/jakehamilton/config>
- <https://github.com/Misterio77/nix-config>
- <https://github.com/ryan4yin/nix-config>
- <https://github.com/hlissner/dotfiles>
- <https://github.com/fufexan/dotfiles>

## To-Do

- [ ] Set up [impermanence](https://github.com/nix-community/impermanence)

[SDDM]: https://github.com/sddm/sddm
[Kitty]: https://github.com/kovidgoyal/kitty
[Fish]: https://github.com/fish-shell/fish-shell
[Starship]: https://github.com/starship/starship
[Btop]: https://github.com/aristocratos/btop
[Brave]: https://brave.com/
[OBS]: https://obsproject.com/
[ZapZap]: https://github.com/zapzap-linux/zapzap
[Bitwarden]: https://bitwarden.com/
[Neovim]: https://github.com/neovim/neovim
[Godot Engine]: https://github.com/godotengine/godot
[Catppuccin]: https://github.com/catppuccin/catppuccin
[Iosevka]: https://github.com/be5invis/Iosevka
[Nerd Fonts]: https://github.com/ryanoasis/nerd-fonts
[Syncthing]: https://github.com/syncthing/syncthing
[Keymapper]: https://github.com/houmain/keymapper
[Hyprland]: https://github.com/hyprwm/Hyprland
[Tmux]: https://github.com/tmux/tmux
[Dolphin]: https://apps.kde.org/dolphin
[Gripper]: https://github.com/spitulax/gripper
[Mpv]: https://mpv.io/
[Krita]: https://krita.org/
[Nomacs]: https://nomacs.org/
[Zathura]: https://git.pwmt.org/pwmt/zathura
[GDM]: https://wiki.gnome.org/Projects/GDM
[Fluent GTK Theme]: https://github.com/vinceliuice/Fluent-gtk-theme
[Materia KDE]: https://github.com/PapirusDevelopmentTeam/materia-kde
[sops.nix]: https://github.com/Mic92/sops-nix
