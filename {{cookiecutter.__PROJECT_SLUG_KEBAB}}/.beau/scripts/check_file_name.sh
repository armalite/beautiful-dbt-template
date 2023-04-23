#!/bin/bash
# File names are important in dbt as they are used to create transient tables in target systems with the file name in boilerplate
# In Snowflake tables must begin with character, i.e filenames - 1_STAGE.SQL will error even if underlying SQL is valid

REGEX='^[a-zA-Z]'
FLAG=0
for file in $*; do
    if ! [[ $(basename $file) =~ $REGEX ]]; then
        echo $file; FLAG=1
    fi
done
if [[ $FLAG -ne 0 ]]; then
    echo "SQL file names must begin with characters in dbt"; exit 1
fi
