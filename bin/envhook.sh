#!/bin/bash
# Creates or updates the environment file

# Checks for required environment variables
: "${SNAP:?}"
: "${SNAP_COMMON:?}"

# Variables for finding the SDK location
root=/var/lib/snapd
sdklib=/sdk/lib
{
    printf "# Source this file for OpenJFX environment variables\n"
    if [ -d "${root}${SNAP}${sdklib}" ]; then
        printf "export JAVAFX_LIB=%s/sdk/lib\n" "${root}${SNAP}"
        printf "export JAVAFX_MOD=%s/jmods\n" "${root}${SNAP}"
    elif [ -d "${SNAP}${sdklib}" ]; then
        printf "export JAVAFX_LIB=%s/sdk/lib\n" "${SNAP}"
        printf "export JAVAFX_MOD=%s/jmods\n" "${SNAP}"
    fi
} > "${SNAP_COMMON}/openjfx.env"
