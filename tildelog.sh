#!/usr/bin/env bash

# shellcheck disable=SC1091
# shellcheck disable=SC2034

# TildeLog, a not-so-simple blog/gemlog/phlog system made primarily for consoles
# By Josemar Lohn <j@lo.hn>
#
# Heavily based on BashBlog, by Carlos Fenollosa <carlos.fenollosa@gmail.com>

md2html_awk=$(cat deps/bin/md2html)
md2gemini_awk=$(cat deps/bin/md2gemini)
md2gopher_awk=$(cat deps/bin/md2gopher)
version=$(cat VERSION)

export md2html_awk md2gemini_awk md2gopher_awk version

### BEGIN SOURCEFILES -> DO NOT REMOVE THIS LINE
source ./functions/global_variables.sh
source ./functions/date_version_detect.sh
source ./libs/do_main.sh
source ./libs/usage.sh

### END SOURCEFILES -> DO NOT REMOVE THIS LINE

#
# MAIN
# Do not change anything here. If you want to modify the code, edit do_main()
#
do_main "$@"

### END OF FILE
