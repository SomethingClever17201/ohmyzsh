#PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%c%{$reset_color%}"
# PROMPT="$zsf_active"
# PROMPT+=' $(git_prompt_info)'
alias sfbash="source ~/sfbash/sfZsh"

autoload -U is-at-least
TMOUT=1
if is-at-least 5.1; then
    # avoid menuselect to be cleared by reset-prompt
    redraw_tmout() {
        [ "$WIDGET" = "expand-or-complete" ] && [[ "$_lastcomp[insert]" =~ "^automenu$|^menu:" ]] || zle reset-prompt
    }
else
    redraw_tmout() { zle reset-prompt }
fi
TRAPALRM() { 
    local precmd
    for precmd in $precmd_functions; do
      $precmd
    done
    redraw_tmout
}

set_prompt()
{
  PROMPT=""

  #if a current salesforce directory exists, do thing
  if [ -f '.sf/config.json' ]
  then
    curOrg=$(cat .sf/config.json | jq '."target-org"' -r)
    PROMPT="${orange}$curOrg%{$reset_color%}"$'\n'
  fi

    #find in current directory
    late=$(cat ~/updatedFiles | grep "$PWD" | grep -v "$PWD/\..*" | tail -n 1)
    # ignore hidden
    # ignoreVars=('git')
    #
    # for var in ${ignoreVars[@]}
    # do
    #     late=$(echo "$late" | grep -v "$var")
    # done

    # late=$(echo "$late" | grep -v "git")



    # late=$(cat ~/updatedFiles | cut -f3 -d " " | grep -v "^\.")

    #remove path, and delimiter
    dispLate="$(echo ${late/$PWD/} | sed 's/.//')"
    PROMPT+="$dispLate"$'\n'


  if [ -f '.sf/config.json' ]
  then
    for job state ("${(@kv)jobstates}") {
        pgid=${${state%%=*}##*:}
        current=$(pgrep -ag $pgid)
        [[ $current =~ "sf" ]] && PROMPT+="%{$fg[yellow]%}Logging..."$'\n'
    }
  fi



  [ -d '.git' ] && PROMPT+='$(git_prompt_info)'$'\n'
  PROMPT+="[%D{%Y-%m-%d} %D{%L:%M:%S %p}] %(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%c%{$reset_color%} "
}
set_prompt

autoload -Uz add-zsh-hook
add-zsh-hook precmd set_prompt

#RPROMPT='$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
