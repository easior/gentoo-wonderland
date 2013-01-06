# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit distutils

DESCRIPTION="Extensible reader/decompiler of files in CHM format (Microsoft HTML help, also known as Compiled HTML)."
HOMEPAGE="http://archmage.sourceforge.net"
SRC_URI="mirror://sourceforge/archmage/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="apache2"

DEPEND="dev-libs/chmlib
	dev-python/pychm
	apache2? ( >=dev-python/mod_python-3.0.0 )"

src_install() {
	distutils_src_install
	dodoc INSTALL

	if use apache2; then
		insinto /etc/apache2/conf/modules.d
		doins ${FILESDIR}/80_mod_chm.conf
	fi
}

pkg_postinst() {
	if use apache2; then
		einfo "To use mod_chm to open .chm files, put '-D CHM' in your APACHE2_OPTS"
		einfo
		einfo "Next use"
		einfo "  http://host/foo.chm"
		einfo "to download the .chm file and use"
		einfo "  http://host/foo.chm/ ( <-- mind the trailing slash )"
		einfo "to parse the .chm file with mod_chm."
	fi
}


