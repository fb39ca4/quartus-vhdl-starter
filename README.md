# Quartus VHDL Starter Project

This is a simple Quartus project you can use as the base for starting your own projects without having to go through an extensive setup process with finding the FPGA part and assigning pins from within Quartus.

## Files and Directories

* `quartus_starter_project.qpf` is the project file which should be opened in Quartus, It is more or less a list of .qsf filenames for revisions.
* `DE0-CV.qsf` and `DE1-SoC.qsf` are settings files, also referred to as revisions. They contain all the settings and pin assignments. You can have different revisions which let you maintain settings for different FPGA boards. Right now DE0-CV is the selected revision, but if you have a DE1-SoC you can change to it by going to *Project → Revisions...* in Quartus.
* `output_files` is where compilation results will appear, including the files for the programmer and other intermediate files. You can change this location in the .qsf file.
* `src` is where all the VHDL files are stored. You don't have to keep them here, but it is nice to have them in their own place.
* `db` and `incremental_db` are used internally by Quartus. There is no harm in deleting these folders, as Quartus will regenerate them.

## Pin Assignments

Physical pins on the FPGA board are given letter-number names corresponding to the row and column on the package, such as N22 or R17. It's difficult to remember what goes where so you can assign more descriptive names to pins. These assignments are found in the .qsf file, or can be viewed with *Assignments → Pin Planner* in Quartus. The assignments in this project use the same names as in the user manual for the DE0-CV and DE1-SoC boards:

* `SW`: Sliding switches, high when pushed towards top of board
* `LEDR`: Red LEDs above switches, lit when high
* `KEY`: Pushbuttons, low when pressed
* `HEX0`, `HEX1`, ...: Hexadecimal displays, segments lit when low
* `CLOCK_50`: 50 MHz clock

## Top Level Entity

Think of the top level entity as the VHDL equivalent of a `main` function. It is the first entity the compiler sees, and then any sub-entities used in that top level entity will be instantiated. The inputs and outputs to this top level entity must have names that match the pin assignment names, so the compiler knows how to connect the entity to the outside world.

The currently selected top level entity is `BinaryAdder`, but it is possible to write multiple and switch between them before compiling, by opening the file you want to set and going to *Project → Set as Top Level Entity*

## Compiling and Running

Opening the project and selecting *Processing → Start Compilation* should start the compilation process, which may take several minutes.

If compilation is successful, the output can be uploaded to the FPGA by opening the programmer utility (*Tools → Programmer*), selecting the .sof file in output_files, and selecting the board to program.

## Source Control

The only files necessary to commit in this project are the .qpf, .qsf, and VHDL source files. There is no need to commit any output files or the db directories, and doing so will just clutter the repository. The .gitignore file provided tries to ignore the generated files, but it is not exhaustive and will need to be updated as additional Quartus features are used.
