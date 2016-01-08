# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit git-2 eutils multilib python-r1

DESCRIPTION="Open source music editor with a novel interface and fever limitations than trackers"
HOMEPAGE="http://users.notam02.no/~kjetism/${PN}/"
EGIT_REPO_URI="git://github.com/kmatheussen/radium.git"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="+calf debug"
LICENSE="GPL-2"

DEPEND="dev-qt/qtcore[qt3support]
	sys-libs/binutils-libs[static-libs]
	x11-libs/libXaw
	media-libs/alsa-lib
	media-sound/jack-audio-connection-kit
	media-libs/libsamplerate
	media-libs/liblrdf
	media-libs/libsndfile
	media-libs/ladspa-sdk
	media-libs/vamp-plugin-sdk
	media-libs/vst-sdk
	>=dev-libs/glib-2.0
"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	sed -i -e 's:~/SDKs/vstsdk2.4:/usr/include/vst:g' "${S}/pluginhost/Builds/Linux/Makefile"
	sed -i -e 's:~/SDKs/vstsdk2.4:/usr/include/vst:g' "${S}/check_dependencies.sh"
}

src_compile() {
	make very_clean
	if use debug; then
		BUILDT=DEBUG
	else
		BUILDT=RELEASE
	fi
	touch audio/*.cpp common/gfx_op_queue_generated.c common/visual_op_queue_proc.h
	emake DESTDIR="${D}" PREFIX="/usr" libdir="/usr/$(get_libdir)" \
		OPTIMIZE="${CXXFLAGS}" packages || die "make packages failed"
	BUILDTYPE="${BUILDT}" ./build_linux.sh -j2 || die "Build failed"
}

src_install() {
	dodir /usr/lib/radium
	insinto /usr/lib/radium

	mv bin/packages/s7 ./
	rm -rf bin/packages/*
	mv ./s7 bin/packages
	doins -r bin/*

	dosym /usr/lib/radium/radium /usr/bin/radium

	make_desktop_entry radium Radium "radium" "AudioVideo;Audio;AudioVideoEditing;"
}
