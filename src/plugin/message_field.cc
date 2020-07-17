#include <message_field.hh>

namespace chapel {

  MessageFieldGenerator::MessageFieldGenerator(const FieldDescriptor* descriptor)
      : FieldGeneratorBase(descriptor) {
  }

  MessageFieldGenerator::~MessageFieldGenerator() {
  }

  void MessageFieldGenerator::GenerateMembers(Printer* printer) {
    printer->Print(
      variables_,
      "var $property_name$: $type_name$;\n"
      "proc $name$ { return $property_name$; }\n"
      "proc ref $name$ ref { return $property_name$; }\n"
    );
  }

}  // namespace chapel
