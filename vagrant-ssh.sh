#!/usr/bin/env bash
printf "%$(tput cols)s\n"|tr " " "="
echo "Starting vagrant machine"
printf "%$(tput cols)s\n"|tr " " "="
vagrant up

printf "%$(tput cols)s\n"|tr " " "="
echo "Starting ssh session"
printf "%$(tput cols)s\n"|tr " " "="
vagrant ssh