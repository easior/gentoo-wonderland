# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit elisp ruby

DESCRIPTION="Emacs evernote mode offers functions to refer and edit Evernote notes directly from Emacs."
HOMEPAGE="http://code.google.com/p/emacs-evernote-mode/"
SRC_URI="http://emacs-evernote-mode.googlecode.com/files/evernote-mode-${PV/./_}.zip"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/evernote-mode-${PV/./_}/ruby"

IUSE="anything w3m"

DEPEND=">=dev-lang/ruby-1.8
	>=app-editors/emacs-23.4"

RDEPEND="${DEPEND}
	anything? ( >=app-emacs/anything-1.3.2 )
	w3m? ( >=app-emacs/emacs-w3m-1.4 )
	>=dev-libs/openssl-1.0.0
	>=sys-libs/gdbm-1.8.3"

src_configure() {
	ruby_econf || die "ruby_econf failed"
}

src_install() {
	${RUBY} setup.rb install --prefix="${D}" \
		|| die "setup.rb install failed"
	cd ..
	mkdir -p ${D}/usr/share/emacs/site-lisp/evernote-mode
	cp evernote-mode.el	${D}/usr/share/emacs/site-lisp/evernote-mode/evernote-mode.el
	elisp-site-file-install "${FILESDIR}/50${PN}-gentoo.el" || die
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
