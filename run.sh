#!/usr/bin/env bash
if [ -z ${1} ]; then
    echo -e "Missing argument box name."
    echo "Usage: ${0} <container name>"
    exit 1
fi

box_name=${1}

echo "Attempting to run container"
docker.exe run -it -d \
    -h ${box_name} \
    --name ${box_name} \
    --privileged \
    platypew/pwnbox:wsl

if [ $? -ne 0 ]; then
    echo "Attempting to start container"
    docker.exe start ${box_name}
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
docker.exe attach ${box_name}
