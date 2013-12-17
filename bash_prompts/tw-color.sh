#!/bin/bash

# Based on:
#   termwide prompt with tty number
#      by Giles - created 2 November 98
#

function prompt_command {

retstat=$?

TERMWIDTH=${COLUMNS}

#   Calculate the width of the prompt:

hostnam=$(echo -n $HOSTNAME | sed -e "s/[\.].*//")
#   "whoami" and "pwd" include a trailing newline
usernam=$(whoami)
cur_tty=$(tty | sed -e "s/.*tty\(.*\)/\1/")
newPWD="${PWD}"
#   Add all the accessories below ...
git_ps1=$(__git_ps1 "%s:")

let promptsize=$(echo -n "--(${usernam}@${hostnam})---(${git_ps1}${PWD})--" \
                 | wc -c | tr -d " ")
let fillsize=${TERMWIDTH}-${promptsize}
fill=""
while [ "$fillsize" -gt "0" ] 
do 
    fill="${fill}-"
	let fillsize=${fillsize}-1
done

if [ "$fillsize" -lt "0" ]
then
   let cut=3-${fillsize}
	newPWD="...$(echo -n $PWD | sed -e "s/\(^.\{$cut\}\)\(.*\)/\2/")"
fi
}

PROMPT_COMMAND=prompt_command

function tw-color {

local GRAY="\[\033[1;30m\]"
local LIGHT_GRAY="\[\033[0;37m\]"
local RED="\[\033[0;31m\]"
local WHITE="\[\033[1;37m\]"
local NO_COLOUR="\[\033[0m\]"

local LIGHT_BLUE="\[\033[1;34m\]"
local YELLOW="\[\033[1;33m\]"
local GREEN="\[\033[1;32m\]"

if [ "$(id -u)" == "0" ];
then
    local USER_COLOR="\[\033[1;31m\]"
else
    local USER_COLOR="\[\033[1;32m\]"
fi    

case $TERM in
    xterm*)
        TITLEBAR='\[\033]0;\u@\h:\w\007\]'
        ;;
    *)
        TITLEBAR=""
        ;;
esac


PS1="$TITLEBAR\
\n$GREEN-$LIGHT_BLUE-(\
$USER_COLOR\$usernam$LIGHT_BLUE@$GREEN\$hostnam$WHITE\\
${LIGHT_BLUE})-${GREEN}-\${fill}${LIGHT_BLUE}-(\
\$(__git_ps1 \"$WHITE%s$LIGHT_BLUE:\")\
$YELLOW\${newPWD}\
$LIGHT_BLUE)-$GREEN-\
\n\
$GREEN-$LIGHT_BLUE-(\
$GREEN\$(date \"+%I%M %p\")\
$LIGHT_BLUE:\
\[\033[\$(( (\$retstat == 0 ) ? 37 : 31 ))m\]\$retstat\
$LIGHT_BLUE:$WHITE\$$LIGHT_BLUE)-\
$GREEN-\
$NO_COLOUR " 

#PS1="$TITLEBAR\
#$YELLOW-$LIGHT_BLUE-(\
#$YELLOW\$usernam$LIGHT_BLUE@$YELLOW\$hostnam$LIGHT_BLUE:$WHITE\$cur_tty\
#${LIGHT_BLUE})-${YELLOW}-\${fill}${LIGHT_BLUE}-(\
#$YELLOW\${newPWD}\
#$LIGHT_BLUE)-$YELLOW-\
#\n\
#$YELLOW-$LIGHT_BLUE-(\
#$YELLOW\$(date +%H%M)$LIGHT_BLUE:$YELLOW\$(date \"+%a,%d %b %y\")\
#$LIGHT_BLUE:$WHITE\$$LIGHT_BLUE)-\
#$YELLOW-\
#$NO_COLOUR " 

PS2="$LIGHT_BLUE-$YELLOW-$YELLOW-$NO_COLOUR "

}

