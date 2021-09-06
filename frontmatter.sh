#!/bin/sh
# Strips YAML FrontMattter from a file (usually Markdown).

# Exit immediately on each error and unset variable;
# see: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#
# https://stackoverflow.com/questions/28221779/how-to-remove-yaml-frontmatter-from-markdown-files
# from hoijui (https://stackoverflow.com/users/586229/hoijui)

set -e

print_help() {
    echo "Strips YAML FrontMattter from a file (usually Markdown)."
    echo
    echo "Usage:"
    echo "    `basename $0` -h"
    echo "    `basename $0` --help"
    echo "    `basename $0` -i <file-with-front-matter>"
    echo "    `basename $0` --in-place <file-with-front-matter>"
    echo "    `basename $0` <file-with-front-matter> <file-to-be-without-front-matter>"
}

replace=false
in_file="-"
out_file="/dev/stdout"

if [ -n "$1" ]
then
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]
    then
        print_help
        exit 0
    elif [ "$1" = "-i" ] || [ "$1" = "--in-place" ]
    then
        replace=true
        in_file="$2"
        out_file="$in_file"
    else
        in_file="$1"
        if [ -n "$2" ]
        then
            out_file="$2"
        fi
    fi
fi

tmp_out_file="$out_file"
if $replace
then
    tmp_out_file="${in_file}_tmp"
fi

awk '
BEGIN { 
    is_first_line=1;
    in_fm=0;
    in_cm=0;
    tag=0
}
/^---$/ {    
    if (is_first_line) {
        in_fm=1;        
    }
    if (!in_fm) {
	in_cm=1;
    }
    tag=1;
}
{
    if (in_cm && !tag) {
        print $0;
    }
    if (tag) {
    tag=0;
    }
}
/^(---|...)$/ {
    if (! is_first_line) {
        in_fm=0;
    }
    is_first_line=0;
}' "$in_file" >> "$tmp_out_file"

if $replace
then
    mv "$tmp_out_file" "$out_file"
fi
