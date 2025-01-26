LIBOBJS = upper.o

ifdef debug
DEBUGFLGS = -g
else
DEBUGFLGS =
endif
LSTFLGS =

all: addexamp2 uppertst uppertst2 uppertst3 uppertst4

%.o : %.s
	as $(DEBUGFLGS) $(LSTFLGS) $< -o $@

addexamp2: addexample2.s debug.s
	gcc -o addexamp2 addexample2.s

# Direct linking
uppertst: uppertst.c upper.s
	gcc -o uppertst uppertst.c upper.s

# Create static library from following library objects
libupper.a: $(LIBOBJS)
	ar -cvq libupper.a $(LIBOBJS)

# Using the static library
uppertst2: uppertst.c libupper.a
	gcc -o uppertst2 uppertst.c libupper.a

# Created shared library from following library objects
libup.so.1.0: $(LIBOBJS)
	gcc -shared -Wl,-soname,libup.so.1 -o $@ $(LIBOBJS)
	# need sudo to move to /usr
	sudo mv $@ /usr/local/lib
	ln -sf /usr/local/lib/$@ /usr/local/lib/libup.so.1
	ln -sf /usr/local/lib/$@ /usr/local/lib/libup.so
	ldconfig

# Using the shared library
uppertst3: libup.so.1.0
	gcc -o uppertst3 uppertst.c -lup

# Direct linking
uppertst4: uppertst4.c
	gcc -o uppertst4 uppertst4.c 
