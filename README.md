# SuperTux88 Gentoo overlay

Current build status: [![Continuous Integration](https://github.com/SuperTux88/gentoo-overlay/workflows/CI/badge.svg)](https://github.com/SuperTux88/gentoo-overlay/actions?query=workflow%3ACI)

**use at your own risk**

## Usage

Add this to `/etc/portage/repos.conf/supertux88.conf`:

```
[supertux88]
location = /var/db/repos/supertux88/
sync-type = git
sync-uri = https://github.com/SuperTux88/gentoo-overlay.git
auto-sync = yes
```

**or**

Install using [Layman](https://wiki.gentoo.org/wiki/Layman):

```
layman -o https://raw.github.com/SuperTux88/gentoo-overlay/master/overlay.xml -f -a supertux88
```

## Packages

The following packages are available in this overlay:

* app-misc/google-cloud-sdk
  * Google Cloud SDK
  * https://cloud.google.com/sdk
* gnome-extra/gnome-tweaks
  * Same as upstream, with additional `gnome-shell` USE flag
* kde-plasma/breeze
  * Same as upstream, with additional `kde-cli-tools` USE flag
* media-gfx/flameshot
  * Powerful yet simple to use screenshot software
  * https://github.com/flameshot-org/flameshot
* media-libs/wlrobs
  * An obs-studio plugin that allows you to screen capture on wlroots based wayland compositors
  * https://hg.sr.ht/~scoopta/wlrobs
* sys-apps/skiller-ctl
  * Control the additional features (e.g., LEDs) of Sharkoon Skiller (Pro/Pro+) keyboards
  * https://github.com/anyc/skiller-ctl
* sys-apps/zenmonitor
  * Monitoring software for AMD Zen-based CPUs
  * https://github.com/ocerman/zenmonitor
* sys-kernel/it87
  * IT87 sensors module
  * https://github.com/a1wong/it87
* sys-kernel/tuxedo-wmi
  * TUXEDO WMI Treiber - Flugmodus-Taste und Tastaturbeleuchtung
  * https://www.linux-onlineshop.de/forum/index.php?page=Thread&threadID=26
* sys-kernel/zenpower
  * Linux kernel driver for reading sensors of AMD Zen family CPUs
  * https://github.com/ocerman/zenpower
* x11-apps/xfhd
  * xfhd is a utility for resizing an X window to Full HD
  * https://github.com/r41d/xfhd
