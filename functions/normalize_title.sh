#!/usr/bin/env sh
# Perform the post title -> filename conversion
# Experts only. You may need to tune the locales too
# Leave empty for no conversion, which is not recommended
# This default filter respects backwards compatibility
normalize_title(){
    iconv -f utf-8 -t ascii//translit | 
    sed 's/^-*//' | 
    tr "[:upper:]" "[:lower:]" | 
    tr ' ' '-' | 
    tr -dc '[:alnum:]-'
}
 