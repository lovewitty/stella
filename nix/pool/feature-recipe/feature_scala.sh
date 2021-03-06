if [ ! "$_SCALA_INCLUDED_" == "1" ]; then
_SCALA_INCLUDED_=1



feature_scala() {
	FEAT_NAME=scala
	FEAT_LIST_SCHEMA="2_11_6:binary"
	FEAT_DEFAULT_VERSION=2_11_6
	FEAT_DEFAULT_ARCH=
	FEAT_DEFAULT_FLAVOUR="binary"
}

feature_scala_env() {
	SCALA_HOME=$FEAT_INSTALL_ROOT
	export SCALA_HOME=$FEAT_INSTALL_ROOT
}


feature_scala_2_11_6() {
	FEAT_VERSION=2_11_6
	# need JVM
	FEAT_SOURCE_DEPENDENCIES=
	FEAT_BINARY_DEPENDENCIES=

	FEAT_SOURCE_URL=
	FEAT_SOURCE_URL_FILENAME=
	FEAT_SOURCE_URL_PROTOCOL=

	FEAT_BINARY_URL=http://downloads.typesafe.com/scala/2.11.6/scala-2.11.6.tgz
	FEAT_BINARY_URL_FILENAME=scala-2.11.6.tgz
	FEAT_BINARY_URL_PROTOCOL=HTTP_ZIP

	FEAT_SOURCE_CALLBACK=
	FEAT_BINARY_CALLBACK=
	FEAT_ENV_CALLBACK=feature_scala_env

	FEAT_INSTALL_TEST="$FEAT_INSTALL_ROOT"/bin/scala
	FEAT_SEARCH_PATH="$FEAT_INSTALL_ROOT"/bin

}



feature_scala_install_binary() {
	__get_resource "$FEAT_NAME" "$FEAT_BINARY_URL" "$FEAT_BINARY_URL_PROTOCOL" "$FEAT_INSTALL_ROOT" "DEST_ERASE STRIP"

}


fi
