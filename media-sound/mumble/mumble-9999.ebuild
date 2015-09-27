# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

QT_MINIMAL="4.6"

inherit eutils multilib qt4-r2 git-r3 qmake-utils

EGIT_REPO_URI="https://github.com/mumble-voip/mumble.git"

DESCRIPTION="Mumble is an open source, low-latency, high quality voice chat software"
HOMEPAGE="http://wiki.mumble.info/"
SRC_URI=""

LICENSE="BSD MIT"
SLOT="0"
KEYWORDS=""
IUSE="+alsa +dbus debug g15 oss pch portaudio pulseaudio qt4 +qt5 speech zeroconf"

REQUIRED_USE="^^ ( qt4 qt5 )"

RDEPEND=">=dev-libs/boost-1.41.0
	>=dev-libs/openssl-1.0.0b
	>=dev-libs/protobuf-2.2.0
	>=media-libs/libsndfile-1.0.20[-minimal]
	>=media-libs/opus-1.0.1
	>=media-libs/speex-1.2_rc1
	sys-apps/lsb-release
	x11-libs/libX11
	x11-libs/libXi
	qt4? (
		dev-qt/qtcore:4[ssl]
		dev-qt/qtgui:4
		dev-qt/qtopengl:4
		dev-qt/qtsql:4[sqlite]
		dev-qt/qtsvg:4
		dev-qt/qtxmlpatterns:4
	)
	qt5? (
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5[ssl]
		dev-qt/qtopengl:5
		dev-qt/qtsql:5[sqlite]
		dev-qt/qtsvg:5
		dev-qt/qtxmlpatterns:5
	)
	x11-proto/inputproto
	alsa? ( media-libs/alsa-lib )
	dbus? ( dev-qt/qtdbus:4 )
	g15? ( app-misc/g15daemon )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-sound/pulseaudio )
	speech? ( app-accessibility/speech-dispatcher )
	zeroconf? ( net-dns/avahi[mdnsresponder-compat] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	local conf_add

	if has_version '<=sys-devel/gcc-4.2'; then
		conf_add="${conf_add} no-pch"
	else
		use pch || conf_add="${conf_add} no-pch"
	fi

	use alsa || conf_add="${conf_add} no-alsa"
	use dbus || conf_add="${conf_add} no-dbus"
	use debug && conf_add="${conf_add} symbols debug" || conf_add="${conf_add} release"
	use g15 || conf_add="${conf_add} no-g15"
	use oss || conf_add="${conf_add} no-oss"
	use portaudio || conf_add="${conf_add} no-portaudio"
	use pulseaudio || conf_add="${conf_add} no-pulseaudio"
	use speech || conf_add="${conf_add} no-speechd"
	use zeroconf || conf_add="${conf_add} no-bonjour"

	conf_add="${conf_add} bundled-celt no-bundled-opus no-bundled-speex no-embed-qt-translations no-server no-update"

	if use qt4 ; then
		eqmake4 "${S}/main.pro" -recursive \
			CONFIG+="${conf_add} qt4-legacy-compat" \
			DEFINES+="PLUGIN_PATH=/usr/$(get_libdir)/mumble"
	elif use qt5 ; then
		eqmake5 "${S}/main.pro" -recursive \
			CONFIG+="${conf_add}" \
			DEFINES+="PLUGIN_PATH=/usr/$(get_libdir)/mumble"
	fi
}

src_install() {
	newdoc README.Linux README
	dodoc CHANGES

	local dir
	if use debug; then
		dir=debug
	else
		dir=release
	fi

	dobin "${dir}"/mumble
	dobin scripts/mumble-overlay

	insinto /usr/share/services
	doins scripts/mumble.protocol

	domenu scripts/mumble.desktop

	insinto /usr/share/icons/hicolor/scalable/apps
	doins icons/mumble.svg

	doman man/mumble-overlay.1
	doman man/mumble.1

	insopts -o root -g root -m 0755
	insinto "/usr/$(get_libdir)/mumble"
	doins "${dir}"/libmumble.so.1.3.0
	dosym libmumble.so.1.3.0 /usr/$(get_libdir)/mumble/libmumble.so.1
	doins "${dir}"/libcelt0.so.0.{7,11}.0
	doins "${dir}"/plugins/lib*.so*
}

pkg_postinst() {
	echo
	elog "Visit http://wiki.mumble.info/ for futher configuration instructions."
	elog "Run mumble-overlay to start the OpenGL overlay (after starting mumble)."
	echo
}