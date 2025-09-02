#!/usr/bin/env bash
set -euo pipefail

echo "Muarchy First boot setup starting..."

# Source the actual install script
source ~/.local/share/muarchy/install.sh

echo "Muarchy Setup complete. Disabling setup service."
sudo systemctl disable muarchy-setup.service
