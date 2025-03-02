# syntax=docker/dockerfile:1.2

# Compile the code and install dependencies
FROM --platform=$TARGETPLATFORM ubuntu:latest AS compiler

WORKDIR /src

RUN apt update && apt install -y gcc libc6

COPY hello_world.c .

RUN gcc -o HelloWorld hello_world.c

RUN rm -rf /tmp/*

# Build scratch image with binary and dependencies(ldd HelloWorld)
FROM --platform=$TARGETPLATFORM scratch

COPY --from=compiler /lib*/ld-linux-*.so.* /lib/
COPY --from=compiler /lib*/ld-linux-*.so.* /lib64/
COPY --from=compiler /lib/*-linux-gnu/libc.so.6 /lib/

COPY --from=compiler /etc/passwd /etc/passwd
COPY --from=compiler /tmp /tmp

COPY --from=compiler /src/HelloWorld /

ENTRYPOINT [ "/HelloWorld" ]

