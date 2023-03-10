#!/bin/bash

# Program parms
RPGM=DBCBEX02
PGM=DBCBEX02
LLM=GETDBID

# DB2 Load Libraries
export LOADLIB="$DB2_HOME/lib64"

# COBOL and SQL Copy Libraries
export COBCOPY="../cpy"
export SQLCOPY="$DB2_HOME/include/cobol_mf"

# Clean up
rm ../cbl/$PGM.bnd
rm ../tcbl/$PGM.cbl
rm ../bin/$RPGM

# DB2 Prep and Bind
db2 -tvf ../sql/$PGM.sql

read -p "Press any key to resume"

# Compile
cobc -std=default -x -o ../bin/$RPGM ../tcbl/$PGM.cbl ../tcbl/$LLM.cbl \
     -static \
     -I $SQLCOPY \
     -I $COBCOPY \
     -L $LOADLIB \
     -l db2 \
     -Wall \
     -O

# Check return code
if [ "$?" -eq 0 ]; then
    echo "Complier Return code was ZERO."
else
    echo "Complier Return code not ZERO."
fi
