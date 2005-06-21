#[]-----------------------------------------------------------------[]
#|   Makefile -- makefile					     |
#[]-----------------------------------------------------------------[]
#
# $Copyright: 2005$
# $Revision: 1.0 $
#

OS=WIN32

ifneq ($(shell uname),Linux)
    BIN=locale.dll
    OS=WIN32
    LFLAGS= -mi386pe --disable-stdcall-fixup
else
    BIN=liblocale.so
    OS=LINUX
    LFLAGS= -melf_i386
endif
SRC=locale.asm
OBJ=$(SRC:.asm=.o) # replaces the .asm from SRC with .o
DEF=locale.def
SRCDIR=src/locale
OBJDIR=obj
BINDIR=bin
LIB=
VPATH=$(SRCDIR):$(OBJDIR):$(BINDIR)

AS=nasm
#LD=ilink32
LD=ld
#AFLAGS=-f coff -O4
#AFLAGS=-f obj -O4 -I$(SRCDIR)/
AFLAGS=-f elf -O4
#LFLAGS=-mi386pe -call_shared --disable-stdcall-fixup	--export-all-symbols	#Link flags with gcc
LFLAGS+= -call_shared   -E   #Link flags with gcc
#LFLAGS = -c -Tpd -aa -x -Gn -Gi -v -b:0x340000 #Link flags with ilink32
#LLFLAGS=-m -M -s    #Link loggings flags with ilink32
#LFLAGS = -Tpd -aa -x -Gn -Gi -v -b:0x340000  #Link flags with ilink32

%.o: %.asm
	$(AS) $(AFLAGS) -l $(<:.asm=.lst) -o $(OBJDIR)/$@ $< -E $(OBJDIR)/$(@:.o=.err)	-d$(OS)

.PHONY : all	 # .PHONY ignores files named all
all: $(BIN)	 # all is dependent on $(BIN) to be complete

.PHONY : all	 # .PHONY ignores files named all
all: $(BIN)	 # all is dependent on $(BIN) to be complete

$(BIN): $(OBJ) $(DEF) $(RES) # $(EXE) is dependent on all of the files in $(OBJ) to exist
#	$(LD)  $(LFLAGS) $(LLFLAGS) -j$(OBJDIR) $(OBJ) , $(BINDIR)\\$@,, $(LIB), $(SRCDIR)\\$(DEF), $(RES)
	$(LD) $(LFLAGS) $(LLFLAGS)  $(OBJDIR)/$(OBJ) -o $(BINDIR)/$@

.PHONY : clean	 # .PHONY ignores files named clean
clean:
	-$(RM) -f $(OBJ) *.lst *.err   # '-' causes errors not to exit the process

