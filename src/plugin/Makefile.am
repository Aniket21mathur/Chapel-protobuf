# Build protoc-gen-chpl executable
bin_PROGRAMS = protoc-gen-chpl
protoc_gen_chpl_SOURCES = \
	generator.cpp \
	protoc-gen-chpl.cpp \
	helpers.cpp \
	reflection_class.cpp\
	primitive_field.cpp\
	repeated_primitive_field.cpp\
	message.cpp\
	field_base.cpp\
	enum.cpp\
	enum_field.cpp\
	repeated_enum_field.cpp
protoc_gen_chpl_CPPFLAGS = \
	-I.
protoc_gen_chpl_LDADD = -lprotobuf -lprotoc
