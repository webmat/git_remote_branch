_grb()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    local verb=${COMP_WORDS[1]}

    local position=${COMP_CWORD}
    
    if [[ "$verb" == "explain" ]]; then
        let "position = $position - 1"
    fi

    case "$position" in
        1)
            COMPREPLY=( $(compgen -W "help explain create new delete destroy kill remove rm rename rn mv move track follow grab fetch" -- $cur) )
            ;;
        2)

            COMPREPLY=( $(compgen -W "$(_grb_branch)" -- $cur))
            ;;
        3)

            COMPREPLY=( $(compgen -W "$(_grb_remotes)" -- $cur))
            ;;
    esac
}

_grb_branch()
{
   {
       git for-each-ref refs/remotes --format="%(refname:short)" | 
       grep -v HEAD |
       sed 's/^.*\///g'; 
       git for-each-ref refs/heads --format="%(refname:short)";
   } | sort | uniq
}

_grb_remotes()
{
	local i IFS=$'\n'
	for i in $(git config --get-regexp 'remote\..*\.url' 2>/dev/null); do
		i="${i#remote.}"
		echo "${i/.url*/}"
	done
}

complete -F _grb grb

