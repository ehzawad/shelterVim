#!/usr/bin/env bash

# Little bit check
name=`uname`

if [ "$name" == "Linux" ]
then
  echo 'Your OS is '$name

  set -e

  echo This bash script will download and install the vim from http://github.com/ehzawad/shelterVim.


  echo -n "Are you sure to install this(y/n)"
  read answer
  if echo "$answer" | grep -iq "^y" ; then
    if [ -d ~/.vim ]; then
      cd ~/.vim
      git pull origin master
      vim -c PlugInstall! +PlugUpgrade +q +q
      echo "updated!"
      exit
    fi
  else
    exit
  fi

  echo
  echo Downloading and installing...
  echo please wait....

  git clone --quiet https://github.com/ehzawad/shelterVim ~/.vim

  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  echo symbolic linked .vimrc done

  if [ -f ~/.vim/.vimrc ]; then
    ln -f -s ~/.vim/.vimrc ~/.vimrc
  else
    echo ".vimrc file does not exist"
    exit
  fi

  echo "this will install vim plugin"
  vim +PlugInstall +PlugUpgrade +q +q
  echo
  echo Installed vim plugins "(could take a while)"
  echo Be patient there is so much dependices May be or NOT
  echo Please wait

  echo Make sure you are using python3
  echo

  echo -e "\[\e[1;32m\]Everything successfully installed.\[\e[0m\]"
  echo " THANK YOU :) :) "

fi
