# file_url_scrape.sh
This is a Bash script that downloads a webpage from a specified URL and extracts all the hyperlinks with a given extension(s) from the HTML source code of that page. It then modifies those links and saves them into a text file named urls.txt.

The script expects two arguments to be passed to it on the command line: the first argument is the `URL` of the webpage to be downloaded, and the second argument is a `comma-separated list` of file extensions to be extracted from the hyperlinks.

If the number of arguments is not exactly 2, the script will display a usage message and exit with an error code.

The script uses the `wget` command to download the webpage and save it to a temporary file named `/tmp/temp.html`. It then uses the `grep` command with a `Perl regular expression` to search for all occurrences of the specified file extensions in the HTML source code, and outputs the matching parts of the lines (i.e., the URLs) to `stdout`.

The script then uses the `sed` command to modify the URLs as necessary. It replaces any relative URLs (starting with `//`) with an absolute URL using `http://`, and replaces any relative URLs (starting with `/`) with an absolute URL based on the original URL passed as the first argument. The resulting list of modified URLs is then written to a text file named urls.txt.

Finally, the script cleans up the temporary file by deleting it.

## License

This script is released under the [MIT License](LICENSE).
