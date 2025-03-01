# hello-container
Hello World Docker Container

## Build container

```bash
$ docker build -t hello-world:latest --platform=linux/arm64 .
```

```bash
$ docker build -t hello-world:latest --platform=linux/amd64 .
```
### Find dependencies

```bash
$ ldd HelloWorld
```

```
amd64
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fffff5a9000)
        /lib64/ld-linux-x86-64.so.2 (0x00007ffffffc6000)

arm64

        linux-vdso.so.1 (0x0000ffff869f5000)
        libc.so.6 => /lib/aarch64-linux-gnu/libc.so.6 (0x0000ffff867c0000)
        /lib/ld-linux-aarch64.so.1 (0x0000ffff869b0000)
```