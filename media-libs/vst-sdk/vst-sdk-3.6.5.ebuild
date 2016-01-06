# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit versionator

BDATE="12_11_2015"
BUILD="build_67"
MY_PV="$(delete_all_version_separators)_${BDATE}_${BUILD}"

DESCRIPTION="Steinberg Virtual Studio Technology software development kit"
HOMEPAGE="http://www.steinberg.net/en/company/developers.html"
SRC_URI="http://www.steinberg.net/sdk_downloads/vstsdk${MY_PV}.zip"

LICENSE="VST3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

RESTRICT="mirror"
S="${WORKDIR}/VST3 SDK"

src_compile() { :; }

include_path="/usr/include/vst"
src_install() {
	dodir "${include_path}/public.sdk"

	insinto "${include_path}/public.sdk"
	doins -r "public.sdk/source"

	insinto "${include_path}"
	doins -r "pluginterfaces"
}

pkg_postinst() {
	einfo "Please make sure to review the license agreement, which can be found at:"
	einfo "${ROOT}usr/share/vst3-sdk/doc/VST3_License_Agreement.html"
}
