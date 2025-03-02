# syntax=docker/dockerfile:1.2

# Compile the code and install dependencies
FROM --platform=$TARGETPLATFORM ubuntu:latest AS compiler

WORKDIR /src

RUN apt update && apt install -y gcc libc6

COPY hello_world.c .

RUN gcc -o HelloWorld hello_world.c

RUN rm -rf /tmp/*

# ENTRYPOINT [ "ls", "-ltrh", "/src/HelloWorld" ]

#ENTRYPOINT [ "ldd", "/src/HelloWorld" ]

# Build scratch image with binary and dependencies(ldd HelloWorld)
FROM --platform=$TARGETPLATFORM scratch

COPY --from=compiler /lib/x86_64-linux-gnu/libc.so.6 /lib/x86_64-linux-gnu/libc.so.6
COPY --from=compiler /lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2

COPY --from=compiler /etc/passwd /etc/passwd
COPY --from=compiler /tmp /tmp

COPY --from=compiler /src/HelloWorld /

ENTRYPOINT [ "/HelloWorld" ]

