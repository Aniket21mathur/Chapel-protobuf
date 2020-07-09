#ifndef PB_HELPERS_HH
#define PB_HELPERS_HH

#include <string>

#include <google/protobuf/descriptor.h>
#include <google/protobuf/compiler/code_generator.h>

namespace chapel {
  
  using namespace std;
  
  using namespace google::protobuf;
  using namespace google::protobuf::compiler;

  class FieldGeneratorBase;
  
  string UnderscoresToCamelCase(const string& input);

  string GetOutputFile(const FileDescriptor* descriptor, string*error);
  
  string GetFieldName(const FieldDescriptor* descriptor);

  string GetPropertyName(const FieldDescriptor* descriptor);

  FieldGeneratorBase* CreateFieldGenerator(const FieldDescriptor* descriptor);

  string GetPackageName(const FileDescriptor* descriptor);

  string GetFileNameBase(const FileDescriptor* descriptor);

} // namespace chapel

#endif /* PB_HELPERS_HH */
