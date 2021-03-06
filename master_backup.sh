#!/bin/bash
############################
# master_backup.sh
# This script is for automation. It will run all the backup scripts.
############################

######## Variables
# These enable/disable the specific backup
arch_on=false
atom_on=true
gnome_on=false
# These are the directories for the scripts
home_dir=~/git/dotfiles
arch_dir=~/git/dotfiles/arch
atom_dir=~/git/dotfiles/atom
gnome_dir=~/git/dotfiles/gnome
# This determines if you want to push your backup to git
push_to_git=true
timestamp=$(date +"%m-%d-%Y")
########

cd $home_dir

# Backup Arch Linux packages and pacman.conf
if $arch_on; then
  echo "Beginning Arch backup..."
  cd $arch_dir
  ./backup.sh
  cd $home_dir
else
  echo "Skipping Arch backup..."
fi

# Backup for Atom packages, themes, and settings
if $atom_on; then
  echo "Beginning Atom backup..."
  cd $atom_dir
  ./backup.sh
  cd $home_dir
else
  echo "Skipping Atom backup..."
fi

# Backup for Gnome extensions, settings, and gconf
if $gnome_on; then
  echo "Beginning Gnome backup..."
  cd $gnome_dir
  ./backup.sh
  cd $home_dir
else
  echo "Skipping Gnome backup..."
fi

echo "Backup finished"

if $push_to_git; then
  cd $home_dir
  echo "Pushing to Git..."
  git add .
  git commit -m "$timestamp : Automatic backup"
  git push
fi
