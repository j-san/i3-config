
Packages
--------

This is a config files of my tuned developper desktop environment based on i3. Focused on performance, lightweight and efficiency. Thunar for file manager, urxvt for temrminal, conky, dropbox and some other awsome stuff. I currently run it on Arch Linux but also work on other distributions in difference of package names.


install
-------

Clone the config

    git clone https://github.com/j-san/i3-config.git ~/.i3

And install i3 and following packages. After that, reboot.


## i3 desktop
    i3 i3lock i3status synapse dunst feh conky conky-lua
    bash-completion xss-lock (AUR)


## Login manager
    slim


## Temrinal
    rxvt-unicode urxvt-perls


## Laptop stuff
    acpi


## File manager
    thunar thunar-volman thunar-dropbox
    udiskie udisks2 ntfs-3g dropbox file-roller
    gvfs gvfs-smb gvfs-afp gvfs-afc sshfs


## Tools
    meld sublime-text git mercurial dia pencil gnumeric libreoffice
    evolution evolution-exchange dnsutils
    aspell aspell-en aspell-{your language}


## Media and Sounds
    alsa-utils
    smplayer amarok firefox flashplugins
    gstreamer gst-libav gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad
    gstreamer0.10-base-plugins gstreamer0.10-good-plugins gstreamer0.10-bad-plugins gstreamer0.10-ugly-plugins
    # taglib taglib-extras celt xvidcore ffmpeg


```
echo -e "\nsource ~/.i3/bashrc" >> ~/.bashrc

xdg-mime default Thunar-folder-handler.desktop inode/directory
```

## Control

Mod is the Windows or Mac button.

| Shortcut                       | Action                                                  |
| ------------------------------ | ------------------------------------------------------- |
| Mod + d                        | Start a program (Synapse)                               |
| Mod + Enter                    | Start terminal                                          |
| Mod + Shift + d                | Open file manager                                       |
| Mod + q                        | Close current window                                    |
| Mod + Shift + q                | Exit mode                                               |
| Mod + Arrows                   | Navigate between windows                                |
| Mod + Shift + Arrows           | Move window                                             |
| Mod + 1-9                      | Change workspace (not with numpad)                      |
| Mod + Control + Shift + Arrows | Move workspace (multi-screen)                           |
| Mod + r                        | Resize mode                                             |
| Mod + z, Mod + e, Mod + s      | Switch window disposition mode                          |
| Mod + h, Mod + v               | Switch new window position mode (horizontal / vertical) |
