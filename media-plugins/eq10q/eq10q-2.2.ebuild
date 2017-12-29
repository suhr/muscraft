# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit cmake-utils

DESCRIPTION="An LV2 audio plugin implementing a powerful and flexible parametric equalizer"
HOMEPAGE="http://eq10q.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="media-libs/lv2
	dev-cpp/gtkmm:2.4
	sci-libs/fftw:3.0
"
DEPEND="dev-util/cmake
	${RDEPEND}
"

src_configure() {
	local mycmakeargs=(
		"-DCMAKE_INSTALL_PREFIX=/usr/lib/lv2"
	)

	cmake-utils_src_configure
}
