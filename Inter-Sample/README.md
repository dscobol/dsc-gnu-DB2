# Creating COBOL/DB2 programs with GnuCOBOL - Intermediate

Running these programs requires:
- IBM DB2 LUW (these were run against V11.5.8) on Linux installed as root.
- The SAMPLE DB has been created within DB2.
- GnuCOBOL 3.1.2
- You have added the db2profile to your .bashrc (or whatever shell you use .xxxrc file).

For more information about creating a VM, installing the requirements and other information, go to the [DSCOBOL Website](https://dscobol.github.io)

Here is the list of program names and descriptions in the Inter-Sample directory:

| Program  | Description                               |
| :------  | :---------------------------------------- |
|          |                                           |
| DBCBEX04 | This program will load a text file to a table in the DB.|
| DBCBEX05 | This program will update a row in the DB|
| DBCBEX06 | This program will delete a row from the DB|

**NOTE** This series uses a new table EMPLOYEE2.

This table is basically a copy of the EMPLOYEE table.

In the SAMPLE DB as installed, there are referential integrity rules for updating and deleting data.

For these examples, I didn't want to go down that path yet.

In other examples, this will be explored, but for now, this is okay.

**END NOTE**

## A guide to working with this repository.

I have a certain structure on my computer.

For DB2:
```
Inter-Sample
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
- spool: the printed output


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

In the compile step, the compiler will look for the "normal.cbl" COBOL program in the tcbl directory.

Creating this temporary file could be done away with but if there is an error in the compile step, it is helpful to have the "fully expanded" version of the code available to look at to find the problem.

### Why are they not present?
Only the following directories are pushed to a public repository:

cbl, cpy, data, docs, jcl, and p-sqlscripts.

The others are not public because they are either binary, temporary or they contain usernames and passwords. For examples of some of these, look in the docs directory.

## Running these programs on your system

Make sure your system meets the requirements listed above.

Complete these steps in this order:

Expanded instructions for the steps follow:

1. Create the missing directories
2. Copy and update the code from p-sqlscripts to SQLScripts
3. Run the script in SQLScripts to create the table
4. Create the .env file
5. Running the Code

### Create the missing directories
At the root of the Inter-Sample directory, Run:
``` bash
mkdir bin idata spool sql SQLScripts tcbl
```

### Copy and update the code from p-sqlscripts to SQLScripts
Use your preferred method to copy the EMPLOYEE2 directory from p-sqlscripts to SQLScripts.

There are multiple .sql and .sh files within that directory.

Update each .sql file with the correct DB(sample), userid, and password.

### Run the script in SQLScripts to create the table
In the SQLScripts/EMPLOYEE2 directory

Run:
``` bash
./db2_create_table.sh
```
If you want to start again from the beginning, Run:
``` bash
./db2_delete_data.sh
```
This will delete the data in EMPLOYEE2 and then run DBCBEX04 again. Or you could just Run:
``` bash
./db2_create_table.sh
```
Your choice.

### Create the .env file
**IMPORTANT NOTE:**
The .env file will contain the userid and password to the database. **MAKE SURE** to add ".env" to your .gitignore so when you commit changes, the .env file will NOT be included.

Copy docs/Code-env.txt to the Inter-Sample root and rename to .env .

- Edit .env  changing name to sample , userid to the userid and passwd to the password.

### Running a program - DBCBEX04
Copy docs/Code-prep-bind.txt into sql/ and rename to DBCBEX04.sql

- Update the top line replacing DB with sample, username with the Sample DB userid (typically db2inst1) and the password.

- Replace "PGM" with "DBCBEX04" in all 3 (.sqb, .cbl, .bnd) locations.

The "job" is divided into 2 scripts:
1. "prep, bind, compile, and link"
2. "run".

In the terminal, cd into jcl/ and run:
``` bash
./dbcbex04-compile.sh
```
Watch the output. There should be 0 errors on the prep/bind, press Enter to continue and the compile should return "SUCCESS: Compile Return code is ZERO.".

If so, in the terminal run:
``` bash
./dbcbex04-run.sh
```
and the results will print on the screen.

Follow this same procedure for the 2 other examples but replacing the "DBCBEX04" with the name of the program to be run.

