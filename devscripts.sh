#!/bin/bash
PYTHON="/usr/bin/env python3"
EXEC="zoomdl"
# ZIP="zoomdl.zip"
ZIP_FOLDER="zip"
LOCALBIN="/usr/local/bin/"
SRC="zoom_dl"

compile(){
	mkdir -p $ZIP_FOLDER #create folder to zip
	cp -r $SRC $ZIP_FOLDER #copy all python files
	mv $ZIP_FOLDER/$SRC/__main__.py $ZIP_FOLDER #put main above src
	pip install -r requirements.txt --target $ZIP_FOLDER
	rm -r $ZIP_FOLDER/*.dist-info
	python3 -m  zipapp -p "$PYTHON" -o $EXEC $ZIP_FOLDER
	rm -rf $ZIP_FOLDER
}

build(){
	compile
}

install(){
	compile
	sudo cp $EXEC $LOCALBIN
}

if [[ $# -ne 1 ]]
then
		echo "Usage: $0 'command'"
		echo "Valid commands: 'clean', 'compile', 'install'"
		exit 1
else
	"$@"
fi
