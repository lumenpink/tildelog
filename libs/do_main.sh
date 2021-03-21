#!/usr/bin/env sh

# Main function
# Encapsulated on its own function for readability purposes
#
# $arg     command to run
# $arg2     file name of a draft to continue editing (optional)
export global_config
export global_data_dir
export global_config_prefix
export global_cache_dir
export global_pwd
do_main() {
    # Load default configuration, then override settings with the config file
    global_variables

    # shellcheck disable=SC1090 # variable config file
    [ -f "$global_config" ] && . "$global_config" > /dev/null 2>&1

    # make sure the directories exist
    mkdir -p "$global_config_prefix"
    mkdir -p "$global_data_dir"
    mkdir -p "$global_cache_dir"

    # make sure we're in the right directory
    if [ "$(pwd)" != "$global_data_dir" ]; then

        cd "$global_data_dir" || echo "Can't chdir to $global_data_dir" || exit 1
    fi

    # Detect if using BSD date or GNU date
    date_version_detect

    # Check for $EDITOR
    [ "x${EDITOR:-NONE}" = "xNONE" ] &&
        EDITOR="vi"

    # Check for validity of argument
    arg=${1-NONE}
    arg2=${2-NONE}
    arg3=${3-NONE}
   
    if [ "x$arg" = "xNONE" ] ; then
        usage 
        #exit 0
    fi
    
    case "$arg" in 
        "list")
            list_posts
            #exit 0
        ;;
        "tag")
            list_tags "$arg2" 
            #exit 0
        ;;
        "edit")
            edit "$arg2"
            #exit 0
        ;;
        "post")
            new_entry post "$arg2"
            #exit 0
        ;;
        "note")
            new_entry note "$arg2"
            #exit 0
        ;;
        "photo")
            new_entry photo "$arg2" "$arg3"
            #exit 0
        ;;
        "rebuild")
            rebuild "$arg2"
            #exit 0
        ;;
        "delete")
            delete "$arg2"
            #exit 0
        ;;
        *)
            usage
            #exit 1
        ;;
    esac
 
}