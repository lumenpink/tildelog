#!/bin/sh

# The common and generic utils used


# Generate a random number between 0 and 9999
get_random() {
    awk 'BEGIN{ "date +%S%N" | getline seed; srand(seed); printf("%05d", int(100000*rand()))}'
}

# Return an *unique* filename (nanoseconds precision date - PID - pseudo random by AWK)
get_temp_filename() {
    printf ".entry-$(date +%Y%M%d%H%M%S%N)-%s-%s" "$$" "$(get_random)"
}

# End the script with a message
die() {
    local_die_message="${1:-''}"
    local_die_code="${2:-1}"
    echo "Script Interrupted. ${local_die_message}"
    exit "$local_die_code"
}

# Perform the post title -> filename conversion
# Experts only. You may need to tune the locales too
# Leave empty for no conversion, which is not recommended
# This default filter respects backwards compatibility
normalize_title(){
    iconv -f utf-8 -t ascii//translit |
    sed 's/^-*//' |
    tr "[:upper:]" "[:lower:]" |
    tr ' ' '-' |
    tr -dc '[:alnum:]-'
}