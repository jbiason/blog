+++
title = "Decoding the FAST Protocol: Examples"
date = 2022-01-10
draft = true

[taxonomies]
tags = ["finance", "binary", "protocol", "fix", "fast", "examples"]
+++

After the whole explanation about the definition of the FAST protocol, I
noticed there was something missing: Examples, to make things easier to
understand.

<!-- more -->

# Simple Hello World

This example is basically the same one in
[JetTek](https://jettekfix.com/education/fix-fast-tutorial/) but it is really
simple, so here we go:

## Template

```xml
<?xml version="1.0" encoding="UTF-8"?>
<templates xmlns="http://www.fixprotocol.org/ns/fast/td/1.1">
  <template xmlns="http://www.fixprotocol.org/ns/fast/td/1.1" name="HelloWorld" id="1">
    <string name="String" id="1">
      <default value=""/>
    </string>
  </template>
</templates>
```

## Incoming Data

Bytes:

```
1110_0000   1000_0001   0100_1000   0110_0101
0110_1100   0110_1100   0100_1111   0101_0111
0110_1111   0111_0010   0110_1100   1110_0100
```

## Processing

The first byte is the Presence Map. Removing the stop bit, we get `110_0000`.
This Presence Map have one field that isn't described in the template: The
template ID. Because the first bit is set, we know the template ID is there.
Also, keep in mind that the Template ID is the only field we know it exists so
far; there is no information whatsoever about that second bit in the Presence
Map -- we need to find out which template should be used first.

The next byte is read: `1000_0001`. As mentioned above, this is the Template
ID. Being a signed integer (and probably mandatory, but don't ask me how that
works), we read the value, it has the stop bit, so that's the whole integer.
Dropping the high order bit, we get the Integer "1", which is the exactly same
ID we have in the template, so now we know which fields are here.

The first field in the template is the string with a default value. Because the
field uses the Default operator, we need to check if the value is in the data
or we should use the default value. The bit in the Presence Map for this field
is `1` meaning the value for the string is in the incoming data and we should
read it.

The field is string, so we keep reading every byte till we find one with the
stop bit. Also, being a string, we don't "merge" the values: each byte is a
letter in the ASCII table. The sequence is `100_1000` (72), `110_0101` (101),
`110_1100` (108), `110_1100` (108), `100_1111` (79), `101_0111` (87),
`110_1111` (79), `111_0010` (114), `110_1100` (108) and `110_0100` (100).
Notice that we consumed all the bytes, and the last one have the stop, so
that's the end of string. Converting the bytes using the ASCII string, we get
"HelloWorld".

So, there we have it: We received a record of the "HelloWorld" type, with the
field ID "1" (a.k.a. "String") with the value "HelloWorld".

# Sequences

Let's expand our example to have a sequence and a few more operators:

## Template

```xml
<?xml version="1.0" encoding="UTF-8"?>
<templates xmlns="http://www.fixprotocol.org/ns/fast/td/1.1">
  <template xmlns="http://www.fixprotocol.org/ns/fast/td/1.1" name="HelloWorld" id="1">
    <string name="String" id="1">
      <default value=""/>
    </string>
  </template>

  <template xmlns="http://www.fixprotocol.org/ns/fast/td/1.1" name="SequenceOfSequences" id="2">
    <sequence name="OuterSequence">
      <length name="NoOuterSequence" id="3"/>
      <uInt32 name="GroupID" id="2"/>
      <sequence name="InnerSequence">
        <length name="NoInnerSequence" id="25"/>
        <string name="Username" id="4"/>
        <uInt32 name="ID" id="32" presence="optional">
          <delta/>
        </uInt32>
      </sequence>
    </sequence>
  </template>
</templates>
```

Although FAST was defined to work with FIX and the financial market, there is
nothing stopping it from being used for other things. The new template actually
describe a group of users, so we have a list of groups and, for each group, a
list of users and their IDs.

## Incoming Data

```
1100_0000   1000_0010   
```

## Processing
