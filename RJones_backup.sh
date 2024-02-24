#!/bin/bash

#The purpose of this bash script is copy all the files in a directory
# to a special folder called BACKUP_FILES in your home directory.  
# The script should (1) first check if the BACKUP_FILES directory exists
# and if not, create it. Then (2) copy all the files 1 at a time and echo
# the copy command to the terminal. Finally (3) Run a function that prints  
# out some information to the screen.

#The following execute would copy all the files in the TMP directory to
# BACKUP_FILES in the home directory.

# $./Kelley_backup.sh TMP/

#Part 1: Check if the directory BACKUP_FILES exits
#  in your home directory. If it does not exist create the directory
#  and echo "Created BACKUP_FILES in $HOME directory "
#  If directory exists, echo "Directory $HOME/BACKUP_FILES exists."
#  HINT: https://www.cyberciti.biz/faq/howto-check-if-a-directory-exists-in-a-bash-shellscript/

#  Note: you can use the $HOME variable in bash like this $HOME/BACKUP_FILES

directory="$HOME/BACKUP_FILES" 
#Creating a variable named 'directory' and setting it equal to our 'BACKUP_FILES' directory that is found within the home directory

directory2="$1"  
# The first argument passed into the script is the  source directory

if [ -d "$directory" ]; then
    echo "Directory $directory exists."
else
    mkdir "$directory" && echo "Created BACKUP_FILES in $HOME directory"
fi

#This checks if the directory /$HOME/BACKUP_FILES exists using the variable that we had previously assigned and will conditionally test `[]` to see if it exists with '-d' and THEN 
#It will print 'Directory [insert variable that we previously assigned] exists'
#If this is not met, it will then
#Make the directory assigned in the first variable and say that it created the directory within the home directory
#Then it will exit


#Part 2: Write a for loop that copies all the files of a directory into BACKUP_FILES
#  The directory needs to be specific as the first option after the script (see above).

#  Hint: see the script 'convert_html_to_php.sh' at:
#     https://ryanstutorials.net/bash-scripting-tutorial/bash-loops.php

for file in "$directory2"/*; do
    cp -r "$file" "$directory" && echo "Copying $file to $directory"
done

#Using a for loop with the source directory, we will copy all the files with the * wildcard and then do
#Copying of the files into $HOME/BACKUP_FILES and then it will then say that it copied the filenames to our specified directory
 
#Part 3: Create a function called print_info that
#   (1) Uses the ls command to output all the file information (option -al)
#       in $HOME/BACKUP_FILES to the screen.
#   (2) Runs the disk usage command on the same file to report total
#       kilobytes of all the files in the directory
#       For example $du -sh Music would report the total disk usage of all
#       the files in my Music directory:
#         $ du -sh Music
#         15G   Music
#   (3) Then run print_info


print_info() {
    echo "Listing with ls -al all file information in $directory:"
    ls -al "$directory"
    echo "Total disk usage of $directory:"
    du -sh "$directory"
}

#This creates the function 'print_info' and then groups in the next commands
#Saying that it will then list all file information in our specified directory
#Does that
#Then it says it will give us the total disk usage of our specified directory
#Then using d(isk) u(sage) it will s(ummarize) in a h(uman) readable format the directory that we had specified

#####THE OUTPUT SHOULD BE SOMETHING LIKE THIS#####
# if TMP has 3 files, then

# $./Kelley_backup.sh TMP/

# should generate:

# Created BACKUP_FILES in /Users/kina directory
# TMP//my_ls.sh copied to /Users/kina/BACKUP_FILES
# TMP//pysh.py copied to /Users/kina/BACKUP_FILES
# TMP//while-count.sh copied to /Users/kina/BACKUP_FILES
# total 24
# drwxr-xr-x   5 kina  staff   160 Feb  7 20:51 .
# drwxr-xr-x+ 71 kina  staff  2272 Feb  7 20:51 ..
# -rwxr-xr-x   1 kina  staff   100 Feb  7 20:51 my_ls.sh
# -rwxr-xr-x   1 kina  staff   144 Feb  7 20:51 pysh.py
# -rwxr-xr-x   1 kina  staff   152 Feb  7 20:51 while-count.sh
#  12K  /Users/kina/BACKUP_FILES