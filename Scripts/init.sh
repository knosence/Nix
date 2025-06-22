#!/usr/bin/env nix-shell
#! nix-shell -i bash -p git curl home-manager

set -euo pipefail

REPO_URL="https://github.com/knosence/Nix"
REPO_NAME="Nix"
CLONE_DIR="$HOME/$REPO_NAME"
ASSETS_ICON="$CLONE_DIR/Assets/NixLogo.png"

# --- 1. Enable flakes for this shell ---
export NIX_CONFIG="experimental-features = nix-command flakes"

# --- 2. Clone or update flake repo ---
if [ -d "$CLONE_DIR" ]; then
  echo "🔁 Updating existing flake repo in $CLONE_DIR..."
  git -C "$CLONE_DIR" pull
else
  echo "⬇️ Cloning flake repo..."
  git clone "$REPO_URL" "$CLONE_DIR"
fi

cd "$CLONE_DIR"

# --- 3. Host selection ---
echo -e "\n🖥️  Available Hosts:"
mapfile -t HOSTS < <(find Config/Hosts -type f -name "*.nix" -printf "%f\n" | sed 's/\.nix$//')
select HOST in "${HOSTS[@]}"; do
  [[ -n "$HOST" ]] && break
  echo "Invalid selection."
done

# --- 4. Apply system configuration ---
echo "⚙️  Rebuilding system for host: $HOST..."
sudo nixos-rebuild switch --flake "$CLONE_DIR#$HOST"

# --- 5. User selection ---
echo -e "\n👤 Available Users:"
mapfile -t USERS < <(find Home/Users -type f -name "*.nix" -printf "%f\n" | sed 's/\.nix$//')
select USER in "${USERS[@]}"; do
  [[ -n "$USER" ]] && break
  echo "Invalid selection."
done

# --- 6. Apply home-manager configuration ---
echo "🏠 Applying Home Manager config for user: $USER..."
home-manager switch --flake "$CLONE_DIR#$USER"

# --- 7. Folder icon setup ---
ICON_TARGET="$HOME/.icons"
mkdir -p "$ICON_TARGET"

if [ -f "$ASSETS_ICON" ]; then
  cp "$ASSETS_ICON" "$ICON_TARGET/NixLogo.png"
  echo "🎨 Copied icon to $ICON_TARGET/NixLogo.png"
  gio set "$CLONE_DIR" metadata::custom-icon "file://$ICON_TARGET/NixLogo.png" 2>/dev/null || echo "⚠️ Unable to set folder icon (non-GNOME DE?)"
else
  echo "⚠️ Icon not found at: $ASSETS_ICON"
fi

echo -e "\n✅ Done! Flake configuration applied from $REPO_URL"
