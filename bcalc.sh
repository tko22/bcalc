#!/usr/bin/env sh

version="0.1.0"

usage() {
  cat <<EOF

  Usage: bcalc [number]

  Options:
    -V, --version    Output version
    -h, --help       This message.

EOF
}

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do
  case $1 in
    -V | --version )
      echo $version
      exit
      ;;
    -h | --help )
      usage
      exit
      ;;
  esac
  shift
done

# get arguments
args="$@"

# check if only 1 arg was passed
if (( $# != 1 ))
then
  usage
  exit 1
fi

# check if it's a hex number
if [[ ${args:0:2} = "0x" ]];
then
  # hex
  conversion="decimal"
  num=$(echo "${args#*x }" | cut -d "x" -f2)  # parse "0x"
  convert=$(bc <<< "ibase=16;$num")
  
else
  conversion="hex"
  convert=$(bc <<< "obase=16;$args")
fi
echo ""
echo "\033[90m … Converting $args to $conversion. \033[39m"
echo "\033[96m ✓ $convert \033[39m"

