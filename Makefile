# compiler configuration
CC         ?= clang
NASM       ?= nasm
LDFLAGS    ?=
CFLAGS     ?= -std=c11 -Iinc
NASMFLAGS  ?= -f elf64 -g -F stabs
BUILDDIR   ?= build
SRCDIR     ?= src
EXECUTABLE ?= $(BUILDDIR)/basec

# release mode settings
CFLAGS_RELEASE := -O2 \
    -march=native     \
    -mtune=native     \
    -ftree-vectorize

# debug mode settings
CFLAGS_DEBUG   := -g3 \
    -O0               \
    -DDEBUG

# define our objects based on the source files we've got
CSRCS := $(wildcard ${SRCDIR}/*.c)
ASRCS := $(wildcard ${SRCDIR}/*.asm)
COBJS := ${CSRCS:%.c=${BUILDDIR}/%.o}
AOBJS := ${ASRCS:%.asm=${BUILDDIR}/%.o}

# we default to debug builds
all: debug

# debug build
.PHONY: debug
debug: CFLAGS += $(CFLAGS_DEBUG)
debug: $(EXECUTABLE)

# release build
.PHONY: release
release: CFLAGS += $(CFLAGS_RELEASE)
release: $(EXECUTABLE)

# our executable relies on all the object files
${EXECUTABLE}: ${COBJS} ${AOBJS}
	@echo Linking $@ using $?
	@$(CC) $(LDFLAGS) $(COBJS) $(AOBJS) -o $@

${BUILDDIR}/%.o: %.c
	@mkdir -p $(dir $@)
	@echo Compiling $< ...
	$(CC) -c $(CFLAGS) $< -o $@

${BUILDDIR}/%.o: %.asm
	@mkdir -p $(dir $@)
	@echo Assembling $< ...
	@$(NASM) $(NASMFLAGS) $< -o $@

${CSRCS}:
	@echo Creating $@
	@mkdir -p $(dir $@)
	@touch $@

${ASRCS}:
	@echo Creating $@
	@mkdir -p $(dir $@)
	@touch $@

.PHONY: clean
clean:
	rm -f ${EXECUTABLE}
	rm -f ${COBJS} ${AOBJS}

