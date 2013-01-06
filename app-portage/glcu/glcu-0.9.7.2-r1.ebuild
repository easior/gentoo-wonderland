# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="gentoo linux cron update. Full featured semi-automatic updates for your gentoo box."
HOMEPAGE="http://glcu.sourceforge.net/"
SRC_URI="mirror://sourceforge/glcu/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc"
IUSE="esearch eix"

RDEPEND=">=dev-lang/python-2.5
         >=sys-apps/portage-2.1.4.4
         >=app-portage/gentoolkit-0.2.3-r1
         >=sys-apps/baselayout-1.12.11.1
         mail-client/mailx
         esearch? ( >=app-portage/esearch-0.7 )
         eix? ( >=app-portage/eix-0.2.2 )"


src_prepare() {
	epatch "${FILESDIR}/glcu-${PV}.patch"
#	epatch "${FILESDIR}/output.patch"
#	epatch "${FILESDIR}/eix.patch"
#	epatch "${FILESDIR}/hostname.patch"
}

src_install() {
	dodir /usr/sbin/
	dodir /etc/cron.daily/

	exeinto /usr/lib/glcu
	doexe glcu.py || die "doexe failed"

	dosym /usr/lib/glcu/glcu.py /etc/cron.daily/glcu
	dosym /usr/lib/glcu/glcu.py /usr/sbin/glcu

	insinto /etc
	doins glcu.conf


#	doman 
#	dodoc 

}

pkg_postinst() {
	einfo ""
	einfo " Before you can use glcu, you must edit the config file:"
	einfo "   /etc/glcu.conf"
	einfo ""
        use esearch && einfo " For esearch support set 'eupdatedb: yes' in the config file"
        use eix && einfo " For eix support set 'updateix: yes' in the config file" 
}

