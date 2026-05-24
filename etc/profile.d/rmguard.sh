# Load rmguard only in interactive shells
case $- in *i*) ;; *) return ;; esac

# If the shell already has an rm alias, clear it before defining the function.
# Otherwise alias expansion can break the function definition while sourcing.
unalias rm 2>/dev/null || true

# rm function → goes through rmguard
rm() { /usr/lib/rmguard/rmguard "$@"; }

# Friendly alias (asks for confirmation in batches, preserves "/")
alias rm='rm -I --preserve-root=all -v'

# Guard active by default (you can use RM_GUARD=0 to disable temporarily)
export RM_GUARD=${RM_GUARD:-1}
export RM_GUARD_SHELL_LOADED=1
