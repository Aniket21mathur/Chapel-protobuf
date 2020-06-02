# To install the binary in desired path
# Set the -n arg if desired path already set in $PATH
# source ./generate.sh -p /desired/path/ -n 1
# To generate a chpl file from a proto file
# ./generate.sh -f /path/to/file/

while getopts ":f:p:n:" opt; do
  case $opt in
    f) protoFile="$OPTARG"
    ;;
    p) binPath="$OPTARG"
    ;;
    n) flag="$OPTARG"
    ;;
    \?) echo "Invalid argument -$OPTARG" >&2
    ;;
  esac
done

if [ ! -z "$binPath" ]; then
  ./autogen.sh
  ./configure --prefix=$binPath
  make
  make install
  
  if [ -z "$flag" ]; then
    buildPath=bin/
    fullPath="$binPath/$buildPath"
    export PATH=$PATH:"$fullPath"
  fi
else
  protoc --chpl_out=. $protoFile
fi
