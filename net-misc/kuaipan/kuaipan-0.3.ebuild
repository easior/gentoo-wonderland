# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit fdo-mime eutils unpacker versionator

MY_PN="kuaipan4uk"
MY_PRV=13
MY_PV=$(get_version_component_range 1-2)
MY_P="${MY_PN}_${MY_PRV}_${MY_PV}"

DESCRIPTION="kingsoft kuaipan for ubuntukylin"
HOMEPAGE="https://launchpad.net/kuaipan4uk"
SRC_URI="x86? ( http://www.ubuntukylin.com/downloads/files/${MY_P}_i386.deb )
         amd64? ( http://www.ubuntukylin.com/downloads/files/${MY_P}_amd64.deb )"

LICENSE="WPS-EULA"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="
        >=dev-libs/boost-1.54.0[threads(+)]
        dev-libs/crypto++
        dev-libs/glib:2
        dev-libs/openssl:0
        dev-qt/qtcore
        dev-qt/qtgui
        media-libs/fontconfig
        media-libs/freetype
        media-libs/libpng:0
        net-misc/curl[ssl(+)]"
#dev-libs/libiconv

RDEPEND="${DEPEND}"

S=${WORKDIR}

src_install() {
	exeinto /usr/bin
	exeopts -m0755
	doexe ${S}/usr/bin/kuaipan4uk
	doexe ${S}/usr/bin/kuaipan4uk_script

	insinto /usr
	doins -r ${S}/usr/share

	insinto /
        rm ${S}/usr/lib/libboost*
        rm ${S}/usr/lib/libiconv.{so,la}
        rm ${S}/usr/lib/libiconv.so.2
        rm ${S}/usr/lib/libxlive.so
        rm ${S}/usr/lib/libxlive.so.1
        rm ${S}/usr/lib/libxlive.so.1.0
	dolib ${S}/usr/lib/*
        dosym libiconv.so.2.5.1 /usr/lib/libiconv.so
        dosym libiconv.so.2.5.1 /usr/lib/libiconv.so.2
        dosym libxlive.so.1.0.0 /usr/lib/libxlive.so
        dosym libxlive.so.1.0.0 /usr/lib/libxlive.so.1
        dosym libxlive.so.1.0.0 /usr/lib/libxlive.so.1.0
}

pkg_postinst() {
	fdo-mime_desktop_database_update
        ln -s /usr/lib/libcryptopp.so /usr/lib/libcrypto++.so.9
}

pkg_postrm() {
        rm /usr/lib/libcrypto++.so.9
	fdo-mime_desktop_database_update
}
