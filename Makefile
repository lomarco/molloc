TARGET = molloc
CC = clang

SRC = $(wildcard *.c)
OBJ = $(patsubst *.c,%.o,$(SRC))

all: build

%.o: $(SRC)
	$(CC) -c $(SRC) -o $@

build: $(OBJ)
	$(CC) $< -o $(TARGET)

clear:
	rm *.o $(TARGET)

.PHONY: all build clear
