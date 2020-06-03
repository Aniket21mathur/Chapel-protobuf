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
      "var fieldNumber = $number$;\n"
      "proc $name$ { return $property_name$; }\n"
      "proc ref $name$ ref { return $property_name$; }\n"
      "\n"
      "proc serialize(): bytes {\n"
      "  return messageDump($property_name$, fieldNumber, 0);\n"
      "}\n"
      "\n"
      "proc unserialize(x: bytes) {\n"
      "  $property_name$ = messageLoad(x);\n"
      "}\n"
    );
  }

}  // namespace chapel
