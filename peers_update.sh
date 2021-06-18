#!/bin/bash
pathtoconf="$HOME/.osmosisd/config/config.toml"
############# REMEMBER TO SET YOUR IP UNDER "yourip" variable since you don't want to add your own ip  to the list ######################
yourip=
if [ -z "$yourip" ]; then
  echo "Please set your IP inside yourip variable."
  exit 1
fi
count=$(curl -sS https://raw.githubusercontent.com/qf3l3k/networks/main/peers.md | grep -v $yourip | grep @ | wc -l)
getpeers=$(curl -sS https://raw.githubusercontent.com/qf3l3k/networks/main/peers.md | grep -v $yourip | grep @ | tr '\n' ',' | sed 's/.$//')
echo "### ADDING PEERS TO YOUR config.toml ###"
sed -i.bak -E 's#^(persistent_peers[[:space:]]+=[[:space:]]+).*$#\1'\"$getpeers\"'#' $pathtoconf
echo "### ADDED $count PEERS TO YOUR config.toml ###"
