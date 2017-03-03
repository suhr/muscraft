# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="A multi platform, multi format plugin synth that is closely modeled on the Yamaha DX7"
HOMEPAGE="http://asb2m10.github.io/dexed/"
SRC_URI="https://github.com/asb2m10/dexed/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/vst-sdk"
DEPEND="${RDEPEND}"

src_prepare() {
	eapply_user
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
