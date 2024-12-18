{ pkgs, ... }: 
  let 
    username = "timo";
  in {
  # here go the darwin preferences and config items
  programs.zsh = {
    enable = true;
    shellInit = "";
  };
  
  environment = {
    shells = with pkgs; [ zsh ];
    loginShell = pkgs.zsh;
    systemPackages = [ pkgs.coreutils ];
    systemPath = [
      "/opt/homebrew/bin"
      "/run/current-system/sw/bin"  # Add this to ensure Nix binaries are available
    ];
    pathsToLink = [ "/Applications" ];
  };

  # Add this section to configure your user
  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };

  # enable nix commands
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  services.nix-daemon.enable = true;

  system.defaults = {
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
    dock.autohide = false;
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 14;
    NSGlobalDomain.KeyRepeat = 1;
  };
  # backwards compat; don't change
  system.stateVersion = 4;
}
