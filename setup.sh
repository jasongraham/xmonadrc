#!/bin/bash
#
# Quick script to setup the xmonad config by linking
# $HOME/.xmonad to this repo.

# Get the directory name of the setup script
DIR="$( cd "$(dirname "$0")" && pwd)"

# make sure that we're not already in $HOME/.xmonad
if [ $DIR == $HOME/.xmonad ] ; then
    echo "This script is intended to link $HOME/.xmonad to $DIR."
    echo "If those are the same, there's nothing to do."
    exit 1
fi

rm -rf $HOME/.xmonad
ln -s $DIR $HOME/.xmonad

