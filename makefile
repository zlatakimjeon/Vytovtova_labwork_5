CC = gcc
CFLAGS = -std=c11 -Wall -Wextra -O2 -Iinclude
AR = ar
ARFLAGS = rcs

SRC = src/recurrence.c
OBJ = $(SRC:.c=.o)

.PHONY: all clean test

all: lib/librecurrence.a test/run

src/recurrence.o: src/recurrence.c
	$(CC) $(CFLAGS) -c $< -o $@

lib/librecurrence.a: $(OBJ)
	mkdir -p lib
	$(AR) $(ARFLAGS) lib/librecurrence.a $(OBJ)

test/run: test/test.c lib/librecurrence.a
	mkdir -p test
ifeq ($(OS),Windows_NT)
	$(CC) $(CFLAGS) test/test.c -Llib -lrecurrence -lm -o test/run.exe
else
	$(CC) $(CFLAGS) test/test.c -Llib -lrecurrence -lm -o test/run
endif

test:
ifeq ($(OS),Windows_NT)
	test/run.exe
else
	./test/run
endif

# Очистка
clean:
	rm -rf lib src/*.o test/run*
