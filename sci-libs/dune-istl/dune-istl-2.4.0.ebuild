# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="An iterative solver template library for DUNE"
HOMEPAGE="http://www.dune-project.org/"
SRC_URI="http://www.dune-project.org/download/${PV}/${PN}-${PV}.tar.gz"

LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="fortran mpi -static"

DEPEND="dev-libs/boost
		dev-libs/gmp
		dev-utils/cmake
		dev-utils/pkgconfig
		sys-devel/libtool
		sci-libs/dune-common[mpi=,fortran=,static(-)=]
		# sci-libs/metis
		# sci-libs/superlu || sci-libs/umfpack
		app-doc/doxygen
		media-gfx/graphviz"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable !static ) \
			$(use_enable mpi parallel )
	# \
	# 		 --with-metis=%{_prefix} \
	# 		 --with-superlu=%{_prefix}
}
