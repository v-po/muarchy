# inside ISO live environment, after archinstall finishes
arch-chroot /mnt bash -c "
  mkdir -p /home/\$SUDO_USER/.local/share
  git clone https://github.com/v-po/muarchy.git /home/\$SUDO_USER/.local/share/muarchy
  chown -R \$SUDO_USER:\$SUDO_USER /home/\$SUDO_USER/.local/share/muarchy

  # install systemd unit for first boot setup
  cat <<'EOF' > /etc/systemd/system/muarchy-setup.service
  [Unit]
  Description=Run Muarchy First Boot Setup
  After=default.target

  [Service]
  Type=oneshot
  ExecStart=/bin/bash /home/%i/.local/share/muarchy/boot.sh
  User=%i
  RemainAfterExit=yes

  [Install]
  WantedBy=default.target
  EOF

  # Enable service for new user (assuming username=youruser from archinstall)
  systemctl enable muarchy-setup.service
"
