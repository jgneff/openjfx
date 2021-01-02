#!/bin/bash
# Creates or updates the environment file
{
    printf "# Source this file for OpenJFX environment variables and aliases\n"
    printf "export JAVAFX_LIB=%s/sdk/lib\n" "$SNAP"
    printf "export JAVAFX_MOD=%s/jmods\n" "$SNAP"
    printf "alias java='openjfx.java'\n"
} > "$SNAP_COMMON/openjfx.env"
