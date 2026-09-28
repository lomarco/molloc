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

rebuild: all clear

.PHONY: all build clear rebuild
