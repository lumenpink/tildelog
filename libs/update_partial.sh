#!/bin/sh

# Update partial

export global_cache_dir
export global_data_dir
update_partial() {
    
    local_update_partial_temp_filename="${global_cache_dir}/$(get_temp_filename)"
    export local_update_partial_get_tags=""
    # List all files in directory with their respective timestamp
    # TODO: this function doesn't run in BSD.
    # We need to find a POSIX way to fix it
    # Or customize the script
    # Suggestion: find ~  -type f -exec stat -f "%c %N" '{}' \;
    find "${global_data_dir}" -name "*.md" -type f -printf '%C@ %P\n' | sort > \
    "${local_update_partial_temp_filename}.timestamps"
    
    # Create a list of updated files
    diff "${global_cache_dir}/timestamps" "${local_update_partial_temp_filename}.timestamps" |
    grep '^[<>]' |
    cut -f3 -d\  |
    sort | uniq -c |
    grep -v '^ *1 ' |
    sort -nr |
    sed 's/^[[:space:]]*//g' |
    cut -f2 -d\ > "${local_update_partial_temp_filename}.updated"
    
    # Create a list of removed files
    diff "${global_cache_dir}/timestamps" "${local_update_partial_temp_filename}.timestamps" |
    grep '^[<]' |
    cut -f3 -d\  > "${local_update_partial_temp_filename}.tmp"
    diff "${local_update_partial_temp_filename}.updated" "${local_update_partial_temp_filename}.tmp" |
    grep '^[>]' | cut -f2 -d\ > "${local_update_partial_temp_filename}.removed"
    
    # Create a list of new files
    diff "${global_cache_dir}/timestamps" "${local_update_partial_temp_filename}.timestamps" |
    grep '^[>]' |
    cut -f3 -d\  > "${local_update_partial_temp_filename}.tmp"
    diff "${local_update_partial_temp_filename}.updated" "${local_update_partial_temp_filename}.tmp" |
    grep '^[>]' | cut -f2 -d\ > "${local_update_partial_temp_filename}.new"
    cat "${local_update_partial_temp_filename}.new" "${local_update_partial_temp_filename}.updated" > \
    "${local_update_partial_temp_filename}.newandupdated"
    
    echo "Updating posts..."
    local_update_partial_post_count=0
    while read -r local_update_partial_content ; do
        local_update_partial_post_count=$((local_update_partial_post_count+1))
        echo "Post ${local_update_partial_post_count} - ${local_update_partial_content}"
        generate_content "${local_update_partial_content}"
        local_update_partial_get_tags=$(get_tags "${local_update_partial_content}" "${local_update_partial_get_tags}")
    done < "${local_update_partial_temp_filename}.newandupdated"
    
    #generate_tags "${local_update_partial_get_tags}"
    mv  "${local_update_partial_temp_filename}.timestamps" "${global_cache_dir}/timestamps"
    #generate_index
    rm  "${local_update_partial_temp_filename}.new" \
    "${local_update_partial_temp_filename}.updated" \
    "${local_update_partial_temp_filename}.newandupdated" \
    "${local_update_partial_temp_filename}.removed" \
    "${local_update_partial_temp_filename}.tmp"
}