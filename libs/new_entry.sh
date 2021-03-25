#!/usr/bin/env sh

# Manages the creation of the text file and the parsing to html file
# also the drafts

export template_tags_line_header
export global_url
export convert_filename
export global_pwd

new_entry() {
    type=${1:-NONE}
    case "$type" in
        post)
            printf 'post\n'
            exit
        ;;
        note)
            message=${2:-''}
            if [ "x${message}" = "x" ] ; then
                printf 'create note\n'
            else
                printf 'create note with message %s\n' "${message}"
                new_note "${message}"
            fi
            exit
        ;;
        photo)
            file=${2:-''}
            message=${3:-''}
            if [ "x${file}" = "x" ] ; then
                printf 'No filename set\n'
                exit 1
            else
                photo="$file";
                if [ ! -f "${file}" ]; then
                    if [ ! -f "${global_pwd}/${file}" ]; then
                        printf 'Filename %s not found\n' "${photo}"
                        exit 1
                    else
                        photo="${global_pwd}/${file}"
                        printf 'Filename %s found\n' "${photo}"
                    fi
                fi
            fi
            if [ "x${message}" = "x" ] || [ "x${message}" = "xNONE" ] ; then
                printf 'create photo message with file %s\n' "$photo"
            else
                printf "create photo message: '%s' with file %s\n" "${message}" "$photo"
            fi
            exit
        ;;
        *)
            printf "Type of entry %1 unsupported\n" "$type"
            exit
        ;;
    esac
    
    TMPFILE=.entry-$(date +%Y%M%d%H%M%S%N).$$.md
    printf "Title on this line\n" >>"$TMPFILE"
        cat <<EOF >>"$TMPFILE"
The rest of the text file is a **Markdown** blog post. The process will continue
as soon as you exit your editor.

$template_tags_line_header keep-this-tag-format, tags-are-optional, beware-with-underscores-in-markdown, example
EOF
    
    chmod 600 "$TMPFILE"
    
    post_status="E"
    filename=""
    while [ "x$post_status" != "xp" ] && [ "x$post_status" != "xP" ]; do
        [ -n "$filename" ] && rm "$filename" # Delete the generated html file, if any
        
        $EDITOR "$TMPFILE"
        
        html_from_md=$(make_html "$TMPFILE")
        parse_file "$html_from_md"
        rm "$html_from_md"
        
        chmod 644 "$filename"
        [ -n "$preview_url" ] || preview_url=$global_url
        printf "To preview the entry, open %s/%s in your browser" "$preview_url" "$filename"
        
        printf "[P]ost this entry, [E]dit again, [D]raft for later, [C]ancel and quit? (p/e/d/c) "
        read -r post_status
        #Case user cancelled
        if [ "x$post_status" = "xc" ] || [ "$post_status" = "xC" ]; then
            rm "$TMPFILE"
            delete_includes
            printf "Your draft was erased. Nothing was changed in your blog.\n"
            exit
        fi
        #Case User choose post
        if [ "x$post_status" = "xd" ] || [ "x$post_status" = "xD" ]; then
            mkdir -p "drafts/"
            chmod 700 "drafts/"
            
            title=$(head -n 1 "$TMPFILE")
            [ -n "$convert_filename" ] && title=$(printf '%s' "$title" | eval "$convert_filename")
            [ -n "$title" ] || title=
            
            draft=drafts/$title.md
            mv "$TMPFILE" "$draft"
            chmod 600 "$draft"
            rm "$filename"
            delete_includes
            printf "Saved your draft as '%1'" "$draft"
            exit
        fi
    done
    
    mv "$TMPFILE" "${filename%%.*}.md"
    chmod 644 "$filename"
    printf "Posted %s" "$filename"
    relevant_tags=$(tags_in_post "$filename")
    if [ -n "$relevant_tags" ]; then
        # shellcheck disable=SC2086 # Intended splitting of $relevant_tags
        relevant_posts="$(posts_with_tags $relevant_tags) $filename"
        rebuild_tags "$relevant_posts" "$relevant_tags"
    fi
}
