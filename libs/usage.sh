#!/usr/bin/env sh

# Displays the help

export global_software_name
export global_software_version
usage() {
    printf "%s %s\n" "$global_software_name" "$global_software_version" 
    printf "usage: %s command [filename]\n\n" "$0"
    printf "Commands:\n"
    printf "    post [filename]         insert a new blog post in markdown, or the filename of a draft to continue editing it\n"
    printf "    edit [-n] [filename]    edit an already published .md file. **NEVER** edit manually a published .html file,\n"
    printf "                            always use this function as it keeps internal data and rebuilds the blog\n"
    printf "                            use '-n' to give the file a new name, if title was changed\n"
    printf "    delete [filename]       deletes the post and rebuilds the blog\n"
    printf "    rebuild                 regenerates all the pages and posts, preserving the content of the entries\n"
    printf "    reset                   deletes everything except this script. Use with a lot of caution and back up first!\n"
    printf "    list                    list all posts\n"
    printf "    tags [-n]               list all tags in alphabetical order\n"
    printf "                            use '-n' to sort list by number of posts\n\n"
    printf "for more information please see https://tilde.team/wiki/?page=tildeblogs\n"
    printf "source here: https://tildegit.org/team/bashblog\n"
}
