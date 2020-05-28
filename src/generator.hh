#ifndef PB_GENERATOR_GENERATOR_HH
#define PB_GENERATOR_GENERATOR_HH

#include <string>

#include <google/protobuf/compiler/code_generator.h>
#include <google/protobuf/descriptor.h>
#include <google/protobuf/compiler/plugin.h>

namespace chapel {

  using ::std::string;

  using ::google::protobuf::compiler::CodeGenerator;
  using ::google::protobuf::compiler::GeneratorContext;
  using ::google::protobuf::FileDescriptor;

  class Generator : public CodeGenerator {

  public:
    Generator();
    ~Generator();
    bool Generate(
      const FileDescriptor
        *descriptor,                   
      const string &parameter,         
      GeneratorContext *generator_context,     
      string *error)
    const;
  };
}

#endif /* PB_GENERATOR_GENERATOR_HH */
