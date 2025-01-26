
ifdef debug
	DEBUGFLGS = -g
else
	DEBUGFLGS =
endif

LSTFLGS =

all: divexamp mulexamp matrixmult

%.o : %.s
	as $(DEBUGFLGS) $(LSTFLGS) $< -o $@

divexamp: divexamp.s debug.s
	gcc $(DEBUGFLGS) $(LSTFLGS) -o divexamp divexamp.s

mulexamp: mulexamp.s debug.s
	gcc $(DEBUGFLGS) $(LSTFLGS) -o mulexamp mulexamp.s

matrixmult: matrixmult.s
	gcc $(DEBUGFLGS) $(LSTFLGS) -o matrixmult matrixmult.s


