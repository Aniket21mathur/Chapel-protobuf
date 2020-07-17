#include <reflection_class.hh>
#include <message.hh>
#include <helpers.hh>
#include <enum.hh>

namespace chapel {

  ReflectionClassGenerator::ReflectionClassGenerator(const FileDescriptor* file)
      : file_(file) {
    module_name = GetModuleName(file);
  }

  ReflectionClassGenerator::~ReflectionClassGenerator() {
  }

  void ReflectionClassGenerator::Generate(Printer* printer) {
    WriteIntroduction(printer);

    printer->Print("module $module_name$ {\n", "module_name", module_name);
    printer->Print("\n");
    printer->Indent();

    printer->Print(
      "use Fields;\n"
      "use RepeatedFields;\n"
      "use WireEncoding;\n"
      "use List;\n");
    printer->Print("\n");
    
    // write children: Enums
    if (file_->enum_type_count() > 0) {
      printer->Print("// Enums\n");
      for (int i = 0; i < file_->enum_type_count(); i++) {
        EnumGenerator enumGenerator(file_->enum_type(i));
        enumGenerator.Generate(printer);
      }
      printer->Print("\n");
    }

    // write children: Messages
    if (file_->message_type_count() > 0) {
      printer->Print("// Messages\n");
      for (int i = 0; i < file_->message_type_count(); i++) {
        MessageGenerator messageGenerator(file_->message_type(i));
        messageGenerator.Generate(printer);
        printer->Print("\n");
      }
    }

    printer->Outdent();
    printer->Print("}\n");

  }

  void ReflectionClassGenerator::WriteIntroduction(Printer* printer) {
    printer->Print(
      "/*\n"
      "   Generated by the protocol buffer compiler.  DO NOT EDIT!\n"
      "   source: $file_name$\n"
      "*/\n"
      "\n",
      "file_name", file_->name());
  }

}  // namespace chapel
