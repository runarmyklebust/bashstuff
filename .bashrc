# #### Runars .bashrc - MACenabled#####
#

########################
# Bash history tweaks
########################

# Set larger history
HISTSIZE=9000
HISTFILESIZE=$HISTSIZE

# Ignore duplicates and commands with leading spaces
HISTCONTROL=ignorespace:ignoredups

# Appended to the histfile instead of overwriting on exit
shopt -s histappend

#history() {
#  _bash_history_sync
#  builtin history "$@"
#}

# LOCALE
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# ENV
export WORKSPACE=~/Dev
export GRADLE_HOME=/opt/local/share/java/gradle/bin/gradle
export APP_WS="$WORKSPACE/apps"
export GRADLE_OPTS="-Dorg.gradle.daemon=true -Xms512m -Xmx3G"
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export MAVEN_OPTS="-Xmx1G -XX:MaxPermSize=512m"
export DYLD_LIBRARY_PATH="/Applications/YourKit_Java_Profiler_12.0.5.app/bin/mac"

# XP Stuff
export WORKSPACE_ENONIC="$WORKSPACE"
export GIT_REPO="$WORKSPACE_ENONIC/git"
export XP_HOME="$WORKSPACE_ENONIC/xp/home"
export XP_DIST="$WORKSPACE_ENONIC/xp"
export XP_DEV="$GIT_REPO/xp"

# Java
# export JAVA_OPTS="-Xbootclasspath/p:$CATALINA_HOME/lib/xalan-2.7.0.jar -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005 -Xmx1024m"

# Pathstuff
export PATH=$JAVA_HOME/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=~/bin:$PATH
export PATH=$APP_WS/bin:$PATH

# Google Cloud SDK
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/rmy/Dev/apps/google-cloud-sdk/path.bash.inc' ]; then . '/Users/rmy/Dev/apps/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/rmy/Dev/apps/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/rmy/Dev/apps/google-cloud-sdk/completion.bash.inc'; fi

# GO
export GO_WS="/Users/rmy/Dev/git/Go"
export GOPATH=$GO_WS
export PATH=$PATH:$GO_WS/bin
export GO_ENONIC_HOME=$GO_WS/src/github.com/enonic

#Node js stuff
#export NODE_PATH="/Users/runarmyklebust/Dev/Workspace/Java/Enonic/git/nodeJsProject/node_modules"
#export PATH=/Users/runarmyklebust/Dev/Workspace/Java/Enonic/git/nodeJsProject/node_modules/.bin:$PATH
#export PATH=/usr/local/share/npm/bin:$PATH

if [ $(type -t acoc) ];then
	echo "Aliasing with acoc..."
	alias ping="acoc ping -c 5"
	alias df="acoc df"
	alias traceroute="acoc traceroute"
    alias svn="acoc svn"
    alias mvn="acoc mvn"
	alias curl="acoc curl"
    # gnu diff options:
    #   -w (--ignore-all-space)
    #   -u NUM (output NUM lines of unified context - default is 3)
    alias diff="acoc diff -uw"
    # Brukes for å tail'e log4j logger med acoc fargelegging
    #alias med acoc, spesifiseres vha \less)
    # Kan ikke lage en funksjon med navn less, siden alias'et overstyrer funksjonen
    # Løsningen er å gjøre det manuelt: less fil.log | \less
    alias less='acoc less'
    alias cat='acoc cat'
    #alias acoc-refresh="cp -f $(cygpath --unix $CYGWIN_USERHOME_SRC)/.acoc.conf ~/"


    function colorString() {
        usage="Usage: colorString [-c acoc_color] string..."
       # Håndter -c opsjonen for å angi acoc farge
        if [ "$1" == -c ]; then
            export DYNAVAL_COL=${2:?$usage}
            shift 2
        fi

        arg1=${1:?$usage}
        export DYNAVAL=$@
        #echo DYNAVAL=$DYNAVAL
        acoc echo ${DYNAVAL}
        # remove var to avoid trouble
        unset DYNAVAL DYNAVAL_COL
    }
fi

    function colorMe() {
        arg1=${1:?Må spesifisere en string som skal fargelegges}
        export DYNAVAL="$@"
        acoc echo "Stringen ${DYNAVAL} vil fargelegges i all kommando-output i ditt nye shell"
        acoc bash --login -i
        unset DYNAVAL
    }

    function setTab() {
	printf "\e]1;$1\a"
    }

# Aliases
alias ll="ls -laF"
alias cc="cd $XP_HOME"
alias ca="cd $APP_WS"
alias sr="sudo su -"
alias reload="colorString -c green sourcing .bashrc && source ~/.bashrc"
alias psjava="ps -ef | grep java
alias editBashrc="vi ~/.bashrc;reload"
alias conf="cd ~/bin/configs"
alias cp="cp -R"
alias sub="open /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl"
alias pretty="python -mjson.tool"
alias xp="$XP_DEV/modules/runtime/build/install/bin/server.sh"
#alias xp="/Users/rmy/Dev/xp/bin/server.sh"
alias cdoc="cd $APP_WS/docker"
alias dc="docker-compose"

