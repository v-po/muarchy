#!/usr/bin/env bash
set -euo pipefail

# Directories
WORKDIR="$(pwd)/work"
OUTDIR="$(pwd)/out"
PROFILE="$(pwd)/iso-profile"

# Clean up old builds
rm -rf "$WORKDIR" "$OUTDIR"
mkdir -p "$PROFILE"

# Create profile directories
mkdir -p "$PROFILE/airootfs/etc"
mkdir -p "$PROFILE/packages"

# Copy package lists
cp iso.packages "$PROFILE/packages.x86_64"

# Copy configurator (your script)
cp configurator "$PROFILE/airootfs/root/configurator"

# Basic mkinitcpio hooks (default)
cat > "$PROFILE/profiledef.sh" <<EOF
#!/usr/bin/env bash
iso_name="myarch"
iso_label="MYARCH_$(date +%Y%m)"
iso_publisher="Me"
iso_application="My custom Arch ISO"
iso_version="$(date +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux' 'uefi-x64.systemd-boot')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86')
file_permissions=()
EOF

# Run mkarchiso
mkarchiso -v -w "$WORKDIR" -o "$OUTDIR" "$PROFILE"
