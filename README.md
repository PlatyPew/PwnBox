# PlatyPew's PwnBox
Because who needs a virtual machine?

## Installation
You can either build it yourself using `./build.sh`, or pull it from docker hub.

Build yourself
```bash
./build.sh
./run.sh <name of container>
```

Pull from docker hub (It's faster, but packages may be outdated)
```bash
docker pull platypew/pwnbox
./run.sh <container name>
```

## Usage
How to use this

### General
By executing `run.sh`, you will effectively start the container and attach to it.
Upon exiting the container, the container will be stopped. To re-attach to it, do `docker start <container name>` and `docker attach <container name>`

PwnBox will also mount a directory `pwnbox-<container name>` to `/root/shared`.

### Installing tools
PwnBox comes with [ctf-tools](https://github.com/zardus/ctf-tools) by zardus.

To install programs, just do `manage-tools install <tool>`.
You can get more information from the repo.

By default, no tools are installed, but the dependencies should be.

## Other stuffu
Good luck for your CTFs, and hack harder.
