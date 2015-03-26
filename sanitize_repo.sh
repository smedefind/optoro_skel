#!/usr/bin/env bash

# Replace all instances of optoro_skel with the directory name
# This assumes the current directory is named something like optoro_*
# as per cookbook convention.
DIRNAME=${PWD##*/}
for i in $(grep -rl optoro_skel * | grep -v .git | grep -v ${0##*/} ); do
  echo "Replacing optoro_skel in ${i}"
  #sed -i -e "s/optoro_skel/$DIRNAME/g" "$i"
  ruby -pi -e "gsub('optoro_skel', '$DIRNAME')" $i               
done

# Remove this file from the new repo
git rm -f $0

# remove the optoro_skel git commit history and fix the git remote
rm -rf ./.git
git init
git remote add origin git@github.com:optoro-devops/$DIRNAME

