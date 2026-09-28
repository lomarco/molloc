TARGET = molloc
LIBTARGET = libmolloc.a
CC = clang
AR = ar

SRC = $(wildcard *.c)
OBJ = $(patsubst %.c,%.o,$(SRC))

TESTDIR = tests
TEST_MAIN = $(TESTDIR)/test.c
TEST_TARGET = test

all: build

%.o: %.c
	$(CC) -c $< -o $@

build: $(OBJ)
	$(AR) rcs $(LIBTARGET) $^

clean:
	rm -f $(OBJ) $(LIBTARGET)

clean-tests:
	rm -f $(TEST_TARGET)

rebuild: clean all

tests: all
	$(CC) $(TEST_MAIN) -o $(TEST_TARGET) -L. -l$(TARGET) -I.

.PHONY: all build clean rebuild tests clean-tests
