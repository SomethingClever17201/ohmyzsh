orange=$'\033[38;5;202m'
brown=$'\033[1;34m'


late=$(find . -type f -not -path '*/.*' -printf "%TY-%Tm-%Td %TH:%TM:%TS %Tz %p\n" | sort -n | tail -n 1 | cut -d ' ' -f4 | 
    sed 's/.*main\/default\///' )


if [ -f ./sfdx-project.json ]
then 
  # curOrg=$(cat .sf/config.json | jq '."target-org"' -r)
  # precmd() { 
  #   print -rP "${orange}$curOrg%{$reset_color%}" 
  #   print -rP "$late" 
  # }
  # precmd_functions+=(myhook)
  zsf_active="[%D{%L:%M:%S %p}] %(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%c%{$reset_color%}"
else
  zsf_active="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%c%{$reset_color%}"
fi



#zsf_active="%{$fg[yellow]%}$curOrg %{$fg[cyan]%}%c%{$reset_color%} "
#zsf_active="$curOrg %{$fg[cyan]%}%c%{$reset_color%} "
