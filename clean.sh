#!/usr/bin/env bash
alias docker="docker.exe"
if [ -z ${1} ]; then
    echo -e "Missing argument box name."
    echo "Usage: ${0} <container name>"
    exit 1
fi

box_name=${1}

echo "Attempting to remove container"
docker rm ${box_name} -f

echo "
Thank you for using

P)ppppp                     B)bbbb
P)    pp                    B)   bb
P)ppppp  w)      WW n)NNNN  B)bbbb    o)OOO  x)   XX
P)       w)  WW  WW n)   NN B)   bb  o)   OO   x)X
P)       w)  WW  WW n)   NN B)    bb o)   OO   x)X
P)        w)WW WWW  n)   NN B)bbbbb   o)OOO  x)   XX

                                    By: Platy Pew
"
