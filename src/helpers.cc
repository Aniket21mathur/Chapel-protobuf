#include <string>

#include <google/protobuf/stubs/strutil.h>

#include <helpers.hh>
#include <primitive_field.hh>
#include <field_base.hh>

namespace chapel {
  
  string StripDotProto(const std::string& proto_file) {
    int lastindex = proto_file.find_last_of(".");
    return proto_file.substr(0, lastindex);
  }
  
  string UnderscoresToCamelCase(const string& input) {
    string result;
    bool cap_next_letter = false;
    for (int i = 0; i < input.size(); i++) {
      if ('a' <= input[i] && input[i] <= 'z') {
        if (cap_next_letter) {
          result += input[i] + ('A' - 'a');
        } else {
          result += input[i];
        }
        cap_next_letter = false;
      } else if ('A' <= input[i] && input[i] <= 'Z') {
        if (cap_next_letter) {
          result += input[i];
        } else {
          result += input[i] + ('a' - 'A');
        }
        cap_next_letter = false;
      } else if ('0' <= input[i] && input[i] <= '9') {
        result += input[i];
        cap_next_letter = true;
      } else {
        cap_next_letter = true;
      }
    }
    return result;
  }
  
  string GetFileNameBase(const FileDescriptor* descriptor) {
      string proto_file = descriptor->name();
      int lastslash = proto_file.find_last_of("/");
      string base = proto_file.substr(lastslash + 1);
      return UnderscoresToCamelCase(StripDotProto(base));
  }

  string GetOutputFile(const FileDescriptor* descriptor, string* error) {
    string relative_filename = GetFileNameBase(descriptor);
    string file_extension = ".chpl";
    return relative_filename + file_extension;
  }
  
  string GetFieldName(const FieldDescriptor* descriptor) {
      return descriptor->name();
  }

  string GetPropertyName(const FieldDescriptor* descriptor) {
    string property_name = UnderscoresToCamelCase(GetFieldName(descriptor));
    property_name += "_";
    return property_name;
  }

  FieldGeneratorBase* CreateFieldGenerator(const FieldDescriptor* descriptor) {
    return new PrimitiveFieldGenerator(descriptor);
  }

} // namespace chapel
