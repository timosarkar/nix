{ config, pkgs, ... }:

let
  username = if builtins.getEnv "USER" != "" then builtins.getEnv "USER" else "root";
in
{
  home.username = username;
  home.homeDirectory = if username == "root" then "/root" else "/home/${username}";
  home.stateVersion = "23.05";

  home.packages = with pkgs; [];

  programs.home-manager.enable = true;

  programs.vim = {
    enable = true;
    settings = {
       relativenumber = true;
       number = true;
       termguicolors = true;
    };
    plugins = with pkgs.vimPlugins; [
       vim-monokai-pro
    ];
  };
}
