TARGET = molloc.a
CC = clang
AR = ar

SRC = $(wildcard *.c)
OBJ = $(patsubst %.c,%.o,$(SRC))

all: build

%.o: %.c
	$(CC) -c $< -o $@

build: $(OBJ)
	$(AR) rcs $(TARGET) $^

clean:
	rm -f $(OBJ) $(TARGET)

rebuild: clean all

.PHONY: all build clean rebuild
