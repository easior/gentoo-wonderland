# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# The EAPI variable tells the ebuild format in use.
EAPI=4

# inherit lists eclasses to inherit functions from.
inherit elisp ruby subversion

DESCRIPTION="Emacs evernote mode offers functions to refer and edit Evernote notes directly from Emacs."
HOMEPAGE="http://code.google.com/p/emacs-evernote-mode/"
SRC_URI=""
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

IUSE="anything w3m"

# Build-time and run-time dependencies.
DEPEND=">=dev-lang/ruby-1.8
	>=app-editors/emacs-23.4"
RDEPEND="${DEPEND}
	anything? ( >=app-emacs/anything-1.3.2 )
	w3m? ( >=app-emacs/emacs-w3m-1.4 )
	>=dev-libs/openssl-1.0.0
	>=sys-libs/gdbm-1.8.3"

ESVN_PROJECT="evernote-mode"
ESVN_REPO_URI="http://emacs-evernote-mode.googlecode.com/svn/trunk"
ESVN_USER="emacs-evernote-mode-read-only"

src_configure() {
	cd ruby
	ruby_econf || die
}

src_compile() {
	cd ruby
	ruby_emake || die
}

src_install() {
	cd ruby
	ruby_einstall || die
	cd ..
	mkdir -p ${D}/usr/share/emacs/site-lisp/evernote-mode
	cp evernote-mode.el	${D}/usr/share/emacs/site-lisp/evernote-mode/evernote-mode.el
	elisp-site-file-install "${FILESDIR}/50${PN}-gentoo.el" || die
	cd doc
	dodoc readme*.txt readme*.html readme*.org || die
}

pkg_postinst() {
	elisp-site-regen

	elog "Some optional features may require installation of additional"
	elog "you can use this username as default."
	elog "(setq evernote-username '<your evernote user name>')"
	elog "(setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8"))"
	elog "packages, like app-portage/gentoolkit-dev for echangelog."
	elog "(add-to-list 'anything-sources anything-c-source-evernote-title)"
}
