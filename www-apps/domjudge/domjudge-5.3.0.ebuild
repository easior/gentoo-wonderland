# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils webapp

#S="${WORKDIR}/${MY_P}"
#S=${WORKDIR}/${PN}

DESCRIPTION="DOMjudge is an automated judge system to run programming contests, like the ACM ICPC."
HOMEPAGE="https://www.domjudge.org/"
SRC_URI="https://www.domjudge.org/releases/${PN}-${PV}.tar.gz
	 https://github.com/DOMjudge/domjudge/archive/${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~arm ppc ppc64 ~sparc x86"
IUSE="+curl -daemon doc +mysql postgres sqlite"

REQUIRED_USE="|| ( mysql postgres sqlite )"

COMMON_DEPEND="
	daemon? ( dev-libs/libcgroup
		dev-libs/jsoncpp )
	doc? ( app-text/linuxdoc-tools )
	dev-texlive/texlive-latexrecommended
	dev-lang/php[curl?,filter,gd,json,mysql?,postgres?,sqlite?]
	dev-php/composer
	virtual/httpd-php"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}
	 app-admin/sudo"

pkg_setup() {
	webapp_pkg_setup
}

pkg_preinst() {
	if use daemon; then
		enewgroup domjudge-run
		enewuser domjudge-run -1 /sbin/nologin /dev/null "nogroup"
	fi
}

src_configure() {
	local myconf

	if use daemon; then
		myconf="--enable-fhs"
	else
		myconf="--with-domjudge_docdir=/usr/share/doc/domjuge
	    --with-domserver_bindir=/usr/bin
	    --with-domserver_etcdir=/etc/domjudge
	    --with-domserver_wwwdir=/var/www/domjudge
	    --with-domserver_sqldir=/var/lib/domjudge/sql
	    --with-domserver_libdir=/usr/share/domjudge
	    --with-domserver_libvendordir=/usr/share/domjudge/vendor
	    --with-domserver_libwwwdir=/usr/share/domjudge/www
	    --with-domserver_libsubmitdir=/usr/share/domjudge/submit
	    --with-domserver_logdir=/var/log/domjudge
	    --with-domserver_rundir=/run/domjudge
	    --with-domserver_tmpdir=/tmp
	    --with-domserver_submitdir=/var/www/domjudge/submissions"
	fi

	if use doc ; then
		myconf="${myconf}
			--enable-doc-build"
	fi

	econf \
		--with-domjudge-user=root \
		--with-webserver-group=apache \
		${myconf}
}

src_compile() {
	if use daemon; then
		emake build
	else
		emake domserver
	fi

	if use doc; then
		emake docs
	fi
}

src_install() {
	if use daemon; then
		emake DESTDIR="${D}" install-domserver
		emake DESTDIR="${D}" install-judgehost
		# newconfd "${FILESDIR}"/domjudge-judgehost.confd domjudge-judgehost
		newinitd "${FILESDIR}"/domjudge-judgehost.initd domjudge-judgehost
	else
		emake DESTDIR="${D}" install-domserver
	fi

	if use doc; then
		emake DESTDIR="${D}" install-docs
	fi

	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r .
	dodir "${MY_HTDOCSDIR}"/data

	#webapp_serverowned -R "${MY_HTDOCSDIR}"/apps
	#webapp_serverowned -R "${MY_HTDOCSDIR}"/data
	#webapp_serverowned -R "${MY_HTDOCSDIR}"/config
	#webapp_configfile "${MY_HTDOCSDIR}"/.htaccess

	webapp_src_install
}

pkg_postinst() {
	elog "ln -s /etc/domserver/apache.conf /etc/apache2/vhosts.d/default-vhost.conf"
	elog "Additional applications (calendar, ...) are no longer provided by default."
	elog "You can install them after login via the applications management page"
	elog "(check the recommended tab). No application data is lost."
	webapp_pkg_postinst
}

