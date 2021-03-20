#!/usr/bin/env bash
# shellcheck disable=SC2034
# Global variables
# It is recommended to perform a 'rebuild' after changing any of this in the code

# Config file. Any settings "key=value" written there will override the
# global_variables defaults.

declare version
# This function will load all the variables defined here. They might be overridden
# by the 'global_config' file contents
global_variables() {
    global_software_name="tildelog"
    global_software_version="$version"
    global_config_prefix="${XDG_CONFIG_HOME:-$HOME/.config/}"
    global_config="$global_config_prefix/$global_software_name"
    global_data_prefix="${XDG_DATA_HOME:-$HOME/.local/share}"
    global_data_dir="$global_data_prefix/$global_software_name"
    global_data_prefix="${XDG_CACHE_HOME:-$HOME/.cache}"
    global_cache_dir="$global_data_prefix/$global_software_name"
    # Blog title
    global_title="my tildelog"
    # The typical subtitle for each blog
    global_description="a blog about tildes"
    # The server base domain
    global_domain="localhost"
    # The public base URL for this blog
    global_url="https://${global_domain}/~$USER/blog"
    # Your name
    global_author="~$USER"
    # You can use twitter or facebook or anything for global_author_url
    global_author_url="https://${global_domain}/~$USER/"
    # Your email
    global_email="$USER@${global_domain}"

    # CC by-nc-nd is a good starting point, you can change this to "&copy;" for Copyright
    global_license="CC by-nc-nd"

    # Blog generated files
    # index page of blog (it is usually good to use "index.html" here)
    index_file="index.html"
    number_of_index_articles="20"
    # global archive
    archive_index="all_posts.html"
    tags_index="all_tags.html"

    # ignore gophermap file
    gophermap="gophermap"

    # ignore gemini generation script and gemini index
    gemini_index="index.gmi"

    # feed file (rss in this case)
    blog_feed="feed.rss"
    number_of_feed_articles="50"
    # "cut" blog entry when putting it to index page. Leave blank for full articles in front page
    # i.e. include only up to first '<hr>', or '----' in markdown
    cut_do="cut"
    # When cutting, cut also tags? If "no", tags will appear in index page for cut articles
    cut_tags="yes"
    # Regexp matching the HTML line where to do the cut
    # note that slash is regexp separator so you need to prepend it with backslash
    cut_line='<hr ?\/?>'
    # prefix for tags/categories files
    # please make sure that no other html file starts with this prefix
    prefix_tags="tag_"
    # personalized header and footer (only if you know what you're doing)
    # DO NOT name them .header.html, .footer.html or they will be overwritten
    # leave blank to generate them, recommended
    header_file=""
    footer_file=""
    # extra content to add just after we open the <body> tag
    # and before the actual blog content
    body_begin_file=""
    # extra content to add just before we cloese <body tag (just before
    # </body>)
    body_end_file=""
    # CSS files to include on every page, f.ex. css_include=('main.css' 'blog.css')
    # leave empty to use generated
    # TODO: Dash have no support for arrays. Get rid of it!
    css_include=""
    # HTML files to exclude from index, f.ex. post_exclude=('imprint.html 'aboutme.html')
    # TODO: Dash have no support for arrays. Get rid of it!
    html_exclude=""

    # Localization and i18n
    # "Read more..." (link under cut article on index page)
    template_read_more="read more..."
    # "View more posts" (used on bottom of index page as link to archive)
    template_archive="archive"
    # "All posts" (title of archive page)
    template_archive_title="all posts"
    # "All tags"
    template_tags_title="all tags"
    # "posts" (on "All tags" page, text at the end of each tag line, like "2. Music - 15 posts")
    template_tags_posts="posts"
    template_tags_posts_2_4="posts" # Some slavic languages use a different plural form for 2-4 items
    template_tags_posts_singular="post"
    # "Posts tagged" (text on a title of a page with index of one tag, like "My Blog - Posts tagged "Music"")
    template_tag_title="posts tagged"
    # "Tags:" (beginning of line in HTML file with list of all tags for this article)
    template_tags_line_header="tags:"
    # "Back to the index page" (used on archive page, it is link to blog index)
    template_archive_index_page="back home"
    # "Subscribe" (used on bottom of index page, it is link to RSS feed)
    template_subscribe="rss"
    # "Subscribe to this page..." (used as text for browser feed button that is embedded to html)
    template_subscribe_browser_button="subscribe to this page..."
   
    # The locale to use for the dates displayed on screen
    date_format="%B %d, %Y"
    date_locale="C"
    date_inpost="bashblog_timestamp"
    # Don't change these dates
    date_format_full="%a, %d %b %Y %H:%M:%S %z"
    date_format_timestamp="%Y%m%d%H%M.%S"
    date_allposts_header="%B %Y"

    # URL where you can view the post while it's being edited
    # same as global_url by default
    # You can change it to path on your computer, if you write posts locally
    # before copying them to the server
    preview_url=""

    # Markdown location. Trying to autodetect by default.
    # The invocation must support the signature 'markdown_bin in.md > out.html'
    # shellcheck disable=SC2016
    md2html_bin='awk "$md2html_awk"'
    # shellcheck disable=SC2016
    md2gemini_bin='awk "$md2gemini_awk"'
    # shellcheck disable=SC2016
    md2gopher_bin='awk "$md2gopher_awk"'
}

# Check for the validity of some variables
# No variables check at the moment
global_variables_check() {
    true
}
