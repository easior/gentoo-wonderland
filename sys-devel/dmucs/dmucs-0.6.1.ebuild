# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="a Distributed Multi-User Compilation System"
HOMEPAGE="http://dmucs.sourceforge.net"
SRC_URI="http://prdownloads.sourceforge.net/dmucs/dmucs-${PV}.tar.bz2?download"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=""
RDEPEND="${DEPEND} sys-devel/distcc"
