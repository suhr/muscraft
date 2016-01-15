# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils

DESCRIPTION="Open source polyphonic software synthesizer with lots of modulation"
HOMEPAGE="http://tytel.org/helm/"
SRC_URI="https://github.com/mtytel/helm/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="vst"

RDEPEND="media-libs/alsa-lib
	media-libs/lv2
	media-sound/jack-audio-connection-kit
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}"

DOCS="README.md"

src_prepare() {
	sed -i -e 's/lxvst/vst/g' Makefile
	sed -i -e 's:~/srcs/vstsdk2.4:/usr/include/vst:g' builds/linux/VST/Makefile
}

src_compile() {
	emake PREFIX=/usr all
	if use vst; then
		emake PREFIX=/usr vst
	fi
}

src_install() {
	emake DESTDIR="${D}" install

	if use vst; then
		dodir /usr/lib/vst
		emake DESTDIR="${D}" install_vst
	fi

	make_desktop_entry /usr/bin/helm Helm /usr/share/helm/icons/helm_icon_128_1x.png
}
