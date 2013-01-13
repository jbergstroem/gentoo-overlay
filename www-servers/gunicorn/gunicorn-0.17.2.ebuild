# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2,3_3} pypy{1_8,1_9,2_0} )

inherit distutils-r1 eutils

DESCRIPTION="A WSGI HTTP Server for UNIX"
HOMEPAGE="http://gunicorn.org http://pypi.python.org/pypi/gunicorn"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE="doc examples test"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/setproctitle"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx )
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)"

python_prepare_all() {
	# these tests requires an already installed version of gunicorn
	rm tests/test_003-config.py
}

python_compile_all() {
	if use doc; then
		einfo "Generation of documentation"
		cd docs
		sphinx-build -b html source build || die "Generation of documentation failed"
	fi
}

python_install_all() {
	local DOCS=( NOTICE README.rst THANKS )
	use doc && dohtml -r docs/build/
	use examples && dodoc -r examples

	distutils-r1_python_install_all
}

python_test() {
	nosetests || die
}
