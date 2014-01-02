CC = gcc  # clang++, g++ or just gcc if not compiling Snappy (C++ code)
CFLAGS = -O3 -g -msse2 -Wall
LDFLAGS = -lpthread  # for UNIX or for Windows with pthread installed
#LDFLAGS = -static  # for mingw
SOURCES = $(wildcard ../blosc/*.c)
EXECUTABLE = bench

# Support for external LZ4 and LZ4HC
#LDFLAGS += -DHAVE_LZ4 -DHAVE_LZ4HC -llz4

# Support for external Snappy
LDFLAGS += -DHAVE_SNAPPY -lsnappy

# Support for external Zlib
LDFLAGS += -DHAVE_ZLIB -lz

SOURCES += bench.c

all: $(SOURCES) $(EXECUTABLE)

$(EXECUTABLE): $(SOURCES)
	$(CC) $(CFLAGS) $(SOURCES) -o $@ $(LDFLAGS)

clean:
	rm -rf $(EXECUTABLE)
