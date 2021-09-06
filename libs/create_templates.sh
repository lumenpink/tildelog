#!/bin/sh
# generate headers, footers, etc
export global_header_file
export global_description
export global_url
export global_title
export global_index_file
export global_feedburner
export global_header_file
export global_footer_file
export global_css_include
export global_blog_feed
export global_email
export global_license
export global_author
export global_author_url
export template_subscribe_browser_button
export global_cache_dir
export global_data_dir
create_includes() {
	{
		echo "<h1 class=\"nomargin\"><a class=\"ablack\" href=\"$global_url/$global_index_file\">$global_title</a></h1>" 
		echo "<div id=\"description\">$global_description</div>"
	} > "$global_cache_dir/.title.html"

	if [ -f "$global_header_file" ]; then cp "$global_header_file" "$global_cache_dir/.header.html"
	else {
		echo '<!DOCTYPE html>'
		echo '<html lang="en"><head>'
		echo '<meta charset="UTF-8">'
		echo '<meta name="viewport" content="width=device-width, initial-scale=1.0">'
        if [ "x${global_css_include}" != 'x' ]; then
		    echo "${global_css_include}" | xargs -n1 printf '<link rel="stylesheet" href="%s" type="text/css">\n' 
        fi
		if [ -z "$global_feedburner" ]; then
			echo "<link rel=\"alternate\" type=\"application/rss+xml\" title=\"$template_subscribe_browser_button\" href=\"$global_blog_feed\">"
		else 
			echo "<link rel=\"alternate\" type=\"application/rss+xml\" title=\"$template_subscribe_browser_button\" href=\"$global_feedburner\">"
		fi
		} > "$global_cache_dir/.header.html"
	fi

	if [ -f "$global_footer_file" ]; then cp "$global_footer_file" "$global_cache_dir/.footer.html"
	else {
		protected_mail=$( echo "$global_email" | sed -e 's/@/\&#64;/g' -e 's/\./\&#46;/g' )		
		echo "<div id=\"footer\">$global_license <a href=\"$global_author_url\">$global_author</a> &mdash; <a href=\"mailto:$protected_mail\">$protected_mail</a><br>"
		echo 'generated with <a href="https://tildegit.org/team/bashblog">bashblog</a>, a single bash script to easily create blogs like this one</div>'
		} > "$global_cache_dir/.footer.html"
	fi
}

# Delete the temporarily generated include files
delete_includes() {
	rm "$global_cache_dir/.title.html" "$global_cache_dir/.footer.html" "$global_cache_dir/.header.html"
}

# Create the css file from scratch
create_css() {
	# To avoid overwriting manual changes. However it is recommended that
	# this function is modified if the user changes the blog.css file
	if [ "x${global_css_include}" = "x" ] ; then
        global_css_include='main.css'
		echo '#title{font-size: x-large;}
		a.ablack{color:black !important;}
		li{margin-bottom:8px;}
		ul,ol{margin-left:24px;margin-right:24px;}
		#all_posts{margin-top:24px;text-align:center;}
		.subtitle{font-size:small;margin:12px 0px;}
		.content p{margin-left:24px;margin-right:24px;}
		h1{margin-bottom:12px !important;}
		#description{font-size:large;margin-bottom:12px;}
		h3{margin-top:42px;margin-bottom:8px;}
		h4{margin-left:24px;margin-right:24px;}
		img{max-width:100%;}
		#twitter{line-height:20px;vertical-align:top;text-align:right;font-style:italic;color:#333;margin-top:24px;font-size:14px;}
		body{font-family:Georgia,"Times New Roman",Times,serif;margin:0;padding:0;background-color:#F3F3F3;}
		#divbodyholder{padding:5px;background-color:#DDD;width:100%;max-width:874px;margin:24px auto;}
		#divbody{border:solid 1px #ccc;background-color:#fff;padding:0px 48px 24px 48px;top:0;}
		.headerholder{background-color:#f9f9f9;border-top:solid 1px #ccc;border-left:solid 1px #ccc;border-right:solid 1px #ccc;}
		.header{width:100%;max-width:800px;margin:0px auto;padding-top:24px;padding-bottom:8px;}
		.content{margin-bottom:5%;}
		.nomargin{margin:0;}
		.description{margin-top:10px;border-top:solid 1px #666;padding:10px 0;}
		h3{font-size:20pt;width:100%;font-weight:bold;margin-top:32px;margin-bottom:0;}
		.clear{clear:both;}
		#footer{padding-top:10px;border-top:solid 1px #666;color:#333333;text-align:center;font-size:small;font-family:"Courier New","Courier",monospace;}
		a{text-decoration:none;color:#003366 !important;}
		a:visited{text-decoration:none;color:#336699 !important;}
		blockquote{background-color:#f9f9f9;border-left:solid 4px #e9e9e9;margin-left:12px;padding:12px 12px 12px 24px;}
		blockquote img{margin:12px 0px;}
		blockquote iframe{margin:12px 0px;}' > "$global_cache_dir/main.css"
    fi
}
