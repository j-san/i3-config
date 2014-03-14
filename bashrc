#!/bin/bash

# shell prompt prefix
EXIT_CODE='$(RETURN=$?; if [[ $RETURN != 0 ]]; then echo -ne "\[\e[0;31m\]($RETURN)\[\e[0m\]"; fi;)'
PS1="$EXIT_CODE\W\$ "

# activate keyring capabilities
source ~/.i3/start-gnome-keyring.sh

# ANDROID stuff
export JAVA_HOME=/usr/lib/jvm/java/
export ANDROID_HOME=~/bin/android-sdk-linux
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

# i3
# TERMINAL="xterm"
