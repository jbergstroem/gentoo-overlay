# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

DESCRIPTION="A compressed bitset with supporting data structures and algorithms"
HOMEPAGE="http://github.com/chriso/bitset"
SRC_URI="mirror://github/chriso/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="jemalloc static-libs tcmalloc"
KEYWORDS="~amd64 ~x86"

RDEPEND="tcmalloc? ( dev-util/google-perftools )
	jemalloc? ( >=dev-libs/jemalloc-3.2 )"
DEPEND="${RDEPEND}"

REQUIRED_USE="tcmalloc? ( !jemalloc )
	jemalloc? ( !tcmalloc )"

DOCS=( README.md )

src_configure() {
	econf \
		$(use_with jemalloc) \
		$(use_with tcmalloc) \
		$(use_enable static-libs static)
}

src_install() {
	default
	use static-libs || prune_libtool_files
}
