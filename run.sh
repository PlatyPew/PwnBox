#!/usr/bin/env bash
alias docker="docker.exe"
if [ -z ${1} ]; then
    echo -e "Missing argument box name."
    echo "Usage: ${0} <container name>"
    exit 1
fi

box_name=${1}

echo "Attempting to run container"
docker run -it -d \
    -h ${box_name} \
    --name ${box_name} \
    --privileged \
    platypew/pwnbox

if [ $? -ne 0 ]; then
    echo "Attempting to start container"
    docker start ${box_name}
fi

echo "
P)ppppp                     B)bbbb
P)    pp                    B)   bb
P)ppppp  w)      WW n)NNNN  B)bbbb    o)OOO  x)   XX
P)       w)  WW  WW n)   NN B)   bb  o)   OO   x)X
P)       w)  WW  WW n)   NN B)    bb o)   OO   x)X
P)        w)WW WWW  n)   NN B)bbbbb   o)OOO  x)   XX

                                    By: Platy Pew
"

# Get a shell
docker attach ${box_name}
