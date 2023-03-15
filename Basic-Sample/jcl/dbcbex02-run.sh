#!/bin/bash

# Set Up variables
# Program to run
PGM=DBCBEX02

# Export the environment variables in the .env file
export $(grep -v '^#' ../.env | xargs)

# run program
../bin/$PGM

# Remove the variables in the .env file from the environment
unset $(grep -v '^#' ../.env | sed -E 's/(.*)=.*/\1/' | xargs)
