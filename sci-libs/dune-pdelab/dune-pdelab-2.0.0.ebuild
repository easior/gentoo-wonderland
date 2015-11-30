# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

MY_PV=2.0
DESCRIPTION="A discretisation module based on DUNE"
HOMEPAGE="http://www.dune-project.org/"
SRC_URI="http://www.dune-project.org/download/${MY_PV}/${PN}-${PV}.tar.gz"

LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="fortran mpi -static"

DEPEND="dev-utils/cmake
		dev-cpp/eigen
		sci-libs/dune-typetree[mpi=,fortran=,static(-)=]
		sci-libs/dune-localfunctions[mpi=,fortran=,static(-)=]
		sci-libs/dune-istl[mpi=,fortran=,static(-)=]
		app-doc/doxygen
		media-gfx/graphviz"
RDEPEND="${DEPEND}"

src_configure() {
	 #--enable-shared --disable-static
	econf $(use_enable !static ) \
			$(use_enable mpi parallel ) # \
			 # --with-metis=%{_prefix} $(use_with metis )\
			 # --with-superlu=%{_prefix}
}
