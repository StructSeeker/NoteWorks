


== Sundries


== Named Argument 
```bash
for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)

   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"

   export "$KEY"="$VALUE"
done

# from this line, you could use your variables as you need

cd $FOLDER
mkdir $REPOSITORY_NAME
```

=== Multiline Comment
```bash
: <<'Comment'

Comment
```


`:` expand to `true` which ignore its argument




=== ScriptDir 
#link("https://stackoverflow.com/questions/24112727")
Linux / GNU readlink solution:

If your script needs to run on Linux only or you know that GNU readlink is in the `$PATH`, use `readlink -f`, which conveniently resolves a symlink to its ultimate target:

```Bash
scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
```

Note that GNU readlink has 3 related options for resolving a symlink to its ultimate target's full path: -f (--canonicalize), -e (--canonicalize-existing), and -m (--canonicalize-missing) - see man readlink.
Since the target by definition exists in this scenario, any of the 3 options can be used; I've chosen -f here, because it is the most well-known one.


=== #link("https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#The-Set-Builtin")[Set-option]

At the beginning of the script, use set -xeuv for safety
-x xtrace print expansion of loop and case 
-e exit on error
-u unused variable
-v view each line read by bash (original line)
-o pipefail  // o for option
-n no execution, check syntax only

== Check Run as Sudo
https://stackoverflow.com/a/18216122/22628585

```bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root" 
  exit
fi
```


=== `.bashrc, .profile & .bash_profile`
https://www.baeldung.com/linux/bashrc-vs-bash-profile-vs-profile

=== bash source order

interactive login: bash_profile -> bash_login -> profile  only the first
interactive nonlogin: bash_rc
best practice: profile <- envvar
               bash_rc <- alias & function
               bash_profile <- source the above

#quote[/bin/bash
       The bash executable
/etc/profile
       The systemwide initialization file, executed for login shells
~/.bash_profile
       The personal initialization file, executed for login shells
~/.bashrc
       The individual per-interactive-shell startup file
~/.bash_logout
       The individual login shell cleanup file, executed when a login shell exits
~/.inputrc
       Individual readline initialization file]

https://askubuntu.com/a/463479

This is kind of complex. First of all, the details depend on what kind of shell you are running. To plagiarize myself:

    When you open a terminal emulator (gnome-terminal for example), you are executing what is known as an interactive, non-login shell.

    When you log into your machine from the command line, or run a command such as su - username, you are running an interactive login shell.

    When you log in graphically, you are running something completely different. The details will depend on your system and graphical environment but in general, it is the graphical shell that deals with your login. While many graphical shells (including the Ubuntu default) will read /etc/profile and ~/.profile not all of them do.

    Finally, when you run a shell script, it is run in a non-interactive, non-login shell.

The files that bash will read when launched depend on the type of shell it is running as. The following is an excerpt of the INVOCATION section of man bash (emphasis mine):

    When bash is invoked as an interactive login shell, or as a non-interactive shell with the --login option, it first reads and executes commands from the file /etc/profile, if that file exists. After reading that file, it looks for ~/.bash_profile, ~/.bash_login, and ~/.profile, in that order, and reads and executes commands from the first one that exists and is readable. The --noprofile option may be used when the shell is started to inhibit this behavior.

    When an interactive shell that is not a login shell is started, bash reads and executes commands from /etc/bash.bashrc and ~/.bashrc, if these files exist. This may be inhibited by using the --norc option. The --rcfile file option will force bash to read and execute commands from file instead of /etc/bash.bashrc and ~/.bashrc.

Those are the initialization files. You also have /etc/environment where you can set global environmental variables but that's read rather than sourced (commands inside it are not executed but variable definitions are set).

Now, the greeting you see is something else again. That is set in /etc/motd and is displayed through pam_motd. As explained in man motd:

    The contents of /etc/motd are displayed by pam_motd(8) after a successful login but just before it executes the login shell.

    The abbreviation "motd" stands for "message of the day", and this file has been traditionally used for exactly that (it requires much less disk space than mail to all users).

    On Debian GNU/Linux, the content of /run/motd.dynamic is also displayed. This file is generated by /etc/init.d/motd at boot.

To remove the message just empty the /etc/motd file and make sure that nothing is being generated by /etc/init.d/motd if present.

Anyway, based on the output you show, you seem to be logging in via ssh which means you're running an interactive login shell, see above for what that means. So, in summary, the things you care about that are sourced when you log in are (and in this order):

    The SSH daemon, via the pam_motd module of the PAM library, displays the contents of /etc/motd. Via the pam_env module, it sets the environment variables from /etc/environment and ~/.pam_environment.
    A login shell is started, and the following files are read in order:
        /etc/profile
        /etc/bash.bashrc (the default Ubuntu /etc/profile sources /etc/bash.bashrc).
        ~/.bash_profile. The other files that could have been read here (~/.profile and ~/.bash_login) are ignored because ~/.bash_profile exists.




=== Heredoc
https://stackoverflow.com/a/25903579/22628585
To append an existing file (or write to a new file) that you own, substituting variable references inside the heredoc:

```bash
cat << FOE >> /path/to/your/file
This line will write to the file.
${THIS} will also write to the file, with the variable contents substituted.
FOE

To overwrite an existing file (or write to a new file) that you own, with the literal contents of the heredoc:

cat << 'END_OF_FILE' > /path/to/your/file
This line will write to the file.
${THIS} will also write to the file, without the variable contents substituted.
END_OF_FILE
```

=== Check Command Existence

// .bash_profile > .bash_login > .profile stop once found

#link("https://stackoverflow.com/a/677212/22628585")

Answer

POSIX compatible:

command -v the_command

Example use:

if ! command -v the_command &> /dev/null
then
    echo "the_command" could not be found"
    exit 1
fi

For Bash specific environments:

hash the_command  For regular commands. Or...
type the_command  To check built-ins and keywords

=== Perserve environment variable sudo

--preserve-env=HOME


=== Sudo for userpath
https://superuser.com/questions/927512/how-to-set-path-for-sudo-commands

https://unix.stackexchange.com/a/83194

You can always do:
```bash 
# env run command with the given environment variable
# use env can bypass the security policy of sudo
# allowing sudo use user's path to search executable
sudo env "PATH=$PATH" "HOME=$HOME" godi_console

sudo "PATH=$PATH" godi_console
```

=== Linux Windows shell command & env variable correspondence
https://softhints.com/windows-cmd-vs-linux-shell-commands/
https://softhints.com/windows-and-linux-variable-equivalents/

=== Nullish Coalescing


The POSIX shell (so includes bash) equivalent would be:
```bash
${FOO:-${BAR:-default}}
# See also the:
${FOO-${BAR-default}}
```
variant which checks whether the variable is set or not instead of whether it resolves to the empty string or not (which makes a difference in the cases where a variable is set but empty).

