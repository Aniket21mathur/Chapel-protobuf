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
    map<int, map<string, string>> vars;

    for (int i = 0; i < descriptor_->field_count(); i++) {
      const FieldDescriptor* fieldDescriptor = descriptor_->field(i);
      FieldGeneratorBase* field_obj;
      
      vars[i]["field_name"] = GetPropertyName(fieldDescriptor);
      vars[i]["field_number"] = StrCat(fieldDescriptor->number());
      vars[i]["field_type"] = field_obj->type_name(fieldDescriptor);
    }
    
    printer->Print(
      "record $record_name$ {\n",
      "record_name", record_name());
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

    printer->Print("proc serialize(): bytes {\n");  
    printer->Indent();
    printer->Print("var s: bytes = b\"\";\n");  
      
    for (int i = 0; i < descriptor_->field_count(); i++) {
      printer->Print(vars[i],
        "messageFieldDump($field_name$, $field_number$, s);\n");
    }
    
    printer->Print("return s;\n");
    printer->Outdent();
    printer->Print("}\n");

    printer->Print("\n");
    printer->Print(
      "proc unserialize(ref s: bytes) {\n"
      "  while s.size > 0 {\n"
      "    var fieldNumber = getFieldNumber(s);\n"
      "    select fieldNumber {\n");
    printer->Indent();
    printer->Indent();
    printer->Indent();

    for (int i = 0; i < descriptor_->field_count(); i++) {
      printer->Print(vars[i],
        "when $field_number$ {\n"
        "  $field_name$ = messageFieldLoad(s, $field_name$.type);\n"
        "}\n");
    }

    printer->Outdent();
    printer->Print("}\n");
    printer->Outdent();
    printer->Print("}\n");
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
