#!/usr/bin/env sh

# Detects if GNU date is installed
export date_format_full
date_version_detect() {
    arg=${1:-''}
    arg2=${2:-''}
    arg3=${3:-''}
    if ! stat -c"%U" /dev/null >/dev/null 2>&1 ; then
        # BSD environment
        if command -v gdate >/dev/null 2>&1 ; then
            date() {
                gdate "$@"
            }
        else
            date() {
                # shellcheck disable=SC2086
                if [ "$arg" = "-r" ]; then
                    # Fall back to using stat for 'date -r'
                    format=$(printf "%s" "$arg3" | sed 's/^+//'a= ) # Ugly hack to remove the plus sign in POSIX
                    stat -f "%Sm" -t "$format" "$2"               
                elif [ "$(printf '%s' $arg2 | cut -c1-6)" = '--date' ] ; then
                    # convert between dates using BSD date syntax
                    command date -j -f "$date_format_full" "$( printf '%s' $arg2 | sed 's/^--date=//' )" "$arg" 
                else
                    # acceptable format for BSD date
                    command date -j "$@"
                fi
            }
        fi
    fi
}