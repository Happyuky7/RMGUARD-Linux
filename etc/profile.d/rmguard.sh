# Load rmguard only in interactive shells
case $- in *i*) ;; *) return ;; esac

# rm function → goes through rmguard
rm() { /usr/lib/rmguard/rmguard "$@"; }

# Friendly alias (asks for confirmation in batches, preserves "/")
alias rm='rm -I --preserve-root=all -v'

# Guard active by default (you can use RM_GUARD=0 to disable temporarily)
export RM_GUARD=${RM_GUARD:-1}
