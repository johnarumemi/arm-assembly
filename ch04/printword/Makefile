out_dir = ./out
bin_dir = ./out/bin

# dependencies
project = main

executable = $(bin_dir)/$(project)

ifdef debug
	DEBUGFLAGS = -g
else
	DEBUGFLAGS =
endif


# Assemble source file(s)
#
# $< : source file
# $@ : output file
%.o : %.s
	if [ ! -d "$(out_dir)" ]; then mkdir $(out_dir); fi
	as $(DEBUGFLAGS) $< -o $(out_dir)/$@

# Link and Run executable
$(project): $(project).o
	if [ ! -d $(bin_dir) ]; then mkdir $(bin_dir); fi
	ld -o $(executable) $(out_dir)/$(project).o

	# Run
	$(executable)

