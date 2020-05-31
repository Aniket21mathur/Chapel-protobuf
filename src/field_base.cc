#include <cmath>
#include <limits>
#include <sstream>

#include <google/protobuf/compiler/code_generator.h>
#include <google/protobuf/descriptor.h>
#include <google/protobuf/descriptor.pb.h>
#include <google/protobuf/io/coded_stream.h>
#include <google/protobuf/io/printer.h>
#include <google/protobuf/io/zero_copy_stream.h>
#include <google/protobuf/stubs/strutil.h>
#include <google/protobuf/wire_format.h>

#include <field_base.hh>
#include <helpers.hh>

namespace chapel {
  
  using namespace std;

  void FieldGeneratorBase::SetCommonFieldVariables(
      map<string, string>* variables) {

    (*variables)["property_name"] = property_name();
    (*variables)["type_name"] = type_name(descriptor_);
    (*variables)["name"] = name();
    (*variables)["descriptor_name"] = descriptor_->name();
    (*variables)["default_value"] = default_value(descriptor_);
    (*variables)["number"] = number();
  }

  FieldGeneratorBase::FieldGeneratorBase(const FieldDescriptor* descriptor)
      : descriptor_(descriptor) {
    SetCommonFieldVariables(&variables_);
  }

  FieldGeneratorBase::~FieldGeneratorBase() {
  }

  string FieldGeneratorBase::property_name() {
    return GetPropertyName(descriptor_);
  }

  string FieldGeneratorBase::name() {
    return UnderscoresToCamelCase(GetFieldName(descriptor_));
  }

  string FieldGeneratorBase::type_name(const FieldDescriptor* descriptor) {
    switch (descriptor->type()) {
      case FieldDescriptor::TYPE_INT64:
        return "int(64)";
      case FieldDescriptor::TYPE_INT32:
        return "int(32)";
      default:
        GOOGLE_LOG(FATAL)<< "Unknown field type.";
        return "";
    }
  }

  string FieldGeneratorBase::default_value(const FieldDescriptor* descriptor) {
    switch (descriptor->type()) {
      case FieldDescriptor::TYPE_INT64:
        return StrCat(descriptor->default_value_int64());
      case FieldDescriptor::TYPE_INT32:
        return StrCat(descriptor->default_value_int32());
      default:
        GOOGLE_LOG(FATAL)<< "Unknown field type.";
        return "";
    }
  }

  string FieldGeneratorBase::number() {
    return StrCat(descriptor_->number());
  }

}  // namespace chapel
