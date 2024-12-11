## Nix

This repository contains all of my configurations and programs on my devices. They are all written using the Nix expression language, so that I can get ephemeral builds with very expressive parameters and versioning that run on all platforms and dont break. 

In the root directory you find my Nix home-manager configs. Home-manager configures my home directory and dotfiles on Ubuntu-22.02LTS, Debian 11 and Arch Linux. ```home.nix``` contains the configurations for my installed programs such as vim. 

## Replicate Nix home-manager

To replicate my home directory, dotfiles and installed/configured programs without breaking your own one, you need to install and run this podman container as shown below. 

> **IMPORTANT! If you have made changes to local files that get imported by the flake, then you need to stage them into the git tree with ``git add .```**

```bash
podman build -t nix .
podman run -it nix
git add .
nix run nixpkgs#home-manager -- switch --flake ./#$USER
```

## Nix Development Environment Shells

Additionally to a fully-fledged ephemeral and immutable home-directory, I provide here my development shells in form of different nix-shells. A nix-shell is basically a file, that temporarily changes your home-directory and ```PATH``` variable to include a specified set of versioned programs that we can pull from the nix-registry. After stopping the nix-shell, the ```PATH``` and home directory will be rolled back to its previous state. So If you ever experience the pain of managing different versions of nodejs, you can simply setup a nix-shell to manage this for you.

You can find the shells under ```./shells/*```.

### Building ```nix-shells```

Simple run ```nix-shell``` with the path flag to the relative file-path of the nix shell.

```bash
nix-shell -p <path to nix shell>

# nix shell that installs nodejs 22 LTS and bunjs
nix-shell -p shells/bun.nix
```
