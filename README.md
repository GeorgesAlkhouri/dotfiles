# Dotfiles

## Usage 

Install [stow](https://www.gnu.org/software/stow/) then:

```shell
git clone https://github.com/GeorgesAlkhouri/dotfiles.git
cd dotfiles

./install.sh
./setup.sh [-c mac|linux-work ...]
```

## Additional Spacemacs Setup (for Terminal)
### Truecolor and Italic support

Create a `xterm-24bit.terminfo` file with the following contents:
```terminfo
xterm-24bit|xterm with 24-bit direct color mode,
   use=xterm-256color,
   sitm=\E[3m,
   ritm=\E[23m,
   setb24=\E[48;2;%p1%{65536}%/%d;%p1%{256}%/%{255}%&%d;%p1%{255}%&%dm,
   setf24=\E[38;2;%p1%{65536}%/%d;%p1%{256}%/%{255}%&%d;%p1%{255}%&%dm,

```
*Make sure you have a newline at end of file otherwise you will get errors!*

Execute the following command:
```bash
/usr/bin/tic -x -o ~/.terminfo xterm-24bit.terminfo
```

Now you can set your `$TERM` variable to `xterm-24bit`:
```bash
export TERM=xterm-24bit
```

SSH might break if your remote machine does not have the same setup, you can work around this with the following alias.
```bash
alias ssh="TERM=xterm-256color ssh"
```

If you use tmux, you need to make sure you installed a version with truecolor support, then add the following lines to your `.tmux.conf`:
```tmux
set -g default-terminal "xterm-24bit"
set -g terminal-overrides ',xterm-24bit:Tc'
```

Also, make sure you have utf8 language variables if you want all characters to display correctly. For example:
```bash
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
```
