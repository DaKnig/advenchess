OBJDIR := obj
BINDIR := bin

name := main

SRCS := $(name).z80 init.z80
OBJS := $(OBJDIR)/$(name).o $(OBJDIR)/init.o

EMU := wine ~/prog/bgb/bgb.exe

ROM := $(BINDIR)/$(name).gb

LINK_FLAGS := -d -t -p 0xFF
FIX_FLAGS := -v -m 0 -r 0 -p 0xFF
ASM_FLAGS := -E -p 0xFF

all:	$(ROM)

clean:
	rm $(OBJDIR)/* $(BINDIR)/* -f -I

$(OBJDIR)/%.o: %.z80
	rgbasm $(ASM_FLAGS) -o $@ $<

$(ROM):	$(OBJS)
	rgblink $(LINK_FLAGS) -o $@ -n $(ROM:.gb=.sym) $(OBJS)
	rgbfix	$(FIX_FLAGS) $@

run:	$(ROM)
	$(EMU) $< &
