# VHDL Shenanigans

This repository contains VHDL code for some shenanigans. Just random things I made while learning and experimenting with VHDL simulation.
I don't own an FPGA, so unfortunately I can't guarantee that it will work on real metal. One day maybe.

## Prerequisites

Before you can build and simulate VHDL code, make sure you have the following prerequisites installed on your Linux machine:

- [ghdl](https://github.com/ghdl/ghdl): The VHDL compiler/simulator
- [GTKWave](http://gtkwave.sourceforge.net/): A waveform viewer

## Building

To build the VHDL code, follow these steps:

1. Clone this repository: `git clone https://github.com/your-username/VHDLShenanigans.git`
2. Change into the repository directory: `cd VHDLShenanigans`
3. Change into the subdirectory of the project of your choice: `cd <project> `
4. Compile the VHDL code using `ghdl`: `ghdl -a <vhdl_file>.vhdl`
5. Elaborate the top-level entity: `ghdl -e <top_level_entity>`
6. Generate the executable: `ghdl -r <top_level_entity>`

## Simulating

To simulate the VHDL code, follow these steps:

1. Build the VHDL code using the instructions mentioned above.
2. Run the simulation: `ghdl -r <top_level_entity> --vcd=<waveform_file>.vcd`
3. Open the waveform file using GTKWave: `gtkwave <waveform_file>.vcd`

## Contributing

If you would like to contribute to this repository, feel free to open a pull request.

## License

This project is licensed under the [MIT License](LICENSE).