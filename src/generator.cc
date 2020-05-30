
#include <cassert>
#include <string>

#include <google/protobuf/compiler/code_generator.h>
#include <google/protobuf/descriptor.h>
#include <google/protobuf/io/printer.h>
#include <google/protobuf/io/zero_copy_stream.h>
#include <google/protobuf/stubs/common.h>

#include <generator.hh>
#include <helpers.hh>

namespace chapel {

  using namespace google::protobuf::io;

  Generator::Generator() {}
  Generator::~Generator() {}

  bool Generator::
  Generate(
      const FileDescriptor *descriptor, const string &parameter,
      GeneratorContext *generator_context, string *error) const {
        
        string filename_error = "";
        string filename = GetOutputFile(descriptor, &filename_error);

        unique_ptr< ZeroCopyOutputStream> output(
          generator_context->Open(filename));
          Printer printer(output.get(), '$');
          
          printer.Print("Hello World");
        
    return true;
  }
}
