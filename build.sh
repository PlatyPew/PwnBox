#!/usr/bin/env bash
source <(docker-machine.exe env dev --shell bash | sed 's?\\?/?g;s?C:/?/mnt/c/?g')
docker build -t platypew/pwnbox:wsl .
