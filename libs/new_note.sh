#!/usr/bin/env sh

# Create a note

export global_cache_dir
export global_data_dir

new_note() {
    local_new_note_temp_file="${global_cache_dir}/$(get_temp_filename).md"
    local_new_note_message="${1:-''}"
    local_new_note_dest_dir="${global_data_dir}/$(date '+%Y/%M/%d')/$(get_random)"
    while [ -d "$local_new_note_dest_dir " ] ; do
        local_new_note_dest_dir="${global_data_dir}/$(date '+%Y/%M/%d/')/$(get_random)"
    done
    if [ "x${local_new_note_message}" = 'x' ] ; then
        die "No message passed"
    fi
    echo "${local_new_note_message}" > "${local_new_note_temp_file}"
    
    mkdir -p "${local_new_note_dest_dir}"
    mv "${local_new_note_temp_file}" "${local_new_note_dest_dir}/note.md"
    
    update_partial
    
    
    
}
