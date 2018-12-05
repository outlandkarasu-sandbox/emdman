#!/bin/sh

cd `dirname $0`

dub build --force --build=release

