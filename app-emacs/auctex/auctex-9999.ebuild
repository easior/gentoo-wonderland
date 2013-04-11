# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/auctex/auctex-9999.ebuild,v 1.0 2012/01/14 16:09:17 ulm Exp $

EAPI=3

inherit cvs elisp eutils latex-package autotools

DESCRIPTION="Extended support for writing, formatting and using (La)TeX, Texinfo and BibTeX files"
HOMEPAGE="http://www.gnu.org/software/auctex/"
SRC_URI=""

LICENSE="GPL-3 FDL-1.2"
SLOT="0"
KEYWORDS=""
IUSE="preview-latex"

DEPEND="virtual/latex-base
	preview-latex? (
		app-text/dvipng
		app-text/ghostscript-gpl )"
RDEPEND="${DEPEND}"

# ELISP_PATCHES="${P}-ghostscript9.patch"
TEXMF="/usr/share/texmf-site"

ECVS_SERVER="cvs.savannah.gnu.org:/sources/auctex"
ECVS_AUTH="pserver"
ECVS_MODULE="auctex"
ECVS_LOCALNAME="${P}"

src_unpack() {
	cvs_src_unpack
}

src_prepare() {
	elisp_src_prepare

	einfo "Regenerating autotools files..."
	eautoconf || die "autoconf failed"
	cd preview
	eautoconf -I.. || die "autoconf in 'preview' failed"
	cd ..
}

src_configure() {
	EMACS_NAME=emacs EMACS_FLAVOUR=emacs econf --disable-build-dir-test \
		--with-auto-dir="${EPREFIX}/var/lib/auctex" \
		--with-lispdir="${EPREFIX}${SITELISP}/${PN}" \
		--with-packagelispdir="${EPREFIX}${SITELISP}/${PN}" \
		--with-packagedatadir="${EPREFIX}${SITEETC}/${PN}" \
		--with-texmf-dir="${EPREFIX}${TEXMF}" \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		$(use_enable preview-latex preview)
}

src_compile() {
	export VARTEXFONTS="${T}"/fonts
	emake || die "emake failed"
	cd doc; emake tex-ref.pdf || die "creation of tex-ref.pdf failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
	elisp-site-file-install "${FILESDIR}/50${PN}-gentoo.el" || die
	if use preview-latex; then
		elisp-site-file-install "${FILESDIR}/60${PN}-gentoo.el" || die
	fi
	keepdir /var/lib/auctex
	dodoc ChangeLog CHANGES README RELEASE TODO FAQ INSTALL*
}

pkg_postinst() {
	# rebuild TeX-inputfiles-database
	use preview-latex && latex-package_pkg_postinst
	elisp-site-regen
}

pkg_postrm(){
	use preview-latex && latex-package_pkg_postrm
	elisp-site-regen
}
