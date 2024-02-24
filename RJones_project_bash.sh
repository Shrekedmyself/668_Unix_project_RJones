#!/bin/bash
### Make this a bash script that can be executed by putting
### a "shebang" at the top of the file

echo "It works!"

### (1) In your home directory make a directory called RAW_DATA

mkdir "$HOME/RAW_DATA"

### (2) Copy all .fna fasta files  
###     from home directory into RAW_DATA (must work from any directory.)

cp "$HOME/668_Unix_project_RJones/*.fna" "$HOME/RAW_DATA"

### (3) Do the same with all primer files ending with .csv

cp "$HOME/668_Unix_project_RJones/*.csv" "$HOME/RAW_DATA"

### (4) In your home directory, make 2 directories: P_DATA and RESULTS

mkdir "$HOME/P_DATA" "$HOME/RESULTS"

### (5) Add all three directories to your $PATH: ~/RAW_DATA, ~/P_DATA
###     and ~/RESULTS

export PATH="$HOME/RAW_DATA":"$HOME/P_DATA":"$HOME/RESULTS"

### (6) Write your entire $PATH, the text string RAW_DATA and the 
###    contents of this directory (the names of the files) into a new file 
###    called 'readme.txt' in your home directory

example_text="RAW_DATA" 
#Created a new variable and will call it later

/bin/ls -l "$HOME" > "$HOME/readme.txt"
echo "$example_text" >> "$HOME/readme.txt"
#Called the variable

/bin/ls -l "$HOME/RAW_DATA" >> "$HOME/readme.txt"

#For this, I had to include the directory location of the command "ls" as it would not work without specifying the location!!! This problem persisted for so long until I figured it out. Same thing with below

### (7) The last command should output the contents of readme.txt
###     to the terminal.

/bin/cat "$HOME/readme.txt"

#For this, I had to include the directory location of the command "cat" as it would not work without specifying the location!!! 
