# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/sander/RadioNL

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/sander/RadioNL/build

# Utility rule file for radionl.sanderklootwijk.pot.

# Include the progress variables for this target.
include po/CMakeFiles/radionl.sanderklootwijk.pot.dir/progress.make

po/CMakeFiles/radionl.sanderklootwijk.pot:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/sander/RadioNL/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating translation template"
	cd /home/sander/RadioNL/build/po && /usr/bin/intltool-extract --update --type=gettext/ini --srcdir=/home/sander/RadioNL radionl.desktop.in
	cd /home/sander/RadioNL/build/po && /usr/bin/xgettext -o radionl.sanderklootwijk.pot -D /home/sander/RadioNL/po -D /home/sander/RadioNL/build/po --from-code=UTF-8 --c++ --qt --language=javascript --add-comments=TRANSLATORS --keyword=tr --keyword=tr:1,2 --keyword=N_ --keyword=_ --package-name='radionl.sanderklootwijk' ../qml/Main.qml radionl.desktop.in.h
	cd /home/sander/RadioNL/build/po && /usr/bin/cmake -E copy radionl.sanderklootwijk.pot /home/sander/RadioNL/po

radionl.sanderklootwijk.pot: po/CMakeFiles/radionl.sanderklootwijk.pot
radionl.sanderklootwijk.pot: po/CMakeFiles/radionl.sanderklootwijk.pot.dir/build.make

.PHONY : radionl.sanderklootwijk.pot

# Rule to build all files generated by this target.
po/CMakeFiles/radionl.sanderklootwijk.pot.dir/build: radionl.sanderklootwijk.pot

.PHONY : po/CMakeFiles/radionl.sanderklootwijk.pot.dir/build

po/CMakeFiles/radionl.sanderklootwijk.pot.dir/clean:
	cd /home/sander/RadioNL/build/po && $(CMAKE_COMMAND) -P CMakeFiles/radionl.sanderklootwijk.pot.dir/cmake_clean.cmake
.PHONY : po/CMakeFiles/radionl.sanderklootwijk.pot.dir/clean

po/CMakeFiles/radionl.sanderklootwijk.pot.dir/depend:
	cd /home/sander/RadioNL/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/sander/RadioNL /home/sander/RadioNL/po /home/sander/RadioNL/build /home/sander/RadioNL/build/po /home/sander/RadioNL/build/po/CMakeFiles/radionl.sanderklootwijk.pot.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : po/CMakeFiles/radionl.sanderklootwijk.pot.dir/depend

