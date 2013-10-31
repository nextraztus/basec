#Configure Compiler
CC=clang
CFLAGS=-std=c99 -Iinc
LDFLAGS=
EXECUTABLE=basec

#configure build options
BUILD_DIR := build
SRCS := src/basec.c

OBJS := ${SRCS:%.c=${BUILD_DIR}/%.o}

all: $(SRCS) $(EXECUTABLE)

${EXECUTABLE}: ${OBJS}
	@echo Linking $@ using $?
	@$(CC) $(LDFLAGS) $(OBJS) -o $@

${BUILD_DIR}/%.o: %.c
	@mkdir -p $(dir $@)
	@echo Compiling $< ...
	@$(CC) -c $(CFLAGS) $< -o $@

${SRCS}:
	@echo Creating $@
	@mkdir -p $(dir $@)
	@touch $@

.PHONY: clean
clean:
	rm -f ${EXECUTABLE}
	rm -f ${OBJS}

