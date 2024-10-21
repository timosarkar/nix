{ config, pkgs, ... }:

let
  # get current username
  username = if builtins.getEnv "USER" != "" then builtins.getEnv "USER" else "root";
in
{
  home.username = username;
  
  # set homedir to /root when $username is root
  home.homeDirectory = if username == "root" then "/root" else "/home/${username}";
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    fish
  ];

  # fish shell
  programs.fish = {
    enable = true;

    # aliases
    shellAliases = {
      podb = "podman build -t";
      podr = "podman run -it";
      nixhome = "nix run nixpkgs#home-manager -- switch --flake ./#$USER";
      nano = "vim";
      v = "vim";
      e = "vim"; 
      gita = "git add .";
      gitc = "git commit -m";
      gitp = "git push";
    };
  };

  programs.home-manager.enable = true;

  # vim ultisnips
  home.file.".vim/UltiSnips/all.snippets" = {
    text = ''
      snippet lorem "lorem ipsum text"
      lorem ipsum dolor si amet
      endsnippet
    '';
    force = true;
  };

  # vim
  programs.vim = {
    enable = true;
    settings = {
       relativenumber = true;
       number = true;
       mouse = "a";
     };

    # .vimrc
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

    # vim plugins
    plugins = with pkgs.vimPlugins; [
       vim-monokai-pro
       ultisnips
    ];
  };
}
