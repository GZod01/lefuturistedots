#!/bin/sh

# meant to be POSIX compliant

full_usage() {
    echo "Usage: around [OPTION]... [FILE] LINE_NUMBER"
    echo "Output lines adjacents to one particular line in a file"
    echo ""

    echo "Options:"
    echo "  -n, --neighbours   change the number of neighbours/adjacents line to output"
    echo "  -h, --help         display this help and exit"

    echo ""

    echo "Require awk, sed to work"
    exit
}
usage_error () { echo >&2 "$(basename $0):  $1"; exit 2; }
assert_argument () { test "$1" != "$EOL" || usage_error "$2 requires an argument"; }

nb_neighbours=2

# thanks to https://stackoverflow.com/a/62616466/7100565
if [ "$#" != 0 ]; then
  EOL=$(printf '\1\3\3\7')
  set -- "$@" "$EOL"
  while [ "$1" != "$EOL" ]; do
    opt="$1"; shift
    case "$opt" in

      -l|--line-number) assert_argument "$1" "$opt"; line_number="$1"; shift;;
      -h|--help) full_usage; shift;;
      -n|--neighbours) assert_argument "$1" "$opt"; nb_neighbours="$1"; shift;;

      # Arguments processing. You may remove any unneeded line after the 1st.
      -|''|[!-]*) set -- "$@" "$opt";;                                          # positional argument, rotate to the end
      --*=*)      set -- "${opt%%=*}" "${opt#*=}" "$@";;                        # convert '--name=arg' to '--name' 'arg'
      -[!-]?*)    set -- $(echo "${opt#-}" | sed 's/\(.\)/ -\1/g') "$@";;       # convert '-abc' to '-a' '-b' '-c'
      --)         while [ "$1" != "$EOL" ]; do set -- "$@" "$1"; shift; done;;  # process remaining arguments as positional
      -*)         usage_error "unknown option: '$opt'";;                        # catch misspelled options
      *)          usage_error "this should NEVER happen ($opt)";;               # sanity test for previous patterns

    esac
  done
  shift  # $EOL
fi

file=/dev/stdin

if [ $# -lt 1 ]
then
    usage_error "require at least one argument"
fi

if [ $# -ge 3 ]
then
    usage_error "too much arguments"
fi

if [ $# -eq 1 ]
then
    # consider that's the line number
    line_number=$1
fi

if [ $# -eq 2 ]
then
    # first argument is the line number and second is the file name
    file=$2
    line_number=$1
fi


cond="NR >= $line_number-$nb_neighbours && NR <= $line_number+$nb_neighbours"
awk "$cond" "$file" 

