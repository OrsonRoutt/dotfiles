# Remove greeting.
set fish_greeting ""

# Colorless, simple prompt.
function fish_prompt
  if jobs --query
    set -f JOB ' '
  else
    set -f JOB ''
  end
  printf '%s %s@%s %s %s$ ' (date '+%T') $USER (prompt_hostname) (prompt_pwd --full-length-dirs 2) $JOB
end

# XDG home dirs.
set XDG_CONFIG_HOME $HOME/.config
set XDG_DATA_HOME $HOME/.local/share
set XDG_STATE_HOME $HOME/.local/state
set XDG_CACHE_HOME $HOME/.cache

# Read from `/tmp/fish_cwd` and, if it exists, `cd` to it..
function cwd
  set -l TMP /tmp/fish_cwd
  if test -f $TMP
    cd (cat $TMP)
    rm $TMP
  end
end

# Rebind `nvim` to run `cwd` after.
function nvim
  command nvim $argv
  cwd
end

# Rebind `fg` to run `cwd` after.
function fg
  builtin fg $argv
  cwd
end

# Customise `ls`.
function ls
  command ls -A -p -C --color=auto $argv
end

# Sane defaults.
function emacs
  command nvim $argv
end

# Bind <C-z> to 'fg'.
bind \cz 'fg 2>/dev/null;commandline -f repaint'
