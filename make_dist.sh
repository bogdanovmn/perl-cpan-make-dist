#!/bin/sh

SOURCE_DIR=$1
LIB_NAME=$2

if [ -z $SOURCE_DIR ]; then
	echo "[ERROR] Source dir not defined!"
	exit
fi

if [ -z $LIB_NAME ]; then
	echo "[ERROR] Lib name not defined!"
	exit
fi

LIB_FILE=$SOURCE_DIR/lib/`echo $LIB_NAME | sed -r 's,::,/,g'`.pm
if [ ! -e $LIB_FILE ]; then
	echo "[ERROR] $LIB_FILE not exists!"
	exit
fi

LIB_PATH_NAME=`echo $LIB_NAME | sed -r 's,::,-,g'`
CURRENT_DIR=`pwd`

TMP_DIR=/tmp/make_cpan_dist_$$

LIB_VERSION=`perl -e "use lib '$SOURCE_DIR/lib'; use $LIB_NAME; print $LIB_NAME->VERSION;"`
LIB_DIR_NAME=$LIB_PATH_NAME-$LIB_VERSION
LIB_DIST_NAME=${LIB_DIR_NAME}.tar.gz

mkdir $TMP_DIR
cp -r $SOURCE_DIR $TMP_DIR/$LIB_DIR_NAME
cd $TMP_DIR
tar --exclude-vcs -czf $LIB_DIST_NAME $LIB_DIR_NAME
cp $LIB_DIST_NAME $CURRENT_DIR
rm -rf $TMP_DIR

echo "[OK] DIST NAME --> $LIB_DIST_NAME"
