#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <url> <extension(s)>"
    exit 1
fi

url="$1"
extensions="$2"

# Convert the comma-separated list of extensions to a regular expression that matches
# any of the extensions. For example, "pdf,docx" becomes "\.(pdf|docx)"
regex="\.\($(echo "$extensions" | sed 's/,/|/g')\)"

# Download the specified URL to a temporary file
wget -q -O /tmp/temp.html "$url"

# Find all URLs with the specified extensions and write them to a text file
# Use grep with a Perl regular expression to find all occurrences of the specified
# file extensions in the HTML source code. The -o option tells grep to only output
# the matching part of the line (i.e. the URL). The regular expression looks for
# any string that starts with href=", contains any number of characters that are
# not a double quote, ends with any of the specified file extensions, and ends with a
# closing double quote. The resulting list of URLs is then piped to sed.
grep -oP "(?<=href=\")[^\"]*$regex(?=\")" /tmp/temp.html |

# Use sed to modify the URLs as necessary. The first sed command replaces any
# relative URLs (starting with //) with an absolute URL using https://. The second
# sed command replaces any relative URLs (starting with /) with an absolute URL
# based on the original URL passed as the first argument. The resulting list of
# modified URLs is then written to a text file.
sed "s#^//#http://#" | sed "s#^/#$url/#" > urls.txt

# Clean up the temporary file
rm /tmp/temp.html
