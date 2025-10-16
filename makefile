CC = gcc
CFLAGS = -std=c11 -Wall -Wextra -O2 -Iinclude
AR = ar
ARFLAGS = rcs

SRC = src/recurrence.c
OBJ = $(SRC:.c=.o)

.PHONY: all clean test build_lib build_test lib testdir

all: lib/librecurrence.a test/run

lib:
	if not exist lib mkdir lib

testdir:
	if not exist test mkdir test

build_lib: lib $(OBJ)
	$(AR) $(ARFLAGS) lib/librecurrence.a $(OBJ)

src/recurrence.o: src/recurrence.c
	$(CC) $(CFLAGS) -c $< -o $@

build_test: testdir build_lib
	$(CC) $(CFLAGS) test/test.c -Llib -lrecurrence -lm -o test/run

test: clean build_test
	./test/run

clean:
	if exist lib rmdir /s /q lib
	if exist src\recurrence.o del src\recurrence.o
	if exist test\run del test\run
