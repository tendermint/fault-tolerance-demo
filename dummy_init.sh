#! /bin/bash
# This is a sample bash script for a TMSP application

BRANCH="master"

go get -d github.com/tendermint/tmsp/cmd/dummy
cd $GOPATH/src/github.com/tendermint/tmsp/
git fetch origin $BRANCH
git checkout $BRANCH
make install

dummy
