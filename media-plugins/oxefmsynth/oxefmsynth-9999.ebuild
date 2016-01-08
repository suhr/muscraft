# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit git-2

DESCRIPTION="Oxe FM Synth is an open source VST synthesizer for Windows, Linux and Mac OS X"
HOMEPAGE="http://www.oxesoft.com/"
EGIT_REPO_URI="git://github.com/oxesoft/oxefmsynth.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="media-libs/vst-sdk"
DEPEND="${RDEPEND}"

src_compile() {
	export VSTSDK_PATH=/usr/include/vst
	emake -f Makefile.vstlinux
}

src_install() {
	dodir "/usr/lib/vst/Oxe FM Synth"
	insinto "/usr/lib/vst/Oxe FM Synth"
	doins "oxevst$(getconf LONG_BIT).so"
}
