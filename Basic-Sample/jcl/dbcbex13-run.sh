#!/bin/bash

# Set Up variables
# Program to run
PGM=DBCBEX13

# Export the environment variables in the .env file
export $(grep -v '^#' ../.env | xargs)

# Setup Report
export DD_OUTFILE="../spool/dbcbex13-report.rpt"

# run program
../bin/$PGM
