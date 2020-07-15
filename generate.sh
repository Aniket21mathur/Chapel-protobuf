# To install the binary in desired path
# Set the -n arg if desired path already set in $PATH
# source ./generate.sh -p /desired/path/ -n 1
# To generate a chpl file from a proto file
# ./generate.sh -f /path/to/file/

export CHPL_MODULE_PATH=$PWD/src

while getopts ":f:p:n:" opt; do
  case $opt in
    f) protoFile="$OPTARG"
    ;;
    p) pathToBin="$OPTARG"
    ;;
    n) flag="$OPTARG"
    ;;
    \?) echo "Invalid argument -$OPTARG" >&2
    ;;
  esac
done

if [ ! -z "$pathToBin" ]; then
  ./autogen.sh
  ./configure --prefix=$pathToBin
  make
  make install
  
  if [ -z "$flag" ]; then
    fullPath=$pathToBin/bin/
    export PATH=$PATH:$fullPath
  fi
else
  protoc --chpl_out=. $protoFile
fi
