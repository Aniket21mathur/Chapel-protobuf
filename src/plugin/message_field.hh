#ifndef PB_MESSAGE_FIELD_HH
#define PB_MESSAGE_FIELD_HH

#include <google/protobuf/io/printer.h>
#include <google/protobuf/descriptor.h>

#include <field_base.hh>

namespace chapel {
  
  using namespace google::protobuf;
  using namespace google::protobuf::io;
  
  class MessageFieldGenerator : public FieldGeneratorBase {
   public:
    MessageFieldGenerator(const FieldDescriptor* descriptor);
    ~MessageFieldGenerator();

    void GenerateMembers(Printer* printer);
  };

}  // namespace chapel

#endif /* PB_MESSAGE_FIELD_HH */
