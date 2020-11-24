if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
if [ -e /home/dizzy/.nix-profile/etc/profile.d/nix.sh ]; then . /home/dizzy/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
