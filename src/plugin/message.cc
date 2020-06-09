#include <sstream>
#include <algorithm>
#include <map>

#include <google/protobuf/compiler/code_generator.h>
#include <google/protobuf/descriptor.h>
#include <google/protobuf/descriptor.pb.h>
#include <google/protobuf/io/printer.h>
#include <google/protobuf/io/zero_copy_stream.h>
#include <google/protobuf/stubs/strutil.h>
#include <google/protobuf/wire_format.h>
#include <google/protobuf/wire_format_lite.h>

#include <helpers.hh>
#include <message.hh>
#include <field_base.hh>

namespace chapel {

  bool CompareFieldNumbers(const FieldDescriptor* d1, const FieldDescriptor* d2) {
    return d1->number() < d2->number();
  }

  MessageGenerator::MessageGenerator(const Descriptor* descriptor)
        : descriptor_(descriptor) {
  }

  MessageGenerator::~MessageGenerator() {
  }

  string MessageGenerator::record_name() {
    return descriptor_->name();
  }

  void MessageGenerator::Generate(Printer* printer) {
    map<string, string> vars;
    vars["record_name"] = record_name();

    printer->Print("var numValMap = new map(int, c_void_ptr);\n");
    printer->Print(vars, "record $record_name$ {\n");
    printer->Print("\n");
    printer->Indent();


    for (int i = 0; i < descriptor_->field_count(); i++) {
      const FieldDescriptor* fieldDescriptor = descriptor_->field(i);

      printer->Print(
        "// Field \"$field_name$\" \n",
        "field_name", fieldDescriptor->name());
      unique_ptr<FieldGeneratorBase> generator(
          CreateFieldGeneratorInternal(fieldDescriptor));
      generator->GenerateMembers(printer);
      printer->Print("\n");
    }

    printer->Print(
      "proc serialize(): bytes {\n"
      "  if numValMap.isEmpty() then mapValues();\n"
      "  return messageDump(numValMap);\n"
      "}\n"
      "\n"
      "proc unserialize(x: bytes) {\n"
      "  if numValMap.isEmpty() then mapValues();\n"
      "  messageLoad(x, numValMap);\n"
      "}\n");

    printer->Print("\n");
    printer->Print("proc mapValues() {\n");
    printer->Indent();

    for (int i = 0; i < descriptor_->field_count(); i++) {
      const FieldDescriptor* fieldDescriptor = descriptor_->field(i);

      printer->Print(
        "numValMap.add($field_number$, c_ptrTo($field_name$));\n",
        "field_number", StrCat(fieldDescriptor->number()),
        "field_name", GetPropertyName(fieldDescriptor));
    }

    printer->Outdent();
    printer->Print("}\n");
    
    printer->Print("\n");
    printer->Outdent();
    printer->Print("}\n");
  }

  FieldGeneratorBase* MessageGenerator::CreateFieldGeneratorInternal(
      const FieldDescriptor* descriptor) {
    return CreateFieldGenerator(descriptor);
  }

}  // namespace chapel