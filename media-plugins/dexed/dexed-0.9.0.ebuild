# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="A multi platform, multi format plugin synth that is closely modeled on the Yamaha DX7."
HOMEPAGE="http://asb2m10.github.io/dexed/"
SRC_URI="https://github.com/asb2m10/dexed/archive/39d3c28853a4019dd9508278c97d9c60930fe989.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/vst-sdk"
DEPEND="${RDEPEND}"

S="${WORKDIR}/dexed-39d3c28853a4019dd9508278c97d9c60930fe989"

src_prepare() {
	sed -i -e 's:~/src/vstsdk2.4:/usr/include/vst:g' Builds/Linux/Makefile
}

src_compile() {
	cd Builds/Linux
	make CONFIG=Release
}

src_install() {
	dodir /usr/lib/vst/Dexed
	insinto /usr/lib/vst/Dexed
	doins Builds/Linux/build/Dexed.so
}
