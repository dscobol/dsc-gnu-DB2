#!/bin/bash

# Set Up variables

# Program to run
PGM=DBCBEX06

# DB2 Load Libraries
export LOADLIB="$DB2_HOME/lib64"

# COBOL and SQL Copy Libraries
export COBCOPY="../cpy"
export SQLCOPY="$DB2_HOME/include/cobol_mf"

# Delete previous versions
rm ../cbl/$PGM.bnd
rm ../tcbl/$PGM.cbl
rm ../bin/$PGM

# DB2 Prep and Bind
db2 -tvf ../sql/$PGM.sql

read -p "Press any key to resume"

# Compile
cobc -std=default -x -o ../bin/$PGM ../tcbl/$PGM.cbl \
     -static \
     -I $SQLCOPY \
     -I $COBCOPY \
     -L $LOADLIB \
     -l db2 \
     -Wall \
     -O

# Check return code
if [ "$?" -eq 0 ]; then
    echo "SUCCESS: Compile Return code is ZERO."
else
    echo "FAIL: Compile Return code is NOT ZERO."
fi
