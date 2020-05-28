
#include <cassert>
#include <string>

#include <google/protobuf/compiler/code_generator.h>
#include <google/protobuf/descriptor.h>
#include <google/protobuf/io/printer.h>
#include <google/protobuf/io/zero_copy_stream.h>
#include <google/protobuf/stubs/common.h>

#include "generator.hh"

/* ----------------------------------------------------------------------------
 * Interface
 * ------------------------------------------------------------------------- */

namespace chapel {

  using ::std::string;
  using ::std::unique_ptr;

  using ::google::protobuf::compiler::CodeGenerator;
  using ::google::protobuf::compiler::GeneratorContext;
  using ::google::protobuf::FileDescriptor;
  using ::google::protobuf::io::Printer;
  using ::google::protobuf::io::ZeroCopyOutputStream;
  
  Generator::Generator() {}
  Generator::~Generator() {}

  bool Generator::
  Generate(
      const FileDescriptor *descriptor, const string &parameter,
      GeneratorContext *generator_context, string *error) const {
        
        string filename = "out.chpl";
        
        unique_ptr<io::ZeroCopyOutputStream> output(
          generator_context->Open(filename));
          Printer printer(output.get(), '$');
          
          printer->Print("Hello World");
        
    return true;
  }
}
