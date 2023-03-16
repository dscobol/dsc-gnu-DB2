#!/bin/bash

# Set Up variables
# Program to run
PGM=DBCBEX02

# Export the environment variables in the .env file
export $(grep -v '^#' ../.env | xargs)

# run program
../bin/$PGM
