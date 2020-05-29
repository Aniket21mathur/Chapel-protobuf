# Sometimes autoreconf doesn't create m4 directory, so do it explicitly
mkdir m4 > /dev/null 2>&1

# 1st pass: generate relevant files
command -v autoreconf > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "autogen.sh: error: could not find autoreconf." 1>&2
  echo "autoconf is required to run autogen.sh." 1>&2
  exit 1
fi

# Generate Makefile.in from Makefile.am
command -v automake --add-missing > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "autogen.sh: error: could not find automake." 1>&2
  echo "automake is required to run autogen.sh." 1>&2
  exit 1
fi

# Generate files to build shared libraries
command -v libtoolize > /dev/null 2>&1
if  [ $? -ne 0 ]; then
  echo "autogen.sh: error: could not find libtool." 1>&2
  echo "libtool is required to run autogen.sh." 1>&2
  exit 1
fi

# 2nd pass: generate configure script
autoreconf --install --force --verbose
if [ $? -ne 0 ]; then
  echo "autogen.sh: error: autoreconf exited with status $?" 1>&2
  exit 1
fi
