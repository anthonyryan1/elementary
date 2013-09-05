# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16

inherit gnome2-utils vala cmake-utils bzr

DESCRIPTION="Pantheon's Window Manager"
HOMEPAGE="https://launchpad.net/gala"
EBZR_REPO_URI="lp:gala"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-libs/libgee
	media-libs/clutter
	media-libs/clutter-gtk
	|| ( pantheon-base/pantheon-dock pantheon-base/plank )
	x11-libs/granite
	x11-libs/bamf
	x11-libs/libXfixes
	>=x11-wm/mutter-3.8"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${P}-mutter38-branch.patch"

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="${VALAC}"
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
