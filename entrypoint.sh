#!/bin/sh
HASHED_PASS=$(tor --hash-password abcdef| grep 16)
sed -i "s/#HashedControlPassword 16:x/HashedControlPassword $HASHED_PASS/g" /etc/tor/torrc

tor -f /etc/tor/torrc &>/dev/null &
n=0

while true
do
	python3 fetch.py
	python3 refreship.py
	n=$(( n+1 ))
	echo $n
done