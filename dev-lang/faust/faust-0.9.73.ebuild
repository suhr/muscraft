# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

DESCRIPTION="FAUST is a functional programming language and compiler for fast DSP algorythms"
HOMEPAGE="http://faust.grame.fr/"
SRC_URI="mirror://sourceforge/faudiostream/${P}.tgz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~x86 ~amd64"
IUSE="doc examples"

DEPEND="sys-apps/sed
	doc? ( app-doc/doxygen )
"
RDEPEND=""

src_compile() {
	PREFIX=/usr emake
	if use doc ; then
		make doc
	fi
}

src_install() {
	emake install PREFIX=/usr DESTDIR="${D}"
	dodoc README
	if use doc ; then
	    dodoc WHATSNEW documentation/*.pdf "documentation/additional documentation" \
		    documentation/touchOSC.txt
	    dohtml dox/html/*.html dox/html/*.png dox/html/*.css dox/html/*.js
	fi
	if use examples ; then
	    insinto /usr/share/"${P}"/examples
	    doins examples/*
	fi
}
