[![ShellSpec](https://github.com/Lohn/tildelog/actions/workflows/ubuntu-focal.yml/badge.svg)](https://github.com/Lohn/tildelog/actions/workflows/ubuntu-focal.yml)
[![Code Coverage](https://codecov.io/gh/Lohn/tildelog/branch/main/graph/badge.svg?token=0I58TLFI96)](https://codecov.io/gh/Lohn/tildelog)

# Tildelog 
## A not-so-simple blog/gemlog/phlog Static Site Generator made in Shell



This is the source for the Tildelog. 
A script to quickly create contents for a HTML blog, a Gemini Capsule and a Gopher Hole based
with almost any effort or configuration.

## WARNING

This script is in early development stage. 
Everything can be changed quickly and things can break soon.

## Usage

`tildelog` will show the available commands.

**Before creating your first post, you may want to configure the blog settings (title, author, etc).
Read the Configuration section below for more information**

To create your first post, just run:

    tildelog post
    
It will use Markdown.
    
The script will handle the rest.

When you're done, access the public URL for that folder (`https://host/~username/blog`) 
and you should see the index file and a new page for that post!


## Features

- Ultra simple usage: Just type a post with your favorite editor and the script does the rest. No templating.
- No installation required. Download `tildelog.sh` and start blogging.
- Zero dependencies. It runs just on base utils (`date`, `basename`, `grep`, `sed`, `head`, etc)
- GNU/Linux, BSD and OSX compatible out of the box, no need for GNU `coreutils` on a Mac.
  It does some magic to autodetect which command switches it needs to run depending on your system.
- All content is static. You only need shell access to a machine with a public web folder.
  *Tip: advanced users could mount a remote public folder via `ftpfs` and run this script locally*
- Allows drafts, includes a simple but clean stylesheet, generates the RSS file automatically.
- Support for tags/categories
- Support for Markdown
- Generates small and fast pages with less than 10K each.
- The script is now exclusive to bash, but future versions may be compatible with any POSIX compliant shell.
