# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="ConTeXt Minimals Installation"
HOMEPAGE="http://wiki.contextgarden.net"
SRC_URI="http://minimals.contextgarden.net/setup/first-setup.sh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~ia64"
IUSE=""

DEPEND=">=net-misc/rsync-3.0.6
dev-lang/ruby"
RDEPEND="${DEPEND}"

src_unpack() {
	sh ${DISTDIR}/first-setup.sh
}

src_install() {
	mkdir -p ${D}/opt/${PN}
	mkdir -p ${D}/opt/${PN}/bin
	mkdir -p ${D}/usr/sbin
	mkdir -p ${D}/usr/bin
	mkdir -p ${D}/etc/${PN}/web2c
	echo "TEXROOT=/opt/${PN}/tex" > ${D}/etc/profile.d/context.sh
	case ${ARCH} in \
		x86) echo "TEXMFOS=\$TEXROOT/texmf-linux" >> ${D}/etc/profile.d/context.sh ;; \
		amd64|ia64) echo "TEXMFOS=\$TEXROOT/texmf-linux-64" >> ${D}/etc/profile.d/context.sh ;; \
		ppc) echo "\$TEXROOT/texmf-linux-ppc" >> ${D}/etc/profile.d/context.sh ;; \
		*) die "Your system is unfortunately not supported" ;; \
	esac
	cp ${FILESDIR}/cont-sys.tex ${D}/etc/${PN}/web2c
	cp ${FILESDIR}/texmfcnf.lua ${D}/etc/${PN}/web2c
	echo -e "cd /opt/${PN}\nrsync -ptv rsync://contextgarden.net/minimals/setup/first-setup.sh .\n./first-setup.sh --extras=all\nln -s /etc/${PN}/web2c/cont-sys.tex /opt/${PN}/tex/texmf-context/tex/context/base/cont-sys.tex\nmv /opt/${PN}/tex/texmf/web2c/texmfcnf.lua /opt/${PN}/tex/texmf/web2c/texmfcnf.ori\nln -s /etc/${PN}/web2c/texmfcnf.lua /opt/${PN}/tex/texmf/web2c/texmfcnf.lua\nchmod -R 777 /opt/${PN}/tex/texmf-cache" >> ${D}/opt/${PN}/bin/ctx-update
	chmod 755  ${D}/opt/${PN}/bin/ctx-update
	ln -s ${D}/opt/${PN}/bin/ctx-update  ${D}/usr/sbin/ctx-update
	ln -s ${D}/etc/${PN}/web2c/cont-sys.tex ${D}/opt/${PN}/tex/texmf-context/tex/context/base/cont-sys.tex
	cp ${D}/opt/${PN}/tex/texmf/web2c/texmfcnf.lua ${D}/opt/${PN}/tex/texmf/web2c/texmfcnf.ori
	ln -s ${D}/etc/${PN}/web2c/texmfcnf.lua ${D}/opt/${PN}/tex/texmf/web2c/texmfcnf.lua
	chmod -R 777 ${D}/opt/${PN}/tex/texmf-cache
	cp ${FILESDIR}/makeproject.py3 ${D}/usr/bin/makeproject.py3
	ln -s ${D}/usr/bin/makeproject.py3 ${D}/usr/bin/makeproject
	chmod -R 777 ${D}/usr/bin/makeproject.py3 ${D} /usr/bin/makeproject
}

pkg_postinst() {
	elog "As we can not provide an easy way for setting the path, we advice"
	elog "you to create an alias in your .bashrc"
	elog "Add the following to your .bashrc"
	elog "alias ConTeXt='source /opt/${PN}/tex/setuptex /opt/${PN}/tex &&
	mktexlsr && texexec --make --all && context --make && context --generate
	--all && luatools --generate'"
	elog ""
	elog "I included a little script \"ctx-update\" for updating context"
	elog "just execute it in a shell as root and regenerate the formats."
	elog ""
	elog "Too use ConTeXt you only need to execute \"ConTeXt\" now if you"
	elog "have set the above alias."
	elog ""
	elog "Too update some config options you can edit the files in"
	elog "\"/etc/${PN}/web2c\""
	elog "too just update execute \"ctx-update\"."
	elog ""
	elog "Included a Script for project file creation. It is writen in"
	elog "Python3, so if you want to use it install python3, else it is"
	elog "just copied but not usable..."
}

