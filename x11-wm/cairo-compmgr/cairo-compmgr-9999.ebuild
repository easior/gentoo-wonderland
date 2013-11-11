# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools gnome2 git-2

EGIT_REPO_URI="git://git.tuxfamily.org/gitroot/ccm/cairocompmgr.git"

DESCRIPTION="A versatile and extensible compositing manager which uses cairo for rendering"
HOMEPAGE="http://cairo-compmgr.tuxfamily.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gconf"

RDEPEND="x11-libs/gtk+:2
	x11-libs/cairo
	x11-libs/pixman
	=dev-lang/vala-9999
	gconf? ( gnome-base/gconf:2 )"
DEPEND="${RDEPEND}
	>=x11-proto/glproto-1.4.9"
PDEPEND="app-admin/eselect-vala"

#AT_M4DIR="."
#EGIT_BOOTSTRAP="eautoreconf"

src_prepare() {
	#AM_OPTS="-fi" eautoreconf
	#_elibtoolize
	./autogen.sh
}

pkg_setup() {
	G2CONF="${G2CONF}
			$(use_enable gconf)
			$(use_enable gconf schemas-install)"
}

src_compile() {
	emake -j1
}