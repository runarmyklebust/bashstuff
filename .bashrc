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

# ENV
export WORKSPACE=~/Dev/Workspace
export JAVA_WS=$WORKSPACE/Java
export DB_WS=$WORKSPACE/DB
export APP_WS=$WORKSPACE/apps
export WORKSPACE_ENONIC=$JAVA_WS/Enonic
export CATALINA_HOME=$APP_WS/tomcat
export INTELLIJ_CATALINA=$APP_WS/tomcat
#export GLASSFISH_HOME=$APP_WS/glassfish
export GRINDER_HOME=$WORKSPACE/Java/grinder-3.2
export GRADLE_HOME=/opt/local/share/java/gradle/bin/gradle
export GRADLE_OPTS="-Dorg.gradle.daemon=true"
#export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.5/Home/
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export MYSQL_HOME=/user/local/mysql
export MAVEN_OPTS="-Xmx1G -XX:MaxPermSize=512m"
export DYLD_LIBRARY_PATH="/Applications/YourKit_Java_Profiler_12.0.5.app/bin/mac"

# CMS Stuff
#export CMS_HOME="$CATALINA_HOME/cms.home"
export CMS_DIST=$WORKSPACE/CMS_DIST
export TRUNK_PLUGINS="$WORKSPACE_ENONIC/plugins"
export TRUNK4_3="$WORKSPACE_ENONIC/4.3"
export TRUNK4_4="$WORKSPACE_ENONIC/git/4.4"
export TRUNK4_2="$WORKSPACE_ENONIC/4.2"
export TRUNK4_5="$WORKSPACE_ENONIC/git/4.5"
export TRUNK4_6="$WORKSPACE_ENONIC/git/4.6"
export TRUNK_CE="$WORKSPACE_ENONIC/git/WEM"
export TRUNK_BRANCH="$WORKSPACE_ENONIC/WEM"
export JBOSS_HOME=/Applications/EnterprisePlatform-5.1.2/jboss-eap-5.1/jboss-as 
export GIT_REPO="$WORKSPACE_ENONIC/git"

# Java
# export JAVA_OPTS="-Xbootclasspath/p:$CATALINA_HOME/lib/xalan-2.7.0.jar -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005 -Xmx1024m"
# Pathstuff
#export PATH=/opt/subversion/bin:$PATH
#export PATH=$APP_WS/maven/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=~/bin:$PATH
export PATH=$CATALINA_HOME/bin:$PATH
export PATH=$GROOVY_HOME/bin:$PATH
export PATH=~/bin/dbtool:$PATH
export PATH=/Users/rmy/Dev/Workspace/apps/android-sdk-macosx/tools:$PATH
export PATH=/Users/rmy/Dev/Workspace/apps/android-sdk-macosx/platform-tools:$PATH

#JMETER
export PATH="/Users/rmy/Dev/Workspace/apps/jmeter/bin/":$PATH

#Node js stuff
export NODE_PATH="/Users/rmy/Dev/Workspace/Java/Enonic/git/nodeJsProject/node_modules"
export PATH=/Users/rmy/Dev/Workspace/Java/Enonic/git/nodeJsProject/node_modules/.bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH

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
alias ll="ls -la"
alias cc="cd ~/Dev/Workspace/apps/wem-distro/distro"
alias cw="cd $GIT_REPO/WEM"
alias cj="cd $JAVA_WS"
alias ce="cd $WORKSPACE_ENONIC"
alias cm="cd $WORKSPACE_ENONIC/cms-trunk"
alias ch="cd ~/"w	
alias cl="cd $JAVA_WS/LABS"
alias ca="cd $APP_WS"
alias sr="sudo su -"
alias reload="colorString -c green sourcing .bashrc && source ~/.bashrc"
alias mysqlstart="colorString starting mySQL at $MYSQL_HOME"
alias psjava="ps -ef | grep java"
alias ct="cd $TRUNK_CE"
alias cex="cd /Users/rmy/Documents/Experience_18_4_2013"
alias cb="cd $TRUNK4_4"
alias cd44="cd $TRUNK4_4"
alias ci="cd $INTELLIJ_CATALINA"
alias cjar="jar tf"
alias xjar="jar xf"
alias psql="/Library/PostgreSQL/8.3/bin/psql"
alias skiptest="mvn -Dmaven.test.skip=true clean install"
alias tunnel_beast="ssh -L 54321:icarus:5432 rmy@beast.enonic.net"
alias tunnel_shadowcat="ssh -L 54321:shadowcat:5432 rmy@beast.enonic.net"
alias g="gradle"
alias editBashrc="vi ~/.bashrc;reload"
alias conf="cd ~/bin/configs"
alias cp="cp -R"
alias pull="git pull --rebase"

