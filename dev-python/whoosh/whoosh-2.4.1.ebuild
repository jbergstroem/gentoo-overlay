# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2,3_3} pypy{1_9,2_0} )

MY_PN="Whoosh"

inherit distutils-r1

DESCRIPTION="Fast, pure-Python full text indexing, search and spell checking library"
HOMEPAGE="http://bitbucket.org/mchaput/whoosh/wiki/Home/ http://pypi.python.org/pypi/Whoosh/"
SRC_URI="mirror://pypi/W/${MY_PN}/${MY_PN}-${PV}.tar.gz"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? (	dev-python/nose[${PYTHON_USEDEP}] )"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

S="${WORKDIR}/${MY_PN}-${PV}"

python_install_all() {
	local DOCS=( README.txt )
	distutils-r1_python_install_all

	if use doc; then
		insinto "/usr/share/doc/${PF}/"
		doins -r docs/build/html/_sources/* || die
	fi
}

python_test() {
	${EPYTHON} setup.py test || die "Tests fail with ${EPYTHON}"
}
