Chapel Protobuf
===============
This project is a Google Protocol Buffers implementation for Chapel.
`Protocol Buffers`_ is a language-neutral, platform-neutral, extensible mechanism
for serializing structured data. The protocol buffer language is a language for 
specifying the schema for structured data. This schema is compiled into language
specific bindings.

This project comprises of two components:

* Code generator: The `tool`_ is a compiler plugin to ``protoc``, the protocol
  buffer compiler. It arguments the ``protoc`` compiler so that it knows how to
  generate Chapel specific code for a given ``.proto`` file.
  
* Chapel library: The `Encoding`_ module have the runtime implementation of protobufs
  in Chapel and provides functionality to serialize messages in wire format.

Installation
------------
Chapel Protobuf is built using `Autotools`_. The code generator depends on the 
original Protocol Buffers library and is necessary to generate bindings from 
``.proto`` schema files. If the original library is not available, the generator
is not built. Use the `generate`_ shell script to build and install the Chapel
library and code generator.

``source ./generate.sh -p /desired/path/``

After Installation, the code generator can be used to generate bindings from 
``.proto`` schema files to get started.

Defining protocol format
------------------------
To make use of the Chapel protobuf implementation you need to start by defining
a ``.proto`` file. The definitions in a ``.proto`` file contain a message for each
data structure you want to serialize, then specify a name and a type for each 
field in the message. We will take an example of ``addressbook`` for a person.

The ``.proto`` file starts with an optional package declaration, helps to prevent
naming conflicts between different projects.

.. code-block:: proto

  syntax = "proto3";
  package addressbook;

In Chapel the generated records will be placed in a module matching the ``package``
name. If the ``package`` name is not specified the module takes the name of the
proto file.

Next, you have to define your messages. A message is just an aggregate containing
a set of typed fields. Many standard simple data types are available as field types,
including int64, int32, float, double, and string.

.. code-block:: proto

  message Person {
    string name = 1;
    int32 id = 2;  // Unique ID number for this person.
    string email = 3;
  }
  
In the above example the `Person` message contains 3 fields, ``string`` type ``name``,
``int32`` type ``id`` and ``string`` type ``email``. If a field is not set default value
is assigned to the field by Chapel.

Compiling your protocol buffers
-------------------------------

The code generator integrated with the protoc compiler toolchain
included in the default Protocol Buffers distribution. Use the ``protoc`` command
with the ``--chpl_out`` flag, to invoke the Chapel code generator and write the
output ``chpl`` file to a specific location.
location:

``protoc --chpl_out=$DST_DIR $SRC_DIR/addressbook.proto``

This generates ``addressbook.chpl`` in your specified directory.

The generated file
------------------

The generated ``addressbook.chpl`` file will contain:

* A wrapper module with the name ``addressbook``.
* A record with the name ``Person``.
* ``name_``, ``id_``, and ``email_`` field initializers.
* ``writeToOutputFile`` and ``parseFromInputFile`` functions for serialzation/parsing.

You can import this module to a ``chpl`` file and can create an instance of ``Person``
for populating data.

.. code-block:: chpl

  use addressbook;
  use IO;

  var messageObj = new Person();
  messageObj.name = "John";
  messageObj.id = 429496729;
  messageObj.email = "John@a.com";
  
Serialzation and parsing
------------------------
The whole purpose of using protocol buffers is to serialize your data so that it
can be parsed elsewhere. You can serialize your message object using the 
``IO`` module ``writeToOutputFile`` function.

.. code-block:: chpl
  
  var file = open("out", iomode.cw);
  var writingChannel = file.writer();

  messageObj.writeToOutputFile(writingChannel);
  
Parsing is also similar, each generated record has a ``parseFromInputFile``
function. So to parse the file we have just created we can use:

.. code-block:: chpl

  use addressbook;
  use IO;
  
  var file = open("out", iomode.r);
  var readingChannel = file.reader();
  
  var messageObj = new Person();
  messageObj.parseFromInputFile(readingChannel);


Features
--------
The following features are currently supported

#. Message definitions
#. All scalar types
#. Strings and bytes


.. _Protocol Buffers: https://developers.google.com/protocol-buffers
.. _tool: src/plugin/
.. _Encoding: src/Encoding.chpl
.. _Autotools: http://www.gnu.org/software/automake/manual/html_node/Autotools-Introduction.html
.. _generate: generate.sh
 