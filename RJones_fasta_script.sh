#! /bin/bash

### Run this script from within the RAW_DATA folder which should be in your home directory (~/RAW_DATA)
### Inside this directory should be this script AND the fasta file bigdata.fna

### NOTE THAT SECTIONS (1) and (2) HAVE ALREADY BEEN COMPLETED so you do not need to edit (1) and (2). 

### (1) This will ask the user for a fasta file for analysis. The following command, read, reads in user input from the command line.
###     For this exercise, enter the filename bigdata.fna which should be in your file ~/RAW_DATA

read -p "Enter fasta filename: " fn
#Prompting the user to enter the fasta file name, in this case, our boy bigdata.fna

### (2) This will check to see if the file exists. If the file does not exist, the function exits. I modified this if/then statement from the internet.

if [[ ! -f ./$fn ]]; then
   echo "The file does not exist. Exiting..."
   exit 1
fi

echo $fn

#Using an if statement, if the file/file name does NOT! exist
#Say it does not exist and exit and be done!


### (3) Split up the bigdata.fna into separate smaller .fna files of 50,000 sequences each.
###
###     I got the following line of code below from the internet. You will need to modify this awk command.
###
###     Currently, the below awk command splits a fasta file into smaller files of just 1000 sequences each. We want the fasta file to be split into smaller files of 50000 sequences each. Modify the awk script to make this happen. 
###
###     The other problem is that it works on the wrong file. Change it so that it works with the user input file (see echo above) (hint: how do you call variables in AWK commands???).
###     Change these things and you should get 3 to 4 output files starting with 'myseq'

read -p "Enter the name of the input file: " input_file

#Here we are using the read fx to prompt the user to input the file name and save that as the variable 'input_file'

awk 'BEGIN {n_seq=0;} /^>/ {if(n_seq%50000==0){file=sprintf("myseq%d.fna",n_seq);} print >> file; n_seq++; next;} { print > file; }' "$input_file"

#Using awk directly into the command line, it will BEGIN a count of n_seq at 0 and then it will, using the lines that start with >, enter into an if then statement where once the n_seq = 50k it will then create a new file/file name using string print formatted with the sequence count and that starts with myseq and will replace %d with n_seq and then end that with ;. It will then print that and append it to 
file named by the 'file' variable and then end. Then it will move to the next line, and for lines that do not begin with > it will save that to file. This entire thing uses the "sequences.fna" file.

### (4) Use grep to check how many fasta sequences are in all of the .fna files and redirect this to a file in RAW_DATA called 'log.txt'
###     Hints on grep: -c counts and you can grep multiple files at once using the *. 

grep -c '^>' myseq*.fna > log.txt
#Using grep to c(ount) the number of times that a line STARTS ^ with > aka a sequence in our myseq*fna files and saving that to log.txt

### (5) Print the output of log.txt to the terminal 

cat log.txt #Using our feline friend to read 

### (6) Below is a for loop and an awk script. The for loop below cycles though every file in the current directory and prints them.
###     The awk script removes all the line breaks from fasta files.
###     TASK: Change the for loop so that it runs the awk command on all of the my*fna files and
###           outputs a new file with a .txt extension.
###     HINT: put the awk inside the do loop; also you can add extensions by $f'.txt' - this added a .txt to every $f file.

### More information on for loops can be found at: https://www.cyberciti.biz/faq/bash-loop-over-file/

for f in myseq*.fna
do
    awk 'BEGIN{RS=">"}{gsub("\n","",$0); print ">"$0}' "$f" > "$f.txt"
done

#This will create a for loop in our files that end in fan
#And using awk, it will then BEGIN and set the R(ecord)S(eparator) to be '>', which is the start of a sequence in a fasta file and then sub out new lines for nothing (removing them) starting at line 0 and then will print > following by line zero without line breaks (as we removed them) and then reassign that to a .txt file output!!! PHEW... 

### (7) Use a for loop to count all the instances of the following string in all of the .fna.txt files:
###     'CACCCTCTCAGGTCGGCTACGCATCGTCGCC'
###     Also, like in (4) have the grep results for all files appended to log.txt (DON'T OVERWRITE IT)
###       then show the contents of log.txt in the terminal

for fn in my*fna.txt 
do
    grep -c 'CACCCTCTCAGGTCGGCTACGCATCGTCGCC' "$fn" >> log.txt
done
cat log.txt

#This will create a for loop in our files and do with:
#Grep to -c(ount) the occurrences of our given string of each of the files in our for loop and append it to log.txt (NOT OVERWRITING IT BECAUSE WE'RE USING >> !!!)
#Ending it and using our feline friend to read out log.txt

### (8) Move all the .fna.txt files to the directory ~/P_DATA

mv $HOME/RAW_DATA/*.fna.txt $HOME/P_DATA

### (9) Make a tar archive of the files in P_DATA - call it pdata.tar

tar -cf $HOME/P_DATA/pdata.tar $HOME/P_DATA/*
#This will use tar to c(reate) a new archive using the f(ilename) that we specified 'pdata.tar'

### (10) Compress pdata.tar

gzip $HOME/P_DATA/pdata.tar
echo "The compressor has compressed"
echo "gzip is less cool of a command name than gunzip"



