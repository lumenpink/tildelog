#!/usr/bin/env bash

# Main function
# Encapsulated on its own function for readability purposes
#
# $arg     command to run
# $arg2     file name of a draft to continue editing (optional)
declare global_config
declare global_data_dir
declare global_config_prefix
declare global_cache_dir
do_main() {
    # Load default configuration, then override settings with the config file
    global_variables

    # shellcheck disable=SC1090 # variable config file
    [[ -f "$global_config" ]] && source "$global_config" &>/dev/null
    global_variables_check

    # make sure we're in the right directory
    if [ "$(pwd)" != "$global_data_dir" ]; then
        echo "You're not in your blog directory. Moving you there now"
        mkdir -p "$global_config_prefix"
        mkdir -p "$global_data_dir"
        mkdir -p "$global_cache_dir"
        cd "$global_data_dir" || exit 1
    fi

    # Detect if using BSD date or GNU date
    date_version_detect

    # Check for $EDITOR
    [[ "x${EDITOR:-NONE}" == "xNONE" ]] &&
        EDITOR="vi"

    # Check for validity of argument
    arg=${1-none}
    arg2=${2-none}
    arg3=${2-none}
    [[ $arg != "reset" && $arg != "post" && $arg != "rebuild" && $arg != "list" && $arg != "edit" && $arg != "delete" && $arg != "tags" ]] &&
        usage && return

    [[ $arg == list ]] &&
        list_posts && return

    [[ $arg == tags ]] &&
        list_tags "$@" && return

    if [[ $arg == edit ]]; then
        if (($# < 2)) || [[ ! -f ${!#} ]]; then
            echo "Please enter a valid .md file to edit"
            exit
        fi
    fi

    # Test for existing html files
    if ls ./*.md &>/dev/null; then
        # We're going to back up just in case
        tar -c -z -f ".backup.tar.gz" -- *.html &&
            chmod 600 ".backup.tar.gz"
    elif [[ $arg == rebuild ]]; then
        echo "Can't find any html files, nothing to rebuild"
        return
    fi

    # Keep first backup of this day containing yesterday's version of the blog
    [[ ! -f .yesterday.tar.gz || $(date -r .yesterday.tar.gz +'%d') != "$(date +'%d')" ]] &&
        cp .backup.tar.gz .yesterday.tar.gz &>/dev/null

    [[ $arg == reset ]] &&
        reset && return

    create_css
    create_includes
    [[ $arg == post ]] && write_entry "$@"
    [[ $arg == rebuild ]] && rebuild_all_entries && rebuild_tags
    [[ $arg == delete ]] && rm "$arg2" &>/dev/null && rebuild_tags
    if [[ $arg == edit ]]; then
        if [[ $arg2 == -n ]]; then
            edit "$arg3"
        elif [[ $arg2 == -f ]]; then
            edit "$arg3" full
        else
            edit "$arg2" keep
        fi
    fi
    rebuild_index
    all_posts
    all_tags
    make_rss
    echo 'making gophermap'
    make_gophermap
    echo 'making geminicapsule'
    make_gemini
    echo 'deleting includes'
    delete_includes
}
