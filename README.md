## Nix

This repository contains all of my configurations and programs on my devices. They are all written using the Nix expression language, so that I can get ephemeral builds with very expressive parameters and versioning that run on all platforms and dont break. 

In the root directory you find my Nix home-manager configs. Home-manager configures my home directory and dotfiles on Ubuntu-22.02LTS, Debian 11 and Arch Linux. ```home.nix``` contains the configurations for my installed programs such as vim. 

## Replicate Nix home-manager

To replicate my home directory, dotfiles and installed/configured programs without breaking your own one, you need to install and run this podman container as shown below. 

```bash
podman build -t nix .
podman run -it nix
nix run nixpkgs#home-manager -- switch --flake ./#$USER
```

## Nix Development Environment Shells


