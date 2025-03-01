# Makefile for the armos project

# Cross-compiler tools (assuming arm-none-eabi toolchain)
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy

# Files and directories
ASM_SRCS = asm/bootloader.s asm/uart.s
BUILD_DIR = build
TARGET = armos.elf

all: $(BUILD_DIR)/$(TARGET)

$(BUILD_DIR)/$(TARGET): $(ASM_SRCS)
	@mkdir -p $(BUILD_DIR)
	$(AS) -o $(BUILD_DIR)/bootloader.o asm/bootloader.s
	$(AS) -o $(BUILD_DIR)/uart.o asm/uart.s
	$(LD) -Ttext 0x0 -o $(BUILD_DIR)/$(TARGET) $(BUILD_DIR)/bootloader.o $(BUILD_DIR)/uart.o
	$(OBJCOPY) -O binary $(BUILD_DIR)/$(TARGET) $(BUILD_DIR)/armos.bin

clean:
	rm -rf $(BUILD_DIR)


