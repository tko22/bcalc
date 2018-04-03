#!/usr/bin/env sh

version="0.1.0"

usage() {
  cat <<EOF

  Convert hex <-> decimal numbers. Prefix "0x" and use Uppercase for a hex number or it won't work. 
    Ex: 0xA

  Usage: bcalc [number]

  Options:
    -V, --version    Show version.
    -h, --help       Show this screen.

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
hex_prefix="0x"
# check if it's a hex number
if [[ ${args:0:2} = $hex_prefix ]];
then
  # hex
  conversion_text="decimal"
  num=$(echo "${args#*x }" | cut -d "x" -f2)  # parse "0x"
  convert=$(bc <<< "ibase=16;$num")
else
  conversion_text="hex"
  convert=$hex_prefix
  convert+=$(bc <<< "obase=16;$args");
  
  
fi
echo ""
echo "\033[90m … Converting $args to $conversion_text \033[39m"
echo "\033[96m ✓ $convert \033[39m"

