#ifndef PB_PRIMITIVE_FIELD_HH
#define PB_PRIMITIVE_FIELD_HH

#include <string>

#include <google/protobuf/compiler/code_generator.h>

#include <field_base.hh>

namespace chapel {

  class PrimitiveFieldGenerator : public FieldGeneratorBase {
   public:
    PrimitiveFieldGenerator(const FieldDescriptor* descriptor);
    ~PrimitiveFieldGenerator();

    virtual void GenerateMembers(Printer* printer);
  };

}  // namespace chapel

#endif /* PB_PRIMITIVE_FIELD_HH */
