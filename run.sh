#!/usr/bin/env bash

if [[ -z ${2} ]]; then
    echo -e "Missing argument box name."
    echo "Usage: ./run.sh <container name> <image name>"
    exit 0
fi

box_name=${1}

mkdir $(pwd)/pwnbox-${box_name}

docker run -it -d \
	-h ${box_name} \
	--name ${box_name} \
	--privileged \
    --mount type=bind,source="$(pwd)/pwnbox-${box_name}",target=/root/shared \
	${2}

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
