#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_DIR="$SCRIPT_DIR/bin"

echo "Building imsg..."
make -C "$SCRIPT_DIR" build

if ! grep -qF "$BIN_DIR" ~/.zshrc 2>/dev/null; then
  echo "export PATH=\"\$PATH:$BIN_DIR\"" >> ~/.zshrc
  echo "Added $BIN_DIR to PATH in ~/.zshrc"
else
  echo "$BIN_DIR already in ~/.zshrc, skipping"
fi

export PATH="$PATH:$BIN_DIR"

echo ""
echo "Verifying installation..."
imsg chats --limit 5 --json

echo ""
echo "Setup complete. Run 'source ~/.zshrc' or open a new terminal for PATH changes to take effect."
