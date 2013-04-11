# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit fdo-mime font unpacker

DESCRIPTION="ngsoft Office is an office productivity suite. This is an ALPHA
package and provides only Presentation. Use it at your own risk."
HOMEPAGE="http://www.wps.cn"
SRC_URI="${PN}_${PV}+wps+wpp~a3_i386.deb"

LICENSE="WPS-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+corefonts"

RDEPEND="
	x86? (
        	dev-libs/glib:2
        	x11-libs/libICE
        	x11-libs/libX11
        	x11-libs/libXrender
        	x11-libs/libXext
        	x11-libs/libSM
        	media-libs/fontconfig
        	media-libs/freetype
        	media-libs/jpeg:62
        	media-libs/libmng
        	sys-libs/glibc
        	sys-devel/gcc
    	)
    	amd64? (
        	app-emulation/emul-linux-x86-baselibs
        	app-emulation/emul-linux-x86-xlibs
        	app-emulation/emul-linux-x86-compat
        	multilib? (
            		sys-devel/gcc
            		sys-libs/glibc
        	)
	)
    	corefonts? ( media-fonts/corefonts )"

DEPEND="${RDEPEND}
	sys-devel/binutils"

S=${WORKDIR}

src_unpack() {
    	default_src_unpack
    	unpack ./data.tar.gz
}

src_install() {
    	insinto /usr/bin
    	dobin ${S}/usr/bin/wps
    	dobin ${S}/usr/bin/wpp
    	fperms 0755 /usr/bin/wps
    	fperms 0755 /usr/bin/wpp
    	rm -rf ${S}/usr/bin

    	insinto /usr
    	doins -r ${S}/usr/share
    	rm -rf ${S}/usr

    	insinto /
    	doins -r ${S}/opt
    	fperms 0755 /opt/kingsoft/wps-office/office6/wps
    	fperms 0755 /opt/kingsoft/wps-office/office6/wpp
}

pkg_postinst() {
        font_pkg_postinst
        fdo-mime_desktop_database_update
}

pkg_postrm() {
    	fdo-mime_desktop_database_update
}
