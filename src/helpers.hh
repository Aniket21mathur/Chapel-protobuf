#ifndef PB_HELPERS_HH
#define PB_HELPERS_HH

#include <string>

#include <google/protobuf/descriptor.h>
#include <google/protobuf/stubs/strutil.h>

namespace chapel {
  
  using namespace std;
  
  using namespace google::protobuf;
  
  string StripDotProto(const string& proto_file);
  
  string UnderscoresToCamelCase(const string& input);

  string GetOutputFile(const FileDescriptor* descriptor, string*error);
  
} // namespace chapel

#endif /* PB_HELPERS_HH */
