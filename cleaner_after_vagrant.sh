#!/bin/zsh

vagrant halt -f;
vagrant destroy -f;
vagrant global-status --prune;
sudo rm -rf .vagrant/

search_string6="6.*\.com"
search_string7="7.*\.com"
search_string10="10.*\.com"
search_string20="20.*\.com"
sed -E -e "/$search_string6/d" -e "/$search_string7/d" -e "/$search_string10/d" -e "/$search_string20/d" ~/.ssh/known_hosts > ~/.ssh/known_hosts.buffer
mv ~/.ssh/known_hosts.buffer ~/.ssh/known_hosts
