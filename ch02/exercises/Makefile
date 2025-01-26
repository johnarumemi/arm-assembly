out_dir = ./out
bin_dir = ./out/bin

# dependencies
project = ex1

# Link and Run executable
$(project): $(project).o
	if [ ! -d $(bin_dir) ]; then mkdir $(bin_dir); fi
	ld -o $(bin_dir)/$(project) $(out_dir)/$(project).o
	$(bin_dir)/$(project)

# Assemble source file(s)
#
# $< : source file
# $@ : output file
%.o : %.s
	if [ ! -d "$(out_dir)" ]; then mkdir $(out_dir); fi
	as $< -o $(out_dir)/$@
