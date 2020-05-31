#include <sstream>

#include <google/protobuf/compiler/code_generator.h>
#include <google/protobuf/descriptor.h>
#include <google/protobuf/descriptor.pb.h>
#include <google/protobuf/io/printer.h>
#include <google/protobuf/io/zero_copy_stream.h>
#include <google/protobuf/stubs/strutil.h>

#include <primitive_field.hh>

namespace chapel {

  PrimitiveFieldGenerator::PrimitiveFieldGenerator(const FieldDescriptor* descriptor)
      : FieldGeneratorBase(descriptor) {
  }

  PrimitiveFieldGenerator::~PrimitiveFieldGenerator() {
  }

  void PrimitiveFieldGenerator::GenerateMembers(Printer* printer) {

    printer->Print(
      variables_,
      "var $property_name$: $type_name$ ;\n"
      "proc $name$ { return $property_name$; }\n"
      "proc ref $name$ ref { return $property_name$; }\n");
        
  }

}  // namespace chapel
