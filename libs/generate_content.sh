#!/bin/sh

# Generate the content

generate_content() {
    local_generate_content_filename=${1:-''}
    if [ "x$local_generate_content_filename" = "x" ] ; then
        die 'Cannot generate content without a filename'
    fi
    
    
}