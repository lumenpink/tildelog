#!/usr/bin/env bash

# Detects if GNU date is installed
declare date_format_full
date_version_detect() {
    if ! stat -c"%U" /dev/null >/dev/null 2>&1 ; then
        # BSD environment
        if command -v gdate >/dev/null 2>&1 ; then
            date() {
                gdate "$@"
            }
        else
            date() {
                if [[ $1 == -r ]]; then
                    # Fall back to using stat for 'date -r'
                    format=${3//+/}
                    stat -f "%Sm" -t "$format" "$2"
                elif [[ $2 == --date* ]]; then
                    # convert between dates using BSD date syntax
                    command date -j -f "$date_format_full" "${2#--date=}" "$1" 
                else
                    # acceptable format for BSD date
                    command date -j "$@"
                fi
            }
        fi
    fi
}