# Makefile for the armos project

# Cross-compiler tools (assuming arm-none-eabi toolchain)
AS = arm-none-eabi-as
CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy

# Compiler and assembler flags
CFLAGS = -ffreestanding -nostdlib -O2 -Wall -Wextra
ASFLAGS =
LDFLAGS = -T linker.ld -nostdlib

# Files and directories
BUILD_DIR = build
TARGET = armos.elf
BIN_TARGET = armos.bin

# Source files
ASM_SRCS = asm/bootloader.s asm/uart.s
C_SRCS = src/kmain.c
OBJS = $(BUILD_DIR)/bootloader.o $(BUILD_DIR)/uart.o $(BUILD_DIR)/kmain.o

# Build rules
all: $(BUILD_DIR)/$(BIN_TARGET)

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

# Assemble the bootloader and UART
$(BUILD_DIR)/bootloader.o: asm/bootloader.s | $(BUILD_DIR)
	$(AS) $(ASFLAGS) -o $@ $<

$(BUILD_DIR)/uart.o: asm/uart.s | $(BUILD_DIR)
	$(AS) $(ASFLAGS) -o $@ $<

# Compile the C source file
$(BUILD_DIR)/kmain.o: src/kmain.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c -o $@ $<

# Link everything together
$(BUILD_DIR)/$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS)

# Convert ELF to binary
$(BUILD_DIR)/$(BIN_TARGET): $(BUILD_DIR)/$(TARGET)
	$(OBJCOPY) -O binary $< $@

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR)
