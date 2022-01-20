+++
title = "Decoding the FAST Protocol: Examples"
date = 2022-01-12

[taxonomies]
tags = ["finance", "binary", "protocol", "fix", "fast", "examples"]

[extra.changelog]
2022-01-12 = "First release"
+++

After the whole explanation about the definition of the FAST protocol, I
noticed there was something missing: Examples, to make things easier to
understand.

<!-- more -->

{% note() %}
Same disclaimer as before: Because this is based on my personal experience,
some things may be out of place. I tried my best to keep things correctly, but
I may have misunderstood something, or maybe I just typed the value wrong here.

Also, if I find any other interesting examples, I'll add them here.
{% end %}

# Simple Hello World

This example is basically the same one in
[JetTek](https://jettekfix.com/education/fix-fast-tutorial/) but it is really
simple to explain, so here we go:

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
ID. Being an unsigned integer (and probably mandatory, but don't ask me how
that works) and dropping high order bit, we get the Integer "1", which is the
exactly same ID we have in the template; now we know which fields should be
processed.

The first field in the template is a string with a default value. Because the
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
that's the end of string. Converting the bytes using the ASCII table, we get
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
          <increment/>
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
1100_0000   1000_0010   1000_0011   0000_0011
0010_0011   0001_1000   1110_0111   1000_0010
1100_0000   0101_0101   0111_0011   0110_0101
0111_0010   1011_0001   1000_0100   1000_0000
0101_0101   0111_0011   0110_0101   0111_0010   
1011_0010   1111_1111   1000_0001   1100_0000
0101_0101   1011_0001   1111_1111   0000_1000 
1000_0000   1000_0010   1100_0000   1100_1001
1011_0110   1000_0000   0100_1101   1110_0101
```

## Processing

As mentioned before, the first byte, `1100_0000` is the Presence Map of the
root element. There is only one bit set, which means the Template ID is
present.

Because the Template ID is present in the Presence Map, we read the next byte,
`1000_0010`. Because this byte have the stop bit, we stop reading. Removing
this stop bit gives us `000_0010`, which is "2", so we know we are dealing with
the "SequenceOfSequences" template.

Now that we have the template and know the fields, we know what to read. The
first field in our template is a sequence. The first thing we have in the
sequence (and this is the first thing for *every* sequence) is the length of
it. So we read the next byte, `1000_0011`, which is the only byte we need to
read. It represents an unsigned int, which is "3", so this sequence have 3
records -- and using our description in the previous sections, we know now
that we have 3 user groups.

One point here: Because all fields in this sequence don't have any operators,
the Presence Map is not necessary and, thus, it doesn't exist (or, better yet,
we shouldn't try to read something and assume it is a Presence Map). For
sequences, every start of a new record contains a Presence Map only if at least
one of the fields in the sequence require a Presence Map. That's not the case
here.

Because there is no Presence Map for the "OuterSequence", the next bytes are
the "GroupID" field. We should read everything till we find the stop bit, so we
get `0000_0011`, `0010_0011`, `0001_1000` and `1110_0111`. For every byte we
remove the high order bit and then join everything into a single thing, in this
case `000_0011 010_0011 001_1000 110_0111` or simply
`0000_0110_1000_1100_1100_0110_0111`. This value, being an unsigned int, is
"6868070". 

{% note() %}
Here is a good point to remind that, because the field is mandatory, it means
that's actually the value of "GroupID"; if the field as optional, the actual
value would be "6868069".
{% end %}

Now for he "InnerSequence" field. The first step is to gather the number of
elements (the length of the sequence). That's the `1000_0010` byte, which is
"2". So there are two users in this group.

Because "InnerSequence" has a field that needs the Presence Map ("ID" uses the
Increment operator, that we need either read the incoming value for it or we
should just increment the previous value), the first thing after the length is
the Presence Map for this record. The byte `1100_0000` indicates that the first
field that requires a Presence Map is present.

But that's not the time to use the Presence Map yet. The field after the length
is the "Username", which is a mandatory string. Mandatory strings with no
operators are always present and we don't need to check the map. Same as we did
with "String" in the example for Hello World, we read the bytes till the stop
bit, but don't merge them: `0101_0101` (85), `0111_0011` (115), `0110_0101`
(101), `0111_0010` (114) and `1011_0001` (49, if we remove the stop bit, that
is), which converted by the ASCII table gives us "User1".

Now it is the time to use the Presence Map, since we are reading the "ID" field
and it has an operator that requires the Presence Map. The Presence Map we read
before was `100_0000` (with the stop bit removed), so yeah, the "ID" is present
in the incoming data. We read the next byte, `1000_0100`, which is "4". But
there is a gotcha here: The field is optional. So although we read "4", the
actual value is "3" -- if the value read was "0" it meant that the ID is Null.

Good. We just finished reading the first record of "InnerSequence": The user
"User1" has ID "3" and belongs to group "6868070". Now we read the second
record.

We don't need to read the length again, but we need to read the Presence Map
for this record. It is the byte `1000_0000`, a Presence Map indicating that
none of the fields with operators are present. But, again, it is not the time
for the Presence Map, 'cause we have to read "Username". The bytes for the
field are `0101_0101` (85), `0111_0011` (115), `0110_0101` (101), `0111_0010`
(114) and `1011_0001` (50), which is "User2".

This second record have an empty presence map (`1000_0000`) meaning that the ID
is not present in the incoming data. Because the field has the Increment
operator, we should use the previous value -- 3 -- and increment by 1. So
"User2" have the ID 4.

That ends the "InnerSequence" for the first record of "OuterSequence". Going
faster now:

- `1111_1111`: The second "GroupID" (only one byte due the stop bit), which is
  "127".
- `1000_0001`: The length of "InnerSequence"; it is just 1 element.
- `1100_0000`: The presence map for the first record of "InnerSequence"; it
  means the "ID" is present.
- `0101_0101`, `1011_0001`: The username. "U1".
- `1111_1111`: The "ID" for user "U1" is 126 (it reads as 127, but because the
  field is optional, we decrement the value by 1).
- `0000_1000`, `1000_0000`: The third "GroupID". Removing the stop bits and
  joining the bits we have `0000_1000 0000_0000` which is 2048.
- `1000_0010`: Length of the "InnerSequence" in the 3rd group; 2 elements.
- `1100_0000`: Presence Map of the first record of "InnerSequence"; ID is
  present.
- `1100_1001`: Username. "I".
- `1011_0110`: The "ID" for user "I". 53.
- `1000_0000`: Presence Map for the second record of "InnerSequence"; ID is not
  present.
- `0100_1101`, `1110_0101`: Username. "Me".
- Not reading any bytes now 'cause the Presence Map pointed that the "ID" is
  not present, but because the previous value for this field was 53, the ID for
  username "Me" is 54. Since this is the last element of "InnerSequence", that
  sequence is complete; also, this is the last element of "OuterSequence", so
  everything is done.
