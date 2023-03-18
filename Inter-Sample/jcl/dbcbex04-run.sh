#!/bin/bash

# Set Up variables
# Program to run
PGM=DBCBEX04
export DD_EMPLOYE2="../data/employees.dat.txt"

# Export the environment variables in the .env file
export $(grep -v '^#' ../.env | xargs)

# run program
../bin/$PGM
