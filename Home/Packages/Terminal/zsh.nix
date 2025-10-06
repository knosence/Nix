{ config, pkgs, user, ... }:

let
  zinitDir = "${config.xdg.dataHome}/zinit/zinit.git";
in {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = false; # handled via zinit
    syntaxHighlighting.enable = false; # handled via zinit
    history = {
      size = 5000;
      save = 5000;
      ignoreSpace = true;
      ignoreDups = true;
      expireDuplicatesFirst = true;
      share = true;
    };

    shellAliases = {
      ls = "ls --color";
      vim = "nvim";
      c = "clear";
      hm = "cd ~/Nix && git add . && home-manager switch --flake .#${user}";
      n = "nvim";
      y = "yazi";
      sshv = "ssh biqu@Voron2.local";
      sshb = "ssh biqu@BlvMgnCub.local";
    };

    initExtraFirst = ''
      # Powerlevel10k instant prompt
      if [[ -r ''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh ]]; then
        source ''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh
      fi
    '';

    initExtra = ''
      # Add local bin to PATH
      export PATH=$HOME/.local/bin:$PATH

      # Setup Zinit if missing
      if [ ! -d "${zinitDir}" ]; then
        mkdir -p "$(dirname ${zinitDir})"
        git clone https://github.com/zdharma-continuum/zinit.git "${zinitDir}"
      fi
      source "${zinitDir}/zinit.zsh"

      # Zinit plugins
      zinit ice depth=1; zinit light romkatv/powerlevel10k

      zinit light zsh-users/zsh-syntax-highlighting
      zinit light zsh-users/zsh-completions
      zinit light zsh-users/zsh-autosuggestions
      zinit light Aloxaf/fzf-tab

      # Snippets
      zinit snippet OMZP::git
      zinit snippet OMZP::sudo
      zinit snippet OMZP::archlinux
      zinit snippet OMZP::aws
      zinit snippet OMZP::kubectl
      zinit snippet OMZP::kubectx
      zinit snippet OMZP::command-not-found

      autoload -Uz compinit && compinit
      zinit cdreplay -q

      # Load p10k config if exists
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

      # Keybindings
      bindkey -e
      bindkey '^p' history-search-backward
      bindkey '^n' history-search-forward
      bindkey '^[w' kill-region

      # Completion styling
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

      # Shell integrations
      eval "$(fzf --zsh)"
      eval "$(zoxide init --cmd cd zsh)"
    '';
  };

  # Optional: Install required packages
  home.packages = with pkgs; [
    zoxide
    fzf
    git
    zsh
  ];
}

