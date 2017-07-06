#!/bin/bash

# web root directory
WEBROOT=/var/www/tdp

# unix timestamp - used in dir name
TS=`date +%s`

# New content dir name
NEWDIR=$WEBROOT/$TS

# "current" symlink dir
SYMLINK=$WEBROOT/current



# create dest content dir
mkdir -p $NEWDIR

# Sync from GCS to new dir
/usr/bin/gsutil -m cp -r gs://tdp-statyck-web/* $NEWDIR

# Remove existing symlink
rm $SYMLINK

# Symnlink new dir to "current"
ln -s $NEWDIR $SYMLINK

# Delete old dirs
for file in $WEBROOT/*
do
	if [ "$file" != "$NEWDIR" ] && [ "$file" != "$SYMLINK" ]
	then
		rm -Rf $file
	fi
done