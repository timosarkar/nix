{ pkgs, lib, allowed-unfree-packages, ... }: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "22.11";
  home.packages = with pkgs; [ 
    # add unFree packages here
    obsidian
    (pkgs.shortcat.overrideAttrs (oldAttrs: {
      version = "latest";
    }))
  ];
  
  programs.home-manager.enable = true;

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
  
  # zsh
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;

    initExtra = ''
      PS1='%F{green}%~%f $ '
    '';

    shellAliases = {
      ls = "ls --color=auto -F";
      test2 = "echo 'hello from home-manager!'";
      test4 = "echo 4";
    };
  };

  # fish shell
  programs.fish = {
    enable = true;
    
    shellAliases = {
      podb = "podman build -t";
      podr = "podman run -it";
      nixhome-linux = "nix run nixpkgs#home-manager -- switch --flake ./#$USER";
      nixhome-mac = "nix --extra-experimental-features 'nix-command flakes' build .#darwinConfigurations.$HOST.system";
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

  # vim
  programs.vim = {
    enable = true;
    settings = {
      relativenumber = true;
      number = true;
      mouse = "a";
    };

    extraConfig = ''
    set nowrap
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
    set expandtab
    set termguicolors

    colorscheme vim-monokai-tasty
    
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsSnippetDirectories = ["UltiSnips"]
    let g:NERDTreeWinSize=20
    let g:ale_completion_enable=1
    let g:ale_lint_on_text_changed="always"

    autocmd VimEnter * NERDTree | wincmd p
    autocmd BufEnter * if winnr('$') == 1 && getbufvar(winbufnr(0), '&filetype') == 'nerdtree' | quit | endif
    '';

    plugins = with pkgs.vimPlugins; [
      vim-monokai-tasty
      ultisnips
      nerdtree
      ale
      vim-airline
    ];
  };
  
  # vim ultisnips 
  home.file.".vim/UltiSnips/all.snippets".source = ./files/all.snippets;
}
