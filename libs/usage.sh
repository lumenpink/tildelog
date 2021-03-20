#!/usr/bin/env bash

# Displays the help

declare global_software_name
declare global_software_version
usage() {
    echo "$global_software_name $global_software_version"
    echo "usage: $0 command [filename]"
    echo ""
    echo "Commands:"
    echo "    post [filename]         insert a new blog post in markdown, or the filename of a draft to continue editing it"
    echo "    edit [-n] [filename]    edit an already published .md file. **NEVER** edit manually a published .html file,"
    echo "                            always use this function as it keeps internal data and rebuilds the blog"
    echo "                            use '-n' to give the file a new name, if title was changed"
    echo "    delete [filename]       deletes the post and rebuilds the blog"
    echo "    rebuild                 regenerates all the pages and posts, preserving the content of the entries"
    echo "    reset                   deletes everything except this script. Use with a lot of caution and back up first!"
    echo "    list                    list all posts"
    echo "    tags [-n]               list all tags in alphabetical order"
    echo "                            use '-n' to sort list by number of posts"
    echo ""
    echo "for more information please see https://tilde.team/wiki/?page=tildeblogs"
    echo "source here: https://tildegit.org/team/bashblog"
}
