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

  home.file.".vim/UltiSnips/all.snippets" = {
    text = ''
      snippet lorem "lorem ipsum text"
      lorem ipsum dolor si amet
      endsnippet
    '';
    force = true;
  };

  programs.vim = {
    enable = true;
    settings = {
       relativenumber = true;
       number = true;
       mouse = "a";
    };
    extraConfig = ''
      set tabstop=2
      set softtabstop=2
      set shiftwidth=2
      set expandtab
      set termguicolors
      colorscheme monokai_pro
      let g:UltiSnipsExpandTrigger="<tab>"
      let g:UltiSnipsSnippetDirectories=["UltiSnips"]
    '';
    plugins = with pkgs.vimPlugins; [
       vim-monokai-pro
       ultisnips
    ];
  };
}
