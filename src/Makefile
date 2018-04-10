TARGET=game.elf
ASM_OUTPUT=$(TARGET).S
MEM_FILE=$(TARGET:.elf=).mem
C_SOURCES=main.c game.c
ASM_GEN_SOURCES=${C_SOURCES:.c=.S}
ASM_SOURCES=start.S keypad.S screen.S
OBJ_FILES=$(ASM_SOURCES:.S=.o) $(ASM_GEN_SOURCES:.S=.o)
HEADER_FILES=system.h screen.h keypad.h game.h
GCC_ROOT=/opt/gcc-mips-7.1.0
LD=$(GCC_ROOT)/bin/mips-elf-ld
CC=$(GCC_ROOT)/bin/mips-elf-gcc
AS=$(GCC_ROOT)/bin/mips-elf-as
OBJDUMP=$(GCC_ROOT)/bin/mips-elf-objdump
CFLAGS=-G 0 -Os -Wall -ffreestanding -fno-stack-protector \
       -nostdinc -nostdlib -fno-delayed-branch -fno-unroll-loops
ELF_TO_MIF=elf2mif
ELF_TO_MEM=../../tools/elf2mem
BUILD_HEX=../tools/build_hex.sh
OUTPUT_DIR=./build
IMEM_FILE=$(OUTPUT_DIR)/code.mif
DMEM_FILE=$(OUTPUT_DIR)/data.mif
IMEM_WORD_COUNT=2048
DMEM_WORD_COUNT=2048
 
.PHONY: clean
.SUFFIXES:
 
all: hex_files mif_files $(ASM_OUTPUT)
 
hex_files: $(TARGET)
		mkdir -p $(OUTPUT_DIR)
		$(BUILD_HEX) $(OUTPUT_DIR) $^
		> $@
   
mif_files: $(TARGET)
		mkdir -p $(OUTPUT_DIR)
		$(ELF_TO_MIF) $^ $(IMEM_FILE) $(DMEM_FILE) $(IMEM_WORD_COUNT) $(DMEM_WORD_COUNT)
		> $@
 
$(MEM_FILE): $(TARGET)
		$(ELF_TO_MEM) -o $@ -ca 0 -da 2000 -cs 2048 -ds 1024 $<
 
$(TARGET): $(OBJ_FILES)
		$(LD) -G 0 -T link_script.ld -o $@ $^
 
start.o: start.S
		$(CC) $(CFLAGS) -c -mips1 -o $@ $<

keypad.o: keypad.S
		$(CC) $(CFLAGS) -c -mips1 -o $@ $<

screen.o: screen.S
		$(CC) $(CFLAGS) -c -mips1 -o $@ $<
 
%.s: %.c
		$(CC) -S $(CFLAGS) -c -mips1 -o $@ $<
		sed -i '/[ \t]*nop$$/d' $@
 
%.o: %.s
		$(AS) -O0 -G 0 -mips1 -o $@ $^
 
# %.o: %.c
#   $(CC) $(CFLAGS) -c -mips1 -o $@ $<
 
$(ASM_OUTPUT): $(TARGET)
		$(OBJDUMP) -D $< > $@
 
clean:
		rm -f $(TARGET)
		rm -f $(ASM_GEN_SOURCES)
		rm -f *.o
		rm -f *.mif
		rm -f *.bin
		rm -f hex_files mif_files
		rm -f $(ASM_OUTPUT)
		rm -fr $(OUTPUT_DIR)
