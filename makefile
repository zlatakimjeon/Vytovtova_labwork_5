CC = gcc
CFLAGS = -std=c11 -Wall -Wextra -O2 -Iinclude
AR = ar
ARFLAGS = rcs

SRC = src/recurrence.c
OBJ = $(SRC:.c=.o)

.PHONY: all clean test

all: lib/librecurrence.a test/run

lib/librecurrence.a: $(OBJ)
ifeq ($(OS),Windows_NT)
	if not exist lib mkdir lib
else
	mkdir -p lib
endif
	$(AR) $(ARFLAGS) lib/librecurrence.a $(OBJ)

src/recurrence.o: src/recurrence.c
	$(CC) $(CFLAGS) -c $< -o $@

test/run: test/test.c lib/librecurrence.a
ifeq ($(OS),Windows_NT)
	if not exist test mkdir test
else
	mkdir -p test
endif
	$(CC) $(CFLAGS) test/test.c -Llib -lrecurrence -lm -o test/run

test:
ifeq ($(OS),Windows_NT)
	test\run.exe
else
	./test/run
endif

clean:
ifeq ($(OS),Windows_NT)
	if exist lib rmdir /s /q lib
	if exist src\recurrence.o del src\recurrence.o
	if exist test\run.exe del test\run.exe
else
	rm -rf lib src/*.o test/run
endif
