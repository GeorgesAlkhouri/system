#!/usr/bin/env bash
export SCRIPTPATH="$(
  cd "$(dirname "$0")"
  pwd -P
)"

if [ -f "/tmp/leftwm-theme-down" ]; then
  /tmp/leftwm-theme-down
  rm /tmp/leftwm-theme-down
fi

ln -s $SCRIPTPATH/down /tmp/leftwm-theme-down

leftwm-command "LoadTheme $SCRIPTPATH/theme.ron"
