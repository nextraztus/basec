# basec
Basic directory structure for working with smallish "make only" C projects that compile by default with clang.

Also demonstrates its ability to compile 64bit ASM files (using NASM).


## Directory Layout
| Path | Purpose |
|------|---------|
| `/docs` | used for containing the [mkdocs](http://www.mkdocs.org) documentation |
| `/ref` | reference files, such as a blank.h and blank.c |
| `/inc` | project-specific include files, added to include path in Makefile |
| `/src` | C source-code for the project |

## Build Documentation

`make docs` - the docs will end up in `./docs/site`

To preview the documentation, from `./docs`, use `render.sh serve`. Access them via http://localhost:8000

## Tips
We've moved on from a lot of old practices in C, read [How to C in 2016](https://matt.sh/howto-c)
