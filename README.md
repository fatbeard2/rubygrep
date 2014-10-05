# Rubygrep

Searches for regexp in files and print out strings that match.

## Installation

    $ gem install rubygrep

## Usage

Usage: rubygrep [options] expression file1 [file2 file3 ...]

    -r, --recursive         recursively read directories

    -i, --ignore-case       Ignore case when matching strings.

    -v, --invert-selection  Invert the sense of matching, to select non-matching lines.

    -n, --line-number       Prefix each line of output with the 1-based line number within its input file.

    -H, --with-filename     Print the file name for each match. This is the default when there is more than one file to search.



## Contributing

1. Fork it ( http://github.com/<my-github-username>/rubygrep/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
