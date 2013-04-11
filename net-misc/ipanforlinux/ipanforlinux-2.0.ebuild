# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt4-r2 eutils fdo-mime

DESCRIPTION="Cloud storage"
HOMEPAGE="https://code.google.com/p/ipanforlinux"
SRC_URI="https://ipanforlinux.googlecode.com/files/ipanforlinux-2.0.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install () {
	mkdir -p ${D}/opt/ipanforlinux/images
	cp ipangui ${D}/opt/ipanforlinux/ipangui
	cp ./images/red-monster-happy-icon.png \
		${D}/opt/ipanforlinux/images/red-monster-happy-icon.png
	mkdir -p ${D}/usr/share/pixmaps/
	cp ./images/red-monster-happy-icon.png \
		${D}/usr/share/pixmaps/ipangui.png
	mkdir -p ${D}/usr/share/applications/
	cp ${FILESDIR}/ipanforlinux.desktop \
		${D}/usr/share/applications/ipanforlinux.desktop
	mkdir -p ${D}/usr/bin
	cd ${D}/usr/bin
	ln -sf ${D}/opt/ipanforlinux/ipangui ipangui
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
