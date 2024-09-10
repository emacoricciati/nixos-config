{ inputs, lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    tmux
  ];

  programs.tmux = {
    enable = true;
    extraConfig = ''
      # Imposta il terminale predefinito
      set -g default-terminal "screen-256color"

      # Abilita il mouse
      set -g mouse on

      # Imposta il prefisso su Ctrl + b
      set -g prefix C-b
      unbind C-b  # Disabilita il vecchio prefisso
      bind-key C-s send-prefix  # Usa Ctrl + s come nuovo prefisso

      # Comandi per navigare tra i pannelli
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Comandi per chiudere un pannello
      bind-key x kill-pane

      # Abilita l'uso di vi in modalità copia
      set-window-option -g mode-keys vi

      # Abilita il copiare e incollare
      bind-key -T copy-mode-vi v begin-selection
      bind-key -T copy-mode-vi y copy-selection-and-cancel

      # Personalizza la barra di stato
      set -g status-bg colour8
      set -g status-fg blue
      set -g status-right ' #{pane_current_path}  %Y-%m-%d %H:%M '
    '';
  };
}

