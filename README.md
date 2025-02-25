# armos

**armos** is a minimalist operating system for ARM-based boards, written entirely in assembly. This project serves as the foundation for a blog series where we'll explore bare-metal ARM programming—from writing a simple bootloader to building out a full minimalist OS.

## Overview

The goal of **armos** is to provide a hands-on introduction to low-level ARM development. In this repository, you'll find:
- A basic ARM bootloader written in assembly.
- A well-organized project directory to support future enhancements.
- Build scripts and instructions for setting up a reliable development environment using the ARM toolchain and QEMU.

## Directory Structure

```
armos/  
├── asm/           # Assembly source files (bootloader, etc.)  
├── build/         # Build scripts and compiled binaries  
├── docs/          # Documentation and blog posts  
├── src/           # Additional source code (future kernel code)  
└── README.md      # Project overview and instructions
```

## Getting Started

### Prerequisites

- **ARM Toolchain:** Ensure you have the ARM toolchain (arm-none-eabi-gcc, arm-none-eabi-as, etc.) installed.
- **QEMU:** Install QEMU to emulate ARM hardware.

#### On Arch

```
sudo pacman -S arm-none-eabi-binutils arm-none-eabi-gcc qemu-system-arm
```

#### On Ubuntu/Linux

```
sudo apt-get update
sudo apt-get install gcc-arm-none-eabi binutils-arm-none-eabi qemu-system-arm
```

### Building the Project

A basic Makefile is provided to assemble and link the bootloader. To build the project, run:

```
make
```

This command will:
- Assemble your bootloader from asm/bootloader.s.
- Link the object file with -Ttext 0x0 so that your code is loaded at address 0x0.
- Generate an ELF binary (armos.elf) and a raw binary (armos.bin) in the build/ directory.

### Running in QEMU

Test your bootloader by running:

```
qemu-system-arm -M versatilepb -kernel build/armos.elf -nographic
```

This command uses QEMU's versatile platform emulation to boot your binary without a graphical interface.

## Project Goals and Future Work

This project lays the groundwork for a series that will cover:
- Extending the bootloader with more features.
- Initializing the ARM environment.
- Handling exceptions and interrupts.
- Building out a minimalist kernel and adding essential drivers.

Stay tuned for future updates as we evolve **armos** into a complete minimalist operating system.

## Contributing

Contributions, suggestions, and improvements are welcome! Please feel free to open issues or submit pull requests.

## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgements

Special thanks to the open-source community for the tools and resources that make projects like this possible.

