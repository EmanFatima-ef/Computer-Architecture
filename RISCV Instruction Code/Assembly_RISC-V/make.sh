rmdir -r build
mkdir build
riscv64-unknown-elf-as -c -o build/startup.o src/startup.s -march=rv32i -mabi=ilp32
riscv64-unknown-elf-as -c -o build/gcd.o src/gcd.s -march=rv32i -mabi=ilp32
riscv64-unknown-elf-gcc -o build/main.elf build/startup.o build/gcd.o -T linker.ld -nostdlib -march=rv32i -mabi=ilp32
riscv64-unknown-elf-objcopy -O binary --only-section=.data* --only-section=.text* build/main.elf build/main.bin
python3 maketxt.py build/main.bin > build/main.txt
riscv64-unknown-elf-objdump -S -s build/main.elf > build/main.dump