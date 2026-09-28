TARGET = molloc.a
CC = clang
AR = ar

SRC = $(wildcard *.c)
OBJ = $(patsubst *.c,%.o,$(SRC))

all: build

%.o: $(SRC)
	$(CC) -c $(SRC) -o $@

build: $(OBJ)
	$(AR) rcs $(TARGET) $^

clear:
	rm *.o $(TARGET)

rebuild: all clear

.PHONY: all build clear rebuild
