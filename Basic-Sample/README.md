# Creating COBOL/DB2 programs with GnuCOBOL

Running these programs requires:
- IBM DB2 LUW (these were run against V11.5.8) on Linux installed as root.
- The SAMPLE DB has been created within DB2.
- GnuCOBOL 3.1.2
- You have added the db2profile to your .bashrc (or whatever shell you use .xxxrc file).

For more information about creating a VM, installing the requirements and other information, go to the [DSCOBOL Website](https://dscobol.github.io)

Here is the list of program names and descriptions in the Basic-Sample directory:

| Program  | Description                               |
| :------  | :---------------------------------------- |
|          |                                           |
| DBCBEX01 | This program will create a cursor then read and display all the records from a DB2 Table.|
| DBCBEX02 | This program will read and display 1 record from a DB2 Table.|
| DBCBEX03 | This program will read all the records using a View supplied by the DB and display them.|
| DBCBEX13 | This program will read all the records using a View supplied by the DB and print a nice report.|

All of these programs will only read data from the Sample DB.

Programs that insert, update and delete will be in the Intermediate(Inter) directory.

## ## A guide to working with this repository.

I have a certain structure on my computer.

For DB2:
```
Basic-Sample
│   ├───bin
│   ├───cbl
│   ├───cpy
│   ├───data
│   ├───docs
│   ├───jcl
│   ├───p-sqlscripts
│   ├───spool
│   ├───sql
│   ├───SQLScripts
│   └───tcbl
```
- bin: the executables
- cbl: the COBOL source code
- cpy: the copybooks
- data: the data for the programs
- jcl: the scripts used to compile and run
- spool: the printed output - This is optional in some directories.


Special DB2 directories:
- docs: public: examples of the files needed to run the programs
- p-sqlscripts: public: versions of SQL DDL code

- sql: not public: the sql code to prep and bind the COBOL programs
- SQLScripts: not public: versions of the SQL DDL code.
- tcbl: not public: temporary COBOL output

### What's the difference between the cbl and the tcbl directories?

A convention when writing regular COBOL programs is to use the extension ".cbl".

When writing COBOL programs with embedded DB2 EXEC statements, a convention is to use the extension ".sqb".

In the prep/bind step, prep will convert all the DB2 EXEC statements in the .sqb program to a CALL statement and write a new file out with an extension of .cbl to the tcbl directory.

In the compile step, the compiler will look for the "normal(.cbl)" COBOL program in the tcbl directory.

Creating this temporary file could be done away with but if there is an error in the compile step, sometimes it is helpful to have the "fully expanded" version of the code available to look at to find the problem.

### Why are they not present?
Only the following directories are pushed to a public repository:

cbl, cpy, data, docs, jcl, and p-sqlscripts.

The others are not public because they are either binary, temporary or they contain usernames and passwords. For examples of some of these, look in the docs directory.

## Running these programs on your system

Make sure your system meets the requirements listed above.

After cloning the repository, CD into the Basic-Sample directory and run this command to create the missing directories
```
mkdir bin p-sqlscripts spool sql SQLScripts tcbl
```
### Create the .env file - This only needs to be done once.
**IMPORTANT NOTE:**
The .env file will contain the userid and password to the database. **MAKE SURE** to add ".env" to your .gitignore so when you commit changes, the .env file will NOT be included.

Copy docs/Code-env.txt to the Basic-Sample root and rename to .env .

Edit .env  changing name to sample , userid to the userid and passwd to the password.

### Running a program - DBCBEX01
Copy docs/Code-prep-bind.txt into sql/ and rename to DBCBEX01.sql

Update the top line replacing DB with sample, username with the Sample DB userid (typically db2inst1) and the password.
Replace "PGM" with "DBCBEX01" in all 3 (.sqb, .cbl, .bnd) locations.

The "job" is divided into 2 scripts:
- "prep, bind, compile, and link"
- "run".

In the terminal, cd into jcl/ and run:
```
./dbcbex01-compile.sh
```
Watch the output. There should be 0 errors on the prep/bind, press Enter to continue and the compile should return "SUCCESS: Compile Return code is ZERO.".

If so, in the terminal run:
```
./dbcbex01-run.sh
```
and the results will print on the screen.

Follow this same procedure for the 3 other examples but replacing the "DBCBEX01" with the name of the program to be run.

### What about SQLScripts and p-sqlscripts?

In more advanced tutorials, SQLScripts is where actual SQL scripts are located. Scripts like "Create a table", "Insert Data" and such.

These usually have the userid and password embedded in them.

So, p-sqlscripts is a place to put "sanitized" versions of those scripts that can be commited to git and pushed to a public repository which from there, they can be copied into and edited in SQLScripts.

This basic example only reads from the Sample DB and that DB was created by a different command so there is no reason to include any of those scripts here.
