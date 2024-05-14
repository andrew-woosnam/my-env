#!/usr/bin/env bash

my_bashrc=~/.bashrc
my_aliases=~/.bash_aliases

cat ./static/my-bashrc > $my_bashrc
cat ./static/my-aliases > $my_aliases

source $my_bashrc
source $my_aliases