#up() {
#	LIMIT=$1
#
#	if [ -z "$LIMIT" ]; then
#		LIMIT=1
#	fi
#
#	SEARCHPATH=$PWD
#	
#	# If argument is not numeric, try match path
#	if ! [[ "$LIMIT" =~ ^[0-9]+$ ]] ; then
#	 	if ! [[ "$SEARCHPATH" =~ ^.*$LIMIT.*$ ]] ; then
#			echo "expression not found"
#		else
#			while [ true ]; do 
#				SEARCHPATH=$SEARCHPATH/..
#				cd $SEARCHPATH
#				if [[ ${PWD##*/} =~ ^.*$LIMIT.*$ ]]; then
#					break;
#				elif [[ -z ${PWD##*/} ]]; then
#					break;
#				fi 
#			done
#		fi
#	else 
#		# go n directories up
#		for ((i=1; i <= LIMIT; i++))
#			do
#				SEARCHPATH=$SEARCHPATH/..
#			done
#		cd $SEARCHPATH
#	fi
#}

# GLASSFISH ALIASES
alias as_start="asadmin start-domain domain1"
alias as_stop="asadmin stop-domain domain1"

# START_TRUNK ALIASES
alias start_post_local_4_4="start_trunc_instance -d cms -s localhost -a tomcat -w /Users/rmy/Dev/Workspace/Java/Enonic/cms-trunk/cms-webapp/target/cms-webapp-4.4.0-SNAPSHOT.war"
alias start_post_local_4_3="start_trunc_instance -d cms4.3 -s localhost -a tomcat -w /Users/rmy/Dev/Workspace/Java/Enonic/cms-trunk/cms-webapp/target/cms-webapp-4.4.0-SNAPSHOT.war"
alias start_packages_local="start_trunc_instance -d packages -s localhost -a tomcat -w /Users/rmy/Dev/Workspace/Java/Enonic/cms-trunk/cms-webapp/target/cms-webapp-4.4.0-SNAPSHOT.war"

alias publishdir="python -m SimpleHTTPServer"
alias pretty="python -mjson.tool"

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
  [ -f localenv ] && colorString setting localenv.. && source localenv
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
_set_intellij_context-TC() {
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $( compgen -W '$( ls /Users/rmy/bin/configs/tomcat_db_contexts)' $cur ) )
}

_set_blobstore-TC() {
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $( compgen -W '$( ls /Users/rmy/bin/configs/blobstores)' $cur ) )
}

_set_config-TC() {
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $( compgen -W '$( ls /Users/rmy/bin/configs/configs)' $cur ) )
}

_set_plugin-TC() {
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $( compgen -W '$( ls /Users/rmy/bin/configs/plugins)' $cur ) )
}

_set_index-TC() {
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $( compgen -W '$( ls /Users/rmy/bin/configs/index)' $cur ) )
}

_set_resource-TC() {
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $( compgen -W '$( ls /Users/rmy/bin/configs/resources)' $cur ) )
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
#
# GIT Aware prompt
########################

# Detect whether the current directory is a git repository.
#function is_git_repository {
#  git branch > /dev/null 2>&1
#}


java7() {
export JAVA_HOME=`/usr/libexec/java_home -v 1.7`
}
java8() {
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
}

#function set_git_branch {
#  # Capture the output of the "git status" command.
#  git_status="$(git status 2> /dev/null)"
#
#  # Set color based on clean/staged/dirty.
#  if [[ ${git_status} =~ "working directory clean" ]]; then
#	state="${BLUE}"
#  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
#	state="${RED}"
#	elif [[ ${git_status} =~ "no changes added to commit" ]]; then
#	state="${YELLOW}"	
#  else
#	state="${RED}"
#  fi
#  
#  # Set arrow icon based on status against remote.
#  remote_pattern="# Your branch is (.*) of"
#  if [[ ${git_status} =~ ${remote_pattern} ]]; then
#		if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
#			remote="↑"
#    	else
#			remote="↓"
#    	fi
# else
#	remote=""
# fi
#
#diverge_pattern="# Your branch and (.*) have diverged"
#  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
#	remote="↕"
#  fi
#  
#  # Get the name of the branch.
#  branch_pattern="^# On branch ([^${IFS}]*)"
#  if [[ ${git_status} =~ ${branch_pattern} ]]; then
#	branch=${BASH_REMATCH[1]}
#  fi
#
#  # Set the final branch string.
#  BRANCH="${state}[${branch}]${remote}${COLOR_NONE} "
#
#}

#function set_git_enabled_prompt () {
#   
#  # Set the BRANCH variable.
#  if is_git_repository ; then
#	set_git_branch
#  else
#	BRANCH=' '
#  fi
#  
#  # Set the bash prompt variable.
#  PS1="\[\e[$((32-${?}))m\]\w\[\e[0m\]${BRANCH}\$ "
#}
#


PS1="\[\e[$((32-${?}))m\]\w\[\e[0m\]\$ "

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

#export PROMPT_COMMAND="cd_set_tab; set_git_enabled_prompt; $PROMPT_COMMAND"
export PROMPT_COMMAND="cd_set_tab; $PROMPT_COMMAND"


# Bind prompt-commands
#export PROMPT_COMMAND=" $PROMPT_COMMAND"
#export PROMPT_COMMAND="_execute_dirrc; $PROMPT_COMMAND"
