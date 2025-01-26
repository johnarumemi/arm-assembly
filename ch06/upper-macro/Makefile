out_dir = ./out
bin_dir = ./out/bin

# dependencies
project = main

OBJS = $(out_dir)/main.o $(out_dir)/uppermacro.o

ifdef debug
	DEBUGFLAGS = -g
else
	DEBUGFLAGS =
endif

LSTFLGS =


all: $(project)

# Assemble source file(s)
#
# $< : source file
# $@ : output file
%.o : %.s
	if [ ! -d "$(out_dir)" ]; then mkdir $(out_dir); fi
	as $(DEBUGFLAGS) $(LSTFLGS) $< -o $(out_dir)/$@

# Link and Run executable
$(project): main.o uppermacro.o
	if [ ! -d $(bin_dir) ]; then mkdir $(bin_dir); fi
	ld -o $(bin_dir)/$(project) $(OBJS)

	$(bin_dir)/$(project)

