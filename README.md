Gentoo Wonderland
==============

Introduction
--------------
This is a local portage overlay of mine. There contain ebuild
files frequently used by me in this repository. Lots of them
come from the internet with minor modifications. The remnants
of them are written by me. Anyone, who wants any part of them,
could feel free to use them with his/her own taste.

I should thank **RichardGv**, **Havanna**, **stlifey** et.al. for
their kindly, warmly helps.

Installation
--------------
* Manually Management
```sh
$ sudo mkdir -p /usr/local/portage/
$ cd /usr/local/portage
$ sudo git clone http://github.com/easior/gentoo-wonderland.git
$ sudo echo PORTDIR_OVERLAY="${PORTDIR_OVERLAY} /usr/local/portage/gentoo-wonderland" >> /etc/portage/make.conf
```

* Management by layman
```sh
$ sudo sed -i 's/^#overlay_defs : \/etc\/layman\/overlays/overlay_defs : \/etc\/layman\/overlays/' /etc/layman/layman.cfg
$ sudo mkdir -p /etc/layman/overlays
$ sudo wget https://raw.github.com/easior/gentoo-wonderland/master/repo.xml -O /etc/layman/overlays/gentoo-wonderland.xml
$ sudo layman -S
$ sudo layman -f -a gentoo-wonderland
```
