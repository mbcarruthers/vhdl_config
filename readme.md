# General Purpose / vendor agnostic basic VHDL Config 

Utilizes GHDL for simulation, Sigasi for linting, and Surfer for 
viewing waveforms. I made this to make it easier to start with writing 
basic VHDL without having to worry about those god awful vendor IDE's and 
their initial complexity. 

## Features
-  **Makefile commands**: type `make help` to view commands
-  **Automatic file discovery**: Finds all `.vhdl` files in `src/` and `tb/`  
-  **Waveform support**: Generates `.ghw` or `.vcd` for Surfer/GTKWave  
-  **Project renaming**: `make replace NEW_ENTITY=new_name`  
-  **Help command**: `make help`, will display available make commands 

## Prerequisites 

- [Codium](https://vscodium.com/)
- [Surfer Waveform Viewer](https://surfer-project.org/)
- [Sigasi Community Edition](https://www.sigasi.com/)
- [GHDL](https://github.com/ghdl/ghdl)

## Process

- Install codium, Sigasi on codium, GHDL, GTKWave(optional for vcd, if you prefer GTKWave), and Surfer 

- Run `make replace NEW_ENTITY=<entity_name>`

- then open in codium 


Note: Surfer installed and added to .bashrc as surf
