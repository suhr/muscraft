# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="Free Music Instrument Tuner"
HOMEPAGE="https://gillesdegottex.github.io/fmit"
SRC_URI="https://github.com/gillesdegottex/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+ LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa jack oss portaudio"
REQUIRED_USE="|| ( alsa jack oss portaudio )"

RDEPEND="
	>=sci-libs/fftw-3.3.4
	media-libs/freeglut
	dev-qt/qtopengl:5
	dev-qt/qtsvg:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	portaudio? ( media-libs/portaudio )
"

DEPEND="${RDEPEND}"

src_prepare() {
	# Fix the path to readme file to prevent errors on start up
	sed -i "/QFile readmefile/s:\".*\":\"/usr/share/doc/${PF}/README.txt\":" \
		src/CustomInstrumentTunerForm.cpp
	# Fix the PREFIX location, insert real path.
	sed -i "/QString fmitprefix/s:PREFIX:/usr:" \
		src/main.cpp
	# Fix the PREFIX location, insert real path.
	sed -i "/QString fmitprefix/s:PREFIX:/usr:" \
		src/modules/MicrotonalView.cpp

	sed -i "/CONFIG += acs_qt/d" fmit.pro
	default
}

src_configure() {
	local config
	for flag in alsa jack portaudio oss; do
		use ${flag} && config+=" acs_${flag}"
	done

	"$(qt5_get_bindir)"/lrelease fmit.pro || die "Running lrelease failed"

	eqmake5 CONFIG+="${config}" fmit.pro PREFIX="${D}"/usr \
		PREFIXSHORTCUT="${D}"/usr DISTDIR=/usr
}

src_install() {
	emake DESTDIR="${D}" install
	insinto /usr/share/doc/"${PF}"/
	doins README.txt
	docompress -x /usr/share/doc/"${PF}"/
}
