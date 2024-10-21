## build

```bash
podman build -t nix .
podman run -it nix
nix run nixpkgs#home-manager -- switch --flake ./#$USER
```
