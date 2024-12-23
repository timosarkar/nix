{ config, pkgs, snippets, markdown, html, snippets-snippets, ... }:

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
    nodejs_22
    zoxide
    thefuck
  ];

  # thefuck
  programs.thefuck = {
    enable = true;
  };
  
  # zoxide
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    
    # map the cd command to zoxide z
    options = [
      "--cmd cd"
    ];
  };
  
  # fish shell
  programs.fish = {
    enable = true;
    
    shellAliases = {
      podb = "podman build -t";
      podr = "podman run -it";
      nixhome = "nix run nixpkgs#home-manager -- switch --flake ./#$USER";
      nixshell = "nix-shell";
      v = "vim";
      e = "vim"; 
      ls = "ls";
      sl = "ls"; # yes this was really necessary...
      add = "git add .";
      commit = "git commit -m";
      push = "git push";
      pull = "git pull";
      clone = "git clone";
      f = "fuck";
    };
  };

  programs.home-manager.enable = true;

  # vim ultisnips
  home.file.".vim/UltiSnips/all.snippets" = {
    text = snippets;
    force = true;
  };

  home.file.".vim/UltiSnips/markdown.snippets" = {
    text = markdown;
    force = true;  
  };

  home.file.".vim/UltiSnips/html.snippets" = {
    text = html;
    force = true;
  };

  home.file.".vim/UltiSnips/snippets.snippets" = {
    text = snippets-snippets;
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
    set nowrap
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  set expandtab
  set termguicolors
  colorscheme vim-monokai-tasty
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsSnippetDirectories=["UltiSnips"]
  let g:NERDTreeWinSize = 20
  let g:ale_completion_enabled = 1
  let g:ale_lint_on_text_changed = "always"

  autocmd VimEnter * NERDTree | wincmd p

  autocmd BufNewFile,BufRead *.vpm call SetVimPresentationMode()
  function SetVimPresentationMode()
    nnoremap <buffer> <Right> :n<CR>
    nnoremap <buffer> <Left> :N<CR>

    NERDTreeClose
  endfunction

  " Automatically close Vim if NERDTree is the only window left
  autocmd BufEnter * if winnr('$') == 1 && getbufvar(winbufnr(0), '&filetype') == 'nerdtree' | quit | endif
'';

    # vim plugins
    plugins = with pkgs.vimPlugins; [
       vim-monokai-tasty
       ultisnips
       nerdtree
       ale
       vim-airline
    ];
  };
}
