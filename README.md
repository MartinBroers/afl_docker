# afl_docker

This docker runs the American fuzzy lop, see ttps://lcamtuf.coredump.cx/afl/

# usage

## building

```sh
docker build --rm --no-cache -t fuzzer .
```

## Running
Because we may need to change the goverance of the cpu, we need to run the image with privileged access:

```sh
docker run -ti --rm --privileged -v "$(pwd)":/workdir -w /workdir fuzzer
```

When you don't give any commands, the docker will launch into an interactive shell. However, one can append the afl commands at the end and those commands will be launched right away.
