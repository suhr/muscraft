# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id: $

EAPI=5

inherit cmake-utils

DESCRIPTION="A WINE-based VST bridge"
HOMEPAGE="https://github.com/phantom-code/airwave"
SRC_URI="https://github.com/phantom-code/airwave/archive/${PV}.tar.gz -> airwave-${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~x86 ~amd64"
IUSE=""
SLOT="0"

DEPEND="virtual/wine
    dev-qt/qtwidgets:5
    dev-qt/qtnetwork:5
"
RDEPEND="${DEPEND}"

src_configure() {
    local mycmakeargs=(
        '-DVSTSDK_PATH=/usr/include/vst'
    )

    cmake-utils_src_configure
}
