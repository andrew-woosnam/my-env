#!/usr/bin/env bash

my_bashrc=~/.bashrc
my_aliases=~/.bash_aliases

cat ./my-bashrc > $my_bashrc
cat ./my-aliases > $my_aliases

source $my_bashrc
source $my_aliases