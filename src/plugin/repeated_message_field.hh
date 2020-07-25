#ifndef PB_REPEATED_MESSAGE_FIELD_HH
#define PB_REPEATED_MESSAGE_FIELD_HH

#include <google/protobuf/io/printer.h>
#include <google/protobuf/descriptor.h>

#include <field_base.hh>

namespace chapel {
  
  using namespace google::protobuf;
  using namespace google::protobuf::io;
  
  class RepeatedMessageFieldGenerator : public FieldGeneratorBase {
   public:
    RepeatedMessageFieldGenerator(const FieldDescriptor* descriptor);
    ~RepeatedMessageFieldGenerator();

    void GenerateMembers(Printer* printer);
  };

}  // namespace chapel

#endif /* PB_REPEATED_MESSAGE_FIELD_HH */
