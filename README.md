# basec
Basic directory structure for working with smallish "make only" C projects that compile by default with clang.

Also demonstrates its ability to compile 64bit ASM files (using NASM).

This is licensed CC0 -- apparently just saying "public domain" isn't sufficient. For extra clarity, this repo is intended
to be a template for _your C project_ and requires no attribution. There are more "standard" layouts when using other build
tools such as CMake and Automake. This layout has worked well for my needs, maybe it will for yours as well.

## Directory Layout
| Path | Purpose |
|------|---------|
| `/docs` | used for containing the [mkdocs](http://www.mkdocs.org) documentation |
| `/ref` | reference files, such as a blank.h and blank.c |
| `/inc` | project-specific include files, added to include path in Makefile |
| `/src` | C source-code for the project |
| `/docker` | support files for using a docker workflow for building your application |

## Building Application

### Without docker
1. clone the repo and delete `.git`, `LICENSE`, and probably `README.md`. Replace with your own.
1. find/replace `basec` everywhere to work for your application
1. adjust `Makefile` to contain any libraries and such that you need
1. `make`

### With docker
1. update `Dockerfile` to apt-get any libraries you need (use the block near the bottom of the file to keep rebuild
times lower)
1. use `./make_with_docker.sh` to pass any arguments through to make

The docker-build method will mount the source directory with the code and build it within a temporary container. The
output binaries should show up in build & have the appropriate permissions for the user that ran docker to move them around.

## Build Documentation

`make docs` - the docs will end up in `./docs/site`

To preview the documentation, from `./docs`, use `render.sh serve`. Access them via http://localhost:8000

## Tips
We've moved on from a lot of old practices in C, read [How to C in 2016](https://matt.sh/howto-c)

There's apparently a [critique of this article](https://github.com/Keith-S-Thompson/how-to-c-response).
