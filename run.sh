#!/usr/bin/env bash

if [ -z ${1} ]; then
    echo -e "Missing argument box name."
    echo "Usage: ./run.sh <container name>"
    exit 1
fi

box_name=${1}

echo "Making directory"
mkdir $(pwd)/pwnbox-${box_name} 2> /dev/null

echo "Attempting to run container"
docker run -it -d \
    -h ${box_name} \
    --name ${box_name} \
    --privileged \
    --mount type=bind,source="$(pwd)/pwnbox-${box_name}",target=/root/shared \
    platypew/pwnbox

if [ $? -ne 0 ]; then
    echo "Attempting to start container"
    docker start ${1}
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
