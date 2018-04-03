#!/usr/bin/env sh

version="0.1.0"

usage() {
  cat <<EOF

  Usage: bcalc [number]

  Options:
    -V, --version    Output version
    -h, --help       This message.
    --               End of options

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

args="$@"

if [ "" == "$args" ]; then
  usage
  exit 1
fi

echo ""

echo "\033[90m … getting password for \"$args\". \033[39m"

