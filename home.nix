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
      nixshell = "nix-shell";
      v = "vim";
      e = "vim"; 
      ls = "ls -al";
      gadd = "git add .";
      gcommit = "git commit -m";
      gpush = "git push";
      gpull = "git pull";
      gclone = "git clone";
    };
  };

  programs.home-manager.enable = true;

  # vim ultisnips
  home.file.".vim/UltiSnips/all.snippets" = {
    text = ''
      snippet html "html5 template"
      <html lang="en">
        <head>
          <title>$1</title>
          <meta charset="UTF-8">
          <meta name"viewport" content="width=device-width, inital-scale=1">
        </head>
        <body>
          $0
        </body>
      </html>
      endsnippet

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
      autocmd VimEnter * NERDTree | wincmd p
    '';

    # vim plugins
    plugins = with pkgs.vimPlugins; [
       vim-monokai-pro
       ultisnips
       nerdtree 
    ];
  };
}