alias cal="gcal -K"

# App shortcuts
alias k="kubectl"

EC_CLOUD_HOME="$GIT_REPO/ec-cloud"
alias cgp="cd $EC_CLOUD_HOME/env-ec-prod"
alias cgd="cd $EC_CLOUD_HOME/env-ec-dev"
alias cgg="cd $GO_ENONIC_HOME"

up() {
	LIMIT=$1

	if [ -z "$LIMIT" ]; then
		LIMIT=1
	fi

	SEARCHPATH=$PWD

	# If argument is not numeric, try match path
	if ! [[ "$LIMIT" =~ ^[0-9]+$ ]] ; then
	 	if ! [[ "$SEARCHPATH" =~ ^.*$LIMIT.*$ ]] ; then
			echo "expression not found"
		else
			while [ true ]; do
				SEARCHPATH=$SEARCHPATH/..
				cd $SEARCHPATH
				if [[ ${PWD##*/} =~ ^.*$LIMIT.*$ ]]; then
					break;
				elif [[ -z ${PWD##*/} ]]; then
					break;
				fi
			done
		fi
	else
		# go n directories up
		for ((i=1; i <= LIMIT; i++))
			do
				SEARCHPATH=$SEARCHPATH/..
			done
		cd $SEARCHPATH
	fi
}

#  colors
export CLICOLOR=true
export LSCOLORS=${LSCOLORS:-ExFxCxDxBxegedabagacad}

# Prompt
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[0;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[0;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

# Override cd to check for localevn.
# Is exists, source it => Use this to create separate env for different dirs, e.g CVS_ROOT, JAVA_HOME etc
cd() {
  builtin cd "$@"
  [ -f localenv ] && echo "setting localenv.." && source localenv
}

# Function to quick cd to git repositories, uses _set_gitrepository-TC
cg() {
	builtin cd $GIT_REPO/$1
}

# Function to checkout branches, uses _set_listbranches-TC
branch() {
    git checkout $1
}

# Get branches and remove * to not fuck up TabCompletion
getBranches() {
	BRANCHES=$(git branch | sed 's/*//')
	echo $BRANCHES
}

# tunneling

alias tunnel_prod_db="ssh -L 54321:icarus:5432 rmy@beast.enonic.net"
alias tunnel_prod_ldap="ssh -L 3891:ldap:389 rmy@beast.enonic.net"

# System test stuff

alias tail_packages_log="acoc ssh root@versiontest tail -100f /home/cms-commando-unstable-packages/enonic-cms/logs/catalina.out"
alias tail_testprod_log='acoc ssh root@testprod tail -100f /home/tomcat/enonic-cms/logs/catalina.log'
alias tail_packages_45='acoc ssh root@vtnode1 tail -100f /home/cms-commando-unstable-packages/enonic-cms/logs/catalina.log'
alias tail_packages_44='acoc ssh root@versiontest tail -100f /home/cms-commando-stable-packages/enonic-cms/logs/catalina.log'
alias tail_packages_454='acoc ssh root@vtnode1 tail -100f /home/cms-commando-stable-packages/enonic-cms/logs/catalina.log'
alias tail_enonic_46="acoc ssh root@vtnode2 tail -100f /home/cms-46-elasticsearch-enonic/enonic-cms/logs/catalina.log"
alias tail_ssb='acoc ssh root@vtnode2 tail -100f /home/cms-46-elasticsearch-ssb/enonic-cms/logs/catalina.log'
alias go_versiontest="ssh root@versiontest"
alias go_testprod="ssh root@testprod"
alias go_ansatt="ssh rmy@ansatt.enonic.com"
alias go_beast="ssh rmy@beast.enonic.net"
alias go_prod="go_beast"
alias go_testdb="ssh root@testdb"
alias go_vtnode1="ssh root@vtnode1"
alias go_vtnode2="ssh root@vtnode2"
alias go_vtnode3="ssh root@vtnode3"

# Custom tab completion
########################

# Activate
shopt -s progcomp

#Functions

gradle() {
	date "+Build started: %Y-%m-%d %H:%M:%S"
	command gradle $@
}

_set_intellij_context-TC() {
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $( compgen -W '$( ls ~/bin/configs/tomcat_db_contexts)' $cur ) )
}

_set_blobstore-TC() {
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $( compgen -W '$( ls ~/bin/configs/blobstores)' $cur ) )
}

_set_config-TC() {
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $( compgen -W '$( ls ~/bin/configs/configs)' $cur ) )
}

_set_plugin-TC() {
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $( compgen -W '$( ls ~/bin/configs/plugins)' $cur ) )
}

_set_index-TC() {
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $( compgen -W '$( ls ~/bin/configs/index)' $cur ) )
}

_set_resource-TC() {
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $( compgen -W '$( ls ~/bin/configs/resources)' $cur ) )
}

_set_gitrepository-TC() {
	local cur
	cur=${COMP_WORDS[COMP_CWORD]}
	COMPREPLY=( $( compgen -W '$( ls $GIT_REPO)' $cur ))
}

_set_listbranches-TC() {
	local cur
	cur=${COMP_WORDS[COMP_CWORD]}
	COMPREPLY=( $( compgen -W '$( getBranches)' $cur ))
}

# Bind custom tab-completions
complete -F _set_intellij_context-TC set_intellij_context.sh
complete -F _set_blobstore-TC set_blobstore.sh
complete -F _set_config-TC set_config.sh
complete -F _set_plugin-TC set_plugins.sh
complete -F _set_index-TC set_index.sh
complete -F _set_resource-TC set_resources.sh
complete -F _set_gitrepository-TC cg
complete -F _set_listbranches-TC branch

complete -F _set_intellij_context-TC 2set_intellij_context.sh
complete -F _set_blobstore-TC 2set_blobstore.sh
complete -F _set_config-TC 2set_config.sh
complete -F _set_plugin-TC 2set_plugins.sh
complete -F _set_index-TC 2set_index.sh
complete -F _set_resource-TC 2set_resources.sh



java7() {
export JAVA_HOME=`/usr/libexec/java_home -v 1.7`
}
java8() {
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
}
java11() {
export JAVA_HOME=`/usr/libexec/java_home -v11`
}

# PROMPT STUFF
########################

## Enables executing .dirrc file if present in directory
#function _execute_dirrc() {
#	if [ "${PREV}" != "$(pwd -P)" ]; then
#	    if [ -r .dirrc ]; then
#	        . ./.dirrc
#	    fi
#	    PREV=$(pwd -P)
#	fi
#}

# PSMON
#############

function psmon {

  if [ $# -eq 0 ]
    then
      echo "PID must be provided"
      exit 1
  fi

  echo "Monitor pid: $1"
  while true; do ps -p $1 -o pid,rss,vsz,%mem,%cpu,comm | awk '{$2=int($2/1024)"M";}{ print;}';sleep 4; done
}


# GIT Aware prompt
########################

# Detect whether the current directory is a git repository.
function is_git_repository {
  git branch > /dev/null 2>&1
}

function set_git_branch {
  # Capture the output of the "git status" command.
  git_status="$(git status 2> /dev/null)"

  # Set color based on clean/staged/dirty.
  if [[ ${git_status} =~ "working tree clean" ]]; then
	state="${BLUE}"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
	state="${RED}"
	elif [[ ${git_status} =~ "no changes added to commit" ]]; then
	state="${YELLOW}"
  else
	state="${RED}"
  fi

  # Set arrow icon based on status against remote.
  remote_pattern="# Your branch is (.*) of"
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
		if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
			remote="↑"
    	else
			remote="↓"
    	fi
 else
	remote=""
 fi

diverge_pattern="# Your branch and (.*) have diverged"
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
	remote="↕"
  fi

  # Get the name of the branch.
  branch_pattern="^On branch ([^${IFS}]*)"
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
  fi

  # Set the final branch string.
  BRANCH="${state}[${branch}]${remote}${COLOR_NONE} "

}

BASE_PS="\[$(tput bold)\]\[\033[38;5;22m\]\w\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\]\[$(tput sgr0)\]"
BASE_PS_POST="\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;0m\]\\$\[$(tput sgr0)\] "

function set_git_enabled_prompt () {

  # Set the BRANCH variable.
  if is_git_repository ; then
	set_git_branch
  else
	BRANCH=' '
  fi

  # Set the bash prompt variable.
  PS1="${BASE_PS}${BRANCH}${BASE_PS_POST}"
}

PS1="${BASE_PS}${BASE_PS_POST}"

function tabname {
  printf "\e]1;$1\a"
}

function cd_set_tab() {
	if [ -f .tab ]; then
		TAB_NAME=$(cat .tab)
		tabname $TAB_NAME
	else
		tabname $PWD
	fi
}

function jps() {
 	ARGS=$1

	if [ -z "$ARGS" ]; then
		ARGS="-lvm"
	fi

	command jps $ARGS | sed -e 's/-D/\'$'\n\t-D/g' | sed -e 's/-X/\'$'\n\t-X/g'
}

export PROMPT_COMMAND="cd_set_tab; set_git_enabled_prompt; $PROMPT_COMMAND"

# Bind prompt-commands
#export PROMPT_COMMAND=" $PROMPT_COMMAND"
#export PROMPT_COMMAND="_execute_dirrc; $PROMPT_COMMAND"


function readMan() {
 tr -d '\r\n[:space:]' < $1 | sed -e $'s/,/\\\n/g' |  sed -e $'s/Export-Package/\\\n\\\n###### Export-Package ####### \\\n/g' | sed -e $'s/Import-Package/\\\n\\\n###### Import-Package ####### \\\n/g'
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/runarmyklebust/.sdkman"
[[ -s "/Users/runarmyklebust/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/runarmyklebust/.sdkman/bin/sdkman-init.sh"
