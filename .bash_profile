# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";
export PATH="$HOME/anaconda/bin:$PATH";
export PATH="/usr/local/bin:$PATH";


source .todo_completion
complete -F _todo t

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
	source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;


###############################################################################
# Gully's setup files                                                         #
###############################################################################

# Run the IDL setup file
. /Applications/itt/idl/bin/idl_setup.bash

# Run the Scisoft setup file
# Warning- Scisoft breaks some things, especially IMACS tools
#. /Applications/scisoft/all/bin/Setup.bash

# Dan Kelson's Python distribution
# Disabled because it conflicts with other Python distributions
#. /Users/gully/Function/KelPy/PythonSetup.bash

# The CarPy setup file is good! I am just disabling it to work with xshooter stuff right now
# Re-enable this to work with IMACS data.
#. /Users/gully/Function/CarPy/Setup.bash

# Setup cosmos2-16 for IMACS data reduction
. /Users/gully/Function/Cosmos2-16/cosmos2-setup
#. /Users/gully/Function/Cosmos2-20/cosmos2-setup

# Ruby version manager
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Ureka setup files (http://ssb.stsci.edu/ureka/)
#ur_setup() {
#    eval `/Users/gully/.ureka/ur_setup -sh $*`
#}
#ur_forget() {
#    eval `/Users/gully/.ureka/ur_forget -sh $*`
#}

###############################################################################¬
# GitHub repositories                                                         #
###############################################################################¬

#These are now in .path since they are machine-specific


###############################################################################
# Gully's aliases                                                             #
###############################################################################

# List the 10 most recently changed files
alias lsh="ls -t | head"

# List the disk usage of files, sorted by their size
alias duf='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'

# Execute the IRS spectral extraction tool
alias smart=/Users/gully/IDLWorkspace/smart1/smart/smart

# Launch a Chrome browser from command line
alias ogc='open -a Google\ Chrome'

# Alias for ds9
alias ds9="/Applications/SAOImage_DS9.app/Contents/MacOS/ds9"

###############################################################################
# $PATH                                                                       #
###############################################################################

# Path to some extras
export PATH=$PATH:/usr/X11R6/bin

# Path to the Maskgen software for IMACS on Magellan
#export PATH=/Users/gully/Function/isi5:$PATH

# Path to DS9 so you can call DS9 from the command line
#export PATH="/Applications/scisoft/i386/Applications/SAOImage_DS9.app/Contents/MacOS:"$PATH

# Tools for handling VLT X-shooter data- Gasgano and the ESO data pipelines:
# **Turned off until needed**
#export PATH="$HOME/Function/ESO/bin:"$PATH
#export PATH="$HOME/gasgano/bin:"$PATH
#export PATH="/Users/gully/Function/xsh-kit-1.1.0/xsh-1.1.0/xsh/tests:"$PATH
#export TDIR=/Users/gully/Function/xsh-kit-1.1.0/xsh-1.1.0/xsh/tests
#export JAVA_HOME=$(/usr/libexec/java_home)
#export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
#export PATH=${JAVA_HOME}/bin:$PATH
#export CPLDIR=/Users/gully/Function/ESO/lib/esopipes-plugins/xsh-1.1.0

# Path for manpages

###############################################################################
# Dubious dynamic library definitions                                         #
###############################################################################

#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/$PYTHONBASE/lib
#export DYLD_LIBRARY_PATH=/Users/gully/Function/ESO/lib #:/opt/local/lib:/usr/X11R6/lib
#export DYLD_LIBRARY_PATH="/Users/gully/Function/ESO/lib/esopipes-plugins/xsh-1.1.0:"$DYLD_LIBRARY_PATH
#export LD_LIBRARY_PATH="/Users/gully/Function/xsh-kit-1.1.0/cpl-5.2.0/cpljava/.libs/:"$LD_LIBRARY_PATH
#export LD_LIBRARY_PATH="/Users/gully/Function/xsh-kit-1.1.0/cpl-5.2.0/cpljava:"$LD_LIBRARY_PATH
#export LD_LIBRARY_PATH=/Users/gully/Function/ESO/lib #:/X11/lib/:/X11R6/lib/:/usr/lib
#$LD_LIBRARY_PATH
#export LD_LIBRARY_PATH="/Users/gully/Function/ESO/lib/esopipes-plugins/xsh-1.1.0:"$LD_LIBRARY_PATH
#export DYLD_LIBRARY_PATH="/Users/gully/anaconda/pkgs/mkl-rt-11.1-p0/lib/libiomp5.dylib:"$DYLD_LIBRARY_PATH


###############################################################################
# Deprecated                                                                  #
###############################################################################

# In case you need a specific PYTHONPATH
#export PYTHONPATH=$PYTHONPATH:/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages

#Set Homebrew packages as default
#export PATH=/usr/local/bin:$PATH
