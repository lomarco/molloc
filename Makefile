TARGET = molloc
LIBTARGET = libmolloc.a
CC = clang
AR = ar

SRC = $(wildcard *.c)
OBJ = $(patsubst %.c,%.o,$(SRC))

all: build

%.o: %.c
	$(CC) -c $< -o $@

build: $(OBJ)
	$(AR) rcs $(LIBTARGET) $^

clean:
	rm -f $(OBJ) $(LIBTARGET)

rebuild: clean all

.PHONY: all build clean rebuild
