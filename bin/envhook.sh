#!/bin/bash
# Creates or updates the environment file

# Checks for required environment variables
: "${SNAP_INSTANCE_NAME:?}"
: "${SNAP_REVISION:?}"
: "${SNAP_COMMON:?}"

# Snaps are under '/var/lib/snapd/snap' on Fedora, '/snap' on Debian.
root=/var/lib/snapd
snap=/snap/${SNAP_INSTANCE_NAME}/${SNAP_REVISION}
sdklib=/sdk/lib

{
    printf "# Source this file for OpenJFX environment variables\n"
    if [ -d "${root}${snap}${sdklib}" ]; then
        printf "export JAVAFX_LIB=%s/sdk/lib\n" "${root}${snap}"
        printf "export JAVAFX_MOD=%s/jmods\n" "${root}${snap}"
    elif [ -d "${snap}${sdklib}" ]; then
        printf "export JAVAFX_LIB=%s/sdk/lib\n" "${snap}"
        printf "export JAVAFX_MOD=%s/jmods\n" "${snap}"
    fi
} > "${SNAP_COMMON}/openjfx.env"
