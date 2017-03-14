## Vim configuration

Vim 8

    :help version8

Terminal solarized and smyck color theme capabilities is needed

UTF-8 is enabled in terminal

Tmux multiplexor is needed too, but optional

git source control

Mac is more preferred

For mac installation process will be different (different package manager)

Not compatible with Windows :( :( :(

Arduino support

### NOTE

    Make sure you should know some VIML(Vim Script)

!!! Caution!
## Installation may vary because World is Dynamic
  Make sure you have curl, git, tmux and bash installed

  Install Latest Stable Vim as much as possible .

  No neovim support right now

## Installation:

## Install vim Component
> first step:

Remember! latest **vim** has compiled with python3

    sudo apt-get install vim tmux git curl wget git-core
    sudo apt-get install g++
    " dependencies
    sudo apt-get install python-dev python3-dev cmake autoconf
    " make vim search faster
    sudo apt-get install silversearcher-ag


## Compile vim from source
> Download source zip file from

> for gtk3 support use -gui=gtk3

> [Vim](https://github.com/vim/vim/releases)

     # BUILD VIM from source code
     sudo apt-get build-dep vim-gnome vim
     sudo apt-get install xorg-dev
     Install lua and perl as well
     mkdir -p ~/.myVim
     unzip vim-8.x.xxxx.zip
     cd vim-8.x.xxxx/src/

     ./configure --enable-python3interp --enable-pythoninterp --enable-rubyinterp --enable-luainterp --enable-perlinterp --enable-cscope --enable-gui=gtk2 --enable-multibyte --with-features=huge --with-x --prefix=$HOME/.myVim

     make
     make install

### Set it to PATH
>
>    # set it to PATH
```bash
    export VIM_HOME=~/.myVim
    export PATH=$VIM_HOME/bin:$PATH
    unset MANPATH
    export MANPATH="$VIM_HOME/share/man:$(manpath)"
```

## Clang

    Normally I install clang++ and llvm as a local user not as a root user

> Build clang from source

> If you use python3 ...be sure to install python3-dev


## Now you can install the vimrc
### for build pre-sanity check

    export CXX=g++ CC=gcc ; unset CFLAGS CXXFLAGS LDLIBS

jus using a single command

    curl https://raw.githubusercontent.com/ehzawad/shelterVim/master/install.sh | cat > shelterVim.sh && bash shelterVim.sh && rm -f ./shelterVim.sh

You'll also probably want ctags installed. On Ubuntu, you can do:

    sudo apt-get install exuberant-ctags

## Color Schemes

The default color scheme is [Smyck](https://github.com/hukl/Smyck-Color-Scheme/). For best results, install both the vim color scheme and the terminal color scheme. To install the terminal theme, simply double-click the `itermcolors` file for iTerm or the `terminal` file for Terminal, then pick the color scheme from the terminal preferences menu. FOR XUBUNTU you can put terminal colorscheme in / root fooder

## Plugin and Plugin manager
> see vimrc file
> vimPlug Plugin manager is used
> you can also use pathogen too ! :)
> Please Install Latest version of Vim using Package manager

But make sure everything is installed properly


## Shortcuts

>> I strongly recommend to see my vimrc file

### More on vimrc file
> see comments in vimrc file

### Updating vimrc vim plugin
> :source $MYVIMRC
> :PlugUpgrade
> :PlugUpdate

## Learn Vim in terminal
>Type vimtutor in Terminal

vimtutor

>See the include cheat-sheet of this repo

enjoy :)

>  you may need super user permission ...

> you can run above command as bash script

## Screenshot
>Fancy Right !!

![Vim tmux](https://raw.githubusercontent.com/ehzawad/shelterVim/master/vim_Awesome.png)


![Vim Diff](https://raw.githubusercontent.com/ehzawad/shelterVim/master/mvcCS50.png)

![JavaFxbeanbindings](https://raw.githubusercontent.com/ehzawad/shelterVim/master/javaFXBinding.png)


## Any Query
> email : mechezawad@outlook.com

:boy: :running:
# Cool
