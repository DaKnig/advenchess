OBJDIR := obj
BINDIR := bin

name := main

SRCS := rng.z80 $(name).z80 init.z80
OBJS := $(OBJDIR)/rng.o $(OBJDIR)/$(name).o $(OBJDIR)/init.o

EMU := wine ~/prog/bgb/bgb.exe

ROM := $(BINDIR)/$(name).gb

LINK_FLAGS := -d -t -p 0xFF
FIX_FLAGS := -v -m 0 -r 0 -p 0xFF
ASM_FLAGS := -E -p 0xFF

all:	$(ROM)

clean:
	rm $(OBJDIR)/* $(BINDIR)/* -rf
	rm assets/Tiles.png -f

$(OBJDIR)/%.o: %.z80
	rgbasm $(ASM_FLAGS) -o $@ $<

$(ROM):	$(OBJS)
	rgblink $(LINK_FLAGS) -o $@ -n $(ROM:.gb=.sym) $(OBJS)
	rgbfix	$(FIX_FLAGS) $@

run:	$(ROM)
	$(EMU) $< &

artwork: assets/Tiles.png

assets/Tiles.png: assets/Tiles.bin
	dazzlie decode -f gb_2bpp --layout "H8 V3" -i assets/Tiles.bin -o assets/Tiles.png
