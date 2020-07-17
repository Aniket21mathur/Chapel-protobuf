# Build protoc-gen-chpl executable
bin_PROGRAMS = protoc-gen-chpl
protoc_gen_chpl_SOURCES = \
	generator.cc \
	protoc-gen-chpl.cc \
	helpers.cc \
	reflection_class.cc\
	primitive_field.cc\
	repeated_primitive_field.cc\
	message.cc\
	field_base.cc\
	enum.cc\
	enum_field.cc\
	repeated_enum_field.cc\
	message_field.cc
protoc_gen_chpl_CPPFLAGS = \
	-I.
protoc_gen_chpl_LDADD = -lprotobuf -lprotoc
