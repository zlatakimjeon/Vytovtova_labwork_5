CC = gcc
CFLAGS = -std=c11 -Wall -Wextra -O2 -Iinclude
AR = ar
ARFLAGS = rcs

SRC = src/recurrence.c
OBJ = $(SRC:.c=.o)

.PHONY: all clean test build_lib build_test

all: lib/librecurrence.a test/run

lib/librecurrence.a: $(OBJ)
	$(call MAKE_DIR,lib)
	$(AR) $(ARFLAGS) lib/librecurrence.a $(OBJ)

src/recurrence.o: src/recurrence.c
	$(CC) $(CFLAGS) -c $< -o $@

# Сборка тестового раннера
test/run: test/test.c lib/librecurrence.a
	$(call MAKE_DIR,test)
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

define MAKE_DIR
ifeq ($(OS),Windows_NT)
	if not exist $(1) mkdir $(1)
else
	mkdir -p $(1)
endif
endef
