function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting

end

function ejectdev
  if test (count $argv) -ne 1
    echo "Usage: ejectdev <device_name> (e.g. sdb)"
    return 1
  end

  set dev /dev/$argv[1]

  # unmount all partitions
  for part in (lsblk -ln -o NAME $dev | tail -n +2)
    echo "Unmounting /dev/$part"
    sudo umount /dev/$part
  end

  echo "Powering off $dev"
  sudo udisksctl power-off -b $dev
end


starship init fish | source

# Make it easy to switch to commonly-used directories
zoxide init fish --cmd cd | source

## Rust
# Enable a shared Cargo target directory to cut down on disk usage
set -x CARGO_TARGET_DIR $HOME/.cargo/shared_target
set -x XDG_CONFIG_HOME $HOME/.config 
set -x GIT_EDITOR nvim


# Ensure that Cargo binaries are in the PATH
set PATH $HOME/.cargo/bin/ $PATH
set PATH $HOME/.local/share/nvim/mason/bin $PATH

set EDITOR nvim


# Helpful aliases
command -q exa; and alias la="exa -abghl --git --color=automatic"
command -q exa; and alias ll="exa -bghl --git --color=automatic"

set -x MANPAGER "nvim -c 'Man!' -o -"

alias exa="exa -abghl --git --color=automatic"
alias rsync="rsync -avzhPc"
alias lssize='du -h --max-depth=1 | sort -rh'

# Fisher!
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

if not set -q TMUX
    if test -f ~/.cache/ags/user/generated/terminal/sequences.txt
        # cat ~/.cache/ags/user/generated/terminal/sequences.txt
        cat ~/.local/state/caelestia/sequences.txt 2> /dev/null
    end
end

alias pamcan=pacman

 #function fish_prompt
 #  set_color cyan; echo (pwd)
 #  set_color green; echo '> '
 #end

#Alias wine32='WINEARCH=win32 WINEPREFIX=/home/Abdullah/.win32 wine'
#Alias wine64='WINEARCH=win64 WINEPREFIX=/home/Abdullah/.win64 wine'
#Function win32
#    export WINEARCH=win32
#    export WINEPREFIX=/home/Abdullah/.win32
#  end
#
#Function win64
#    export WINEARCH=win64
#    export WINEPREFIX=/home/Abdullah/.win64
#  end


# Enable vi keybindings
fish_vi_key_bindings

set -U fish_cursor_default block

# show underscore when in replace ('r')
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore

