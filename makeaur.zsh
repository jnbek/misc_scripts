#/bin/zsh
# Make AUR Packages 
# Structure, being in the PKGBUILD dir, we store src dirs and package_destinations in directories up one level:
# Example: $PKGBUILD/../src/ and $PKGBULD/../aur_packages.
# Execute this in the PKGBUILD directory.

PKGDEST="$PWD/../aur_packages"
SRCDEST="$PWD/../aur_sources"
/usr/bin/makepkg -S
