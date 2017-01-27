if [ ! "$_libusb_INCLUDED_" == "1" ]; then
_libusb_INCLUDED_=1


function feature_libusb() {
	FEAT_NAME=libusb
	FEAT_LIST_SCHEMA="1_0_21:source"
	FEAT_DEFAULT_VERSION=1_0_21
	FEAT_DEFAULT_ARCH=
	FEAT_DEFAULT_FLAVOUR="source"
}

function feature_libusb_1_0_21() {
	FEAT_VERSION=1_0_21


	FEAT_SOURCE_DEPENDENCIES=
	FEAT_BINARY_DEPENDENCIES=

	FEAT_SOURCE_URL=https://github.com/libusb/libusb/releases/download/v1.0.21/libusb-1.0.21.tar.bz2
	FEAT_SOURCE_URL_FILENAME=libusb-1.0.21.tar.bz2
	FEAT_SOURCE_URL_PROTOCOL=HTTP_ZIP


	FEAT_BINARY_URL=
	FEAT_BINARY_URL_FILENAME=
	FEAT_BINARY_URL_PROTOCOL=

	FEAT_SOURCE_CALLBACK=
	FEAT_BINARY_CALLBACK=
	FEAT_ENV_CALLBACK=

	FEAT_INSTALL_TEST="$FEAT_INSTALL_ROOT"/lib/libusb-1.0.a
	FEAT_SEARCH_PATH=

}


function feature_libusb_install_source() {
	INSTALL_DIR="$FEAT_INSTALL_ROOT"
	SRC_DIR="$STELLA_APP_FEATURE_ROOT/$FEAT_NAME-$FEAT_VERSION-src"


	__set_toolset "STANDARD"


	__get_resource "$FEAT_NAME" "$FEAT_SOURCE_URL" "$FEAT_SOURCE_URL_PROTOCOL" "$SRC_DIR" "DEST_ERASE STRIP"

	AUTO_INSTALL_CONF_FLAG_PREFIX=
	AUTO_INSTALL_CONF_FLAG_POSTFIX=
	AUTO_INSTALL_BUILD_FLAG_PREFIX=
	AUTO_INSTALL_BUILD_FLAG_POSTFIX=

	__feature_callback

	__auto_build "$FEAT_NAME" "$SRC_DIR" "$INSTALL_DIR"

}


fi
