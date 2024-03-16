#!/bin/sh
HASHED_PASS=$(tor --hash-password abcdef| grep 16)
sed -i "s/#HashedControlPassword 16:x/HashedControlPassword $HASHED_PASS/g" /etc/tor/torrc

tor -f /etc/tor/torrc &>/dev/null &
n=0

while true
do
	echo "Round $n start."
	python3 -u fetch.py 
	python3 -u refreship.py
	echo "Round $n end."
	n=$(( n+1 ))
done