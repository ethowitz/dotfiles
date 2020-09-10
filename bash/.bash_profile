#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# start the X server if graphical.target has been reached if X is not already running
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

dbus-update-activation-environment --systemd --all

