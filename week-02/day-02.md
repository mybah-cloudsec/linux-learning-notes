# Week 2 — Day 2 : Bash Scripting Fundamentals

## What is a Bash Script ?

A bash script is a file containing a sequence of commands
executed line by line by the bash program.

Convention : files end with .sh
They start with a shebang — combination of bash # and bang !

Shebang : #!/bin/bash
Find bash location : which bash

---

## Create and Run a Script

Create :
nano run_all.sh

Example script content :
1  #!/bin/bash
2  echo "Today is" date
3
4  echo -e "\nEnter the path to directory"
5  read the_path
6
7  echo -e "\nYour path has the following files and folders:"
8  ls $the_path

Run a script :
- sh run_all.sh
- bash run_all.sh
- ./run_all.sh  (must be executable first : chmod +x run_all.sh)

---

## Variables

Bash variables have no type.

Two ways to declare :
1. Direct assignment : country=Pakistan
2. From command result : samecountry=$country

Declare with options :
declare [options] name=value
- -i : integer
- -r : read only (constant)
- -f : function

Simple declaration :
name=""

### Environment Variables
- PATH : list of directories where system looks for executables
- HOME : personal directory
- USER : current username
- LANG : language and locale configuration
- SHELL : default shell path
- PWD : current directory

### Input
read variable

---

## Control Operations

### Conditional Structure
Structure : if ... then ... else ... fi

$? : contains 0 if success, 1 to 255 if failed

Example :
age=25
if [[ $age -lt 18 ]] then
    echo "minor"
else
    echo "adult"
fi

### Comparison operators
- -eq : equal
- -ne : not equal
- -gt : greater than
- -ge : greater or equal
- -lt : less than
- -le : less or equal

---

## Loops

### For loop
fichiers=$(ls)
for fichier in $fichiers; do
    echo "Filename : $fichier"
done

### While loop
compteur=1
while [[ $compteur -le 5 ]]; do
    echo "compteur = $compteur"
    compteur=$(( compteur + 1 ))
done

---

## Tests

### Compare strings
'a' = 'b'

String tests :
- -z : empty string
- -n : not empty string

Check membership :
if [[ "$jour" = "Un" ]]; then

Get string length :
${#variable}

### File Test Operators
Check if a file exists, is empty, is a directory, etc.

Example :
if [[ -e "mon_fichier.txt" ]]; then
    echo "file exists"
fi

File test flags :
- -e : exists
- -d : is a directory
- -s : is empty
- -x : is executable

### Logical Test Operators
Used to combine multiple conditions :
- -a (AND) : [[ condition1 -a condition2 ]]
- -o (OR)
- ! (NOT) — single condition negation

---

## Exit Codes

Exit and exit codes : numeric values returned by a program
or script when it finishes.

$? contains the result of the last command :
- 0 = success
- 1 to 255 = failed

---

## Shell Script Debugging

### Option -x (trace mode)
bash -x mon_script.sh
Shows each command before executing it.

### set -e
Stops the script immediately on error.

### set -u
Generates an error if an undefined variable is used.

### Bash Debugger
bashdb or dbash

### Syntax checker
shellcheck mon_script.sh
Improves your syntax and catches errors before running.

---

*What I understood :*
The shebang tells the OS which interpreter to use. Variables
have no type in bash — everything is a string by default.
$? is critical — always check it after important commands.
set -e and set -u should be in every serious script.

*What was difficult :*
The difference between [ ] and [[ ]] — [[ ]] is the modern
bash version, more powerful and handles more cases safely.

*Tomorrow :* Bash scripting practice — writing real scripts
