# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

MY_PV=2.4
DESCRIPTION="Infrastructure and foundation classes"
HOMEPAGE="http://dune-project.org"
SRC_URI="http://www.dune-project.org/download/${PV}/${PN}-${PV}.tar.gz"

LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="fortran mpi -static"

DEPEND="dev-libs/gmp
	fortran? ( virtual/blas virtual/lapack )
	dev-util/cmake
	dev-libs/boost
	mpi? ( sys-cluster/openmpi )
	app-doc/doxygen
	media-gfx/graphviz"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-${MY_PV}

src_configure() {
	econf $(use_enable static ) \
			$(use_enable mpi parallel )
}
