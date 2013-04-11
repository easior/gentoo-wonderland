# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils mercurial python distutils

DESCRIPTION="the open-sourced, Gnome based digital library manager"
HOMEPAGE="http://gpapers.org/"
SRC_URI=""

LICENSE="GPL-3 FDL-1.2"
SLOT="0"
KEYWORDS=""

RDEPEND=">=app-text/pdfminer-20110515
	>=app-text/poppler-0.18.4
	>=dev-libs/glib-2.32.0
	>=x11-libs/gtk+-3.4.0
	>=x11-libs/gdk-pixbuf-2.26.0
	>=x11-libs/pango-1.30.0
	>=net-libs/libsoup-2.38.0
	>=dev-python/django-1.3.1
	>=dev-python/beautifulsoup-3.2.0
	>=dev-python/feedparser-5.1"

DEPEND="${RDEPEND}"

EHG_REPO_URI="https://code.google.com/p/gpapers/"

src_compile() {
	distutils_src_compile || die "Compile failed"
}

src_install () {
	distutils_src_install || die "Install failed"
	dodoc README AUTHORS || die 
}
