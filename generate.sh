# To install the binary in desired path
# source ./generate.sh -p /desired/path/
# To generate a chpl file from a proto file
# ./generate.sh -f /path/to/file/

while getopts ":f:p:" opt; do
  case $opt in
    f) protoFile="$OPTARG"
    ;;
    p) binPath="$OPTARG"
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
  
  buildPath=bin/
  fullPath="$binPath/$buildPath"
  export PATH=$PATH:"$fullPath" 
else
  protoc --chpl_out=. $protoFile
fi
