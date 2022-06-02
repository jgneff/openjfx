#!/bin/bash
# Creates the environment file on installation and updates

# Checks for required environment variables
: "${SNAP:?}"
: "${SNAP_DATA:?}"

{
    printf "# Source this file for OpenJFX environment variables\n"
    printf "export JAVAFX_LIB=%s/sdk/lib\n" "$SNAP"
    printf "export JAVAFX_MOD=%s/sdk/jmods\n" "$SNAP"
} > "$SNAP_DATA/openjfx.env"
