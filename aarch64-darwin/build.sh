HOSTNAME=$(hostname -s)

git add .

# Build the configuration. Mac equals my hostname
nix --extra-experimental-features 'nix-command flakes' build .#darwinConfigurations.$HOSTNAME.system

# Switch to the new configuration
./result/sw/bin/darwin-rebuild switch --flake .#${HOSTNAME}

# Activate the changes
echo ""
echo "to receive the latest changes, run: 'source  ~/.zshrc'"