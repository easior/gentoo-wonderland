# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

MY_PV=2.4
DESCRIPTION="Grid management module for DUNE"
HOMEPAGE="http://www.dune-project.org/"
SRC_URI="http://www.dune-project.org/download/${PV}/${PN}-${PV}.tar.gz"

LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="fortran mpi -static X"

DEPEND="dev-util/cmake
	sci-libs/dune-common[mpi=,fortran=,static(-)=]
	sci-libs/dune-geometry[mpi=,fortran=,static(-)=]
	app-doc/doxygen
	media-gfx/graphviz"
	#sci-mathematics/alberta
	# mesa-libOSMesa
	# psurface
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-${MY_PV}

src_configure() {
	econf $(use_enable static ) \
			 $(use_enable mpi parallel) \
			 $(use_with X x ) \
			 --without-alugrid \
			 --without--ug  \
			 --without-amiramesh
}
