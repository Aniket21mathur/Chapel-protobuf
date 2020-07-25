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
      "var $name$: $type_name$;\n"
    );
  }

}  // namespace chapel
