
LIBOBJS = upper.o

ifdef debug
	DEBUGFLAGS = -g
else
	DEBUGFLAGS =
endif

all: uppertst2

# Run assembly to generate object files
# outputs.o : inputs.s
%.o: %.s
	as $(DEBUGFLAGS) $< -o $@

# Created shared library from following library objects
libupper.a: $(LIBOBJS)
	ar -cvq libupper.a $(LIBOBJS)

# Generate C code using our shared library
# Use static linking
uppertst2: uppertst.c libupper.a
	gcc -o uppertst uppertst.c libupper.a



