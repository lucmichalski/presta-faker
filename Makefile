#---* Makefile *---#
.SILENT :

# App name
APPNAME=presta-faker
CONFIG_FILE=$(PWD)/config/config.php

# Extract version infos
VERSION:=`git describe --tags --always`
GIT_COMMIT:=`git rev-list -1 HEAD --abbrev-commit`
BUILT:=`date`

## build 				:	Build docker image
docker-build:
	@docker build -t $(APPNAME):$(VERSION) .
.PHONY: docker-build

## gen 				:	Generate fake data with the docker container
docker-gen:
	@mkdir -p ./output
	ifneq ("$(wildcard $(CONFIG_FILE))","")
		@docker run -ti -v $(PWD)/config/config.php:/opt/app/config/config.php -v $(PWD)/output:/opt/app/data $(APPNAME):$(VERSION)
	else
	    @echo "please setup you config file !!!!"
	endif
.PHONY: docker-gen

## help				:	Print commands help.
help : Makefile
	@sed -n 's/^##//p' $<
.PHONY: help

# https://stackoverflow.com/a/6273809/1826109
%:
	@:

