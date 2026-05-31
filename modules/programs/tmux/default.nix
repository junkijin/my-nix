{ ... }:

{
  programs.tmux = {
    enable = true;
    sensibleOnTop = false;

    prefix = "C-q";
    terminal = "tmux-256color";
    historyLimit = 9999999;
    mouse = true;
    focusEvents = true;
    escapeTime = 0;
    baseIndex = 1;
    keyMode = "vi";

    extraConfig = ''
      set -as terminal-features ',xterm-kitty:hyperlinks:RGB:sync:usstyle:strikethrough:extkeys'
      set -s set-clipboard external
      set -g allow-passthrough all
      set -g set-titles on
      set -g set-titles-string "#{?#{==:#{pane_title},#h},#{pane_current_command},#{pane_title}}"

      set -g extended-keys always
      set -g extended-keys-format csi-u

      setw -g pane-base-index 0
      set -g renumber-windows on

      setw -g pane-border-style fg="#504945"
      setw -g pane-active-border-style fg="#504945"

      set -g status on
      set -g status-position bottom
      set -g status-justify right
      set -g status-style bg="#1d2021",fg="#e2cca9"
      set -g status-left "#[fg=yellow]#{?client_prefix,#[fg=#80aa9e],} 󱂬 #S  #[fg=green]󰘴 #W"
      set -g status-left-length 50
      set -g status-right ' '
      set -g status-right-length 50

      setw -g window-status-format ' #I '
      setw -g window-status-current-format ' #I '
      setw -g window-status-separator ""
      setw -g window-status-style bg="#1d2021",fg="#7c6f64"
      setw -g window-status-current-style bg="#282828",fg="#e2cca9"

      bind-key '"' split-window -v -c "#{pane_current_path}"
      bind-key % split-window -h -c "#{pane_current_path}"
      bind-key c new-window -c "#{pane_current_path}"

      bind-key x kill-pane
      bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "~/.config/tmux/tmux.conf reloaded"
      bind-key P swap-window -t -1 \; select-window -t -1
      bind-key N swap-window -t +1 \; select-window -t +1

      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

      bind-key -n C-h if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
      bind-key -n C-j if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
      bind-key -n C-k if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
      bind-key -n C-l if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'

      bind-key -T copy-mode-vi C-h select-pane -L
      bind-key -T copy-mode-vi C-j select-pane -D
      bind-key -T copy-mode-vi C-k select-pane -U
      bind-key -T copy-mode-vi C-l select-pane -R

      bind-key -n M-h if-shell "$is_vim" 'send-keys M-h' 'resize-pane -L 3'
      bind-key -n M-j if-shell "$is_vim" 'send-keys M-j' 'resize-pane -D 3'
      bind-key -n M-k if-shell "$is_vim" 'send-keys M-k' 'resize-pane -U 3'
      bind-key -n M-l if-shell "$is_vim" 'send-keys M-l' 'resize-pane -R 3'
    '';
  };
}
