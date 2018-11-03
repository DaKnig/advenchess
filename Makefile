OBJDIR := obj
BINDIR := bin

name := main

SRCS := $(name).z80
OBJS := $(OBJDIR)/$(name).o

EMU := wine ~/prog/bgb/bgb.exe

ROM := $(BINDIR)/$(name).gb

LINK_FLAGS := -d -t 

all:	$(ROM)

clean:
	rm $(OBJDIR)/* $(BINDIR)/* -f -I

$(OBJDIR)/%.o: %.z80
	rgbasm -o $@ $<

$(ROM):	$(OBJS)
	rgblink $(LINK_FLAGS) -o $@ -n $(ROM:.gb=.sym) $<
	rgbfix	-v -m 0 -r 0 -p 0xFF $@

run:	$(ROM)
	$(EMU) $< &
