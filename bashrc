#!/bin/bash

# shell prompt prefix
EXIT_CODE='$(RETURN=$?; if [[ $RETURN != 0 ]]; then echo -ne "\[\e[0;31m\]($RETURN)\[\e[0m\]"; fi;)'
PS1="$EXIT_CODE\W\$ "

# activate keyring capabilities
source ~/.i3/start-gnome-keyring.sh

# ANDROID stuff
export JAVA_HOME=/usr/lib/jvm/java/
export ANDROID_HOME=~/bin/adt-bundle/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

# i3
# TERMINAL="xterm"

# Oracle stuff
export ORACLE_HOME=/usr/lib/oracle/11.2/client64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME/lib