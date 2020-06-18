# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools cmake

DESCRIPTION="mirakc-tools for Japanese TV broadcast contents"
HOMEPAGE="https://github.com/masnagam/mirakc-arib"
SRC_URI="https://github.com/masnagam/mirakc-arib/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=">=dev-util/cmake-3.5.0
app-text/dos2unix
virtual/pkgconfig"
RDEPEND="${DEPEND}"
BDEPEND=""

RESTRICT="network-sandbox"

src_configure() {
	CMAKE_BUILD_TYPE="Release"
	cmake_src_configure
}

src_compile() {
	cmake_src_compile vendor
	cmake_src_compile
}

src_install() {
	dobin ${BUILD_DIR}/bin/mirakc-arib
}
