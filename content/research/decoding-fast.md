+++
title = "Decoding the FAST Protocol"
date = 2022-01-10
updated = 2022-01-13

[taxonomies]
tags = ["finance", "binary", "protocol", "fix", "fast"]
+++

Recently I have to work with a FAST (FIX Adapted for Streaming) and because the
documentation is scattered around, I decided to put the things I discovered in a
single place for (my own) future reference.

<!-- more -->

{% note() %}
Because this is based on my personal experience and I had contact with a single
instance of this so far, there are some things that are incomplete and/or
wrong. I'll keep updating this post as I figure out new things.

The changelog is in the end of the post.
{% end %}

# What is FAST

[FAST](https://en.wikipedia.org/wiki/FAST_protocol) is, basically, a compression
method for the FIX protocol.

# And What is FIX?

[FIX](https://en.wikipedia.org/wiki/Financial_Information_eXchange) is a
protocol created for financial institutions to exchange information. Although
there is nothing "financially" related to it -- you could use the protocol for
anything, basically -- most financial companies use it.

FIX is a very simple protocol: You have pairs of "field ID" and "value"
separated by a "`=`" (equal sign) and the pairs are separated by the ASCII char
with code 1 (which is represented by `^A` in some editors). Some field IDs are
defined by the protocol (there is a whole list
[here](https://www.inforeachinc.com/fix-dictionary/index.html)) but each
exchange can create their own IDs.

For example, if you have the field MsgType (ID 35) with value "`y`" and the
field Security ID (ID 48) with value "`123456`", the message received would be

```
35=y^A48=123456
```

# And Back to FAST

One of the things FAST is designed for is removing duplicate and/or constant
content. For example, MsgType (ID 35) identifies that the message is
"SecurityList" (symbol list), which contains information about all the symbols
(the their security IDs) available in the exchange. Because the exchange is the
same in all the symbols, FAST allows defining the fields related to it (Source,
field ID 22, and Exchange, field ID 207) to constant values, so they don't need
to be transmitted and, when decoding FAST back to FIX, the decoder simply add
the constant value.

To know which fields are constant and which are not (and some other information),
the protocol defines a template, which have a well defined schema, to report
that information.

# The Template

The template is a XML file which describes the fields, their types, names, IDs
and operators. The protocol itself doesn't provide any default way to actually
receive that field, and thus is left for the exchange to find their way.

Note that the template describe the field IDs and their types, and the incoming
data have only the values. If we use the FIX description above, the template
defines the left side of the pair, while the incoming data have have only the
right side.

## Field Types

The protocol have a few field types: Unsigned Ints of 32 and 64 bits, Signed
Ints of 32 and 64 bits, ASCII strings, UTF-8 strings, sequences, decimals and a
special type called "Presence Map".

One thing to note is that all fields use a "stop bit" format. This is quite
similar to UTF8, although UTF8 uses a "continuation bit" instead of "stop bit",
but the process of reading is the same:

- Read a byte;
- Does it have the high order by set to 0?
  - Yes: Keep reading;
  - No: Stop reading the field value.

I'll show some examples later in this post.

## Field definitions

The template defines the fields with their type, name (optional), ID, a
presence indicator and an operator (optional).

For example, to describe an unsigned int of 32 bits, named "MsgType" with ID
"35", it would be described in the template as

```xml
<uInt32 name="MsgType" id="35"/>
```

Because there is no indication of presence, it is assumed that the field is
"mandatory" and should always have a value. On the other hand, if the field
definition was something like

```xml
<int32 name="ImpliedMarketIndicator" id="1144" presence="optional"/>
```

... then the field may not not have a value. This is also referred as "nullable"
field.

## Optional and Mandatory Fields

The difference between optional and mandatory fields is that mandatory fields
*always* have a value, even if 0. Optional fields, on the other hand, can be
null and have no value at all.

{% note() %}
I have the impression that this is done if the exchange wants to mark a field
as "do not appear in the FIX version"; so even if the field have a definition,
the resulting FIX version would not have the field.

So it is more of a "backwards compatibility" than anything else.
{% end %}

## Types

### Types: Ints

To read an Int, the decoder would pick the 7 low order bits (everything except
the high order one) and move them to the resulting variable. If the stop bit is
there, the read is complete; if it is not, the result should be shifted by 7
bits and add the 7 bits from the next byte and so on, till you find a byte with
the stop bit set.

The 32 and 64 bits only define the maximum value of the field and should not
necessarily be used as "number of bits to be read" -- because of the stop bit.
If the value exceeds 32 or 64 bits, that is considered an error and the
processing should be aborted.

Signed Int work exactly the same, but as 2's complement.

For example, if incoming data have the following bytes (in binary, to make it
easier to read; also, I added a single underscore between each 4 values, also
to make it easier to read):

```
0000_0001 1001_0010
```

... the decoder will read the first byte and see that it doesn't have the high
order bit set, so it keep just the "1" for the value and shift 7 bits to the
left. Then the second byte is read; this one have the high order bit set, so
the remaining bits (in this case "001_0010") are added to the resulting value
and get `1001_0010` -- or 146.

Negative numbers are represented using 2's so if the decoder receives, for
example:

```
0000_0011 0111_1110 1110_1110
```

... which, when the high order bits are removed, it should generate "`1111_1111
0110_1110`", which is -146 (in 16 bits, just to make it shorter).

When an integer field is optional, the result must be decremented by 1. The
reason is that it should be something to differentiate both 0 and Null. So, an
optional integer with value 0 is, actually, Null; to get the value 0 for the
field, the incoming data will have value 1, which is decremented in 1 and goes
back to 0.

In the template, the fields appear as

- `<uInt32/>`: Unsigned Int of 32 bits.
- `<uInt64/>`: Unsigned Int of 64 bits.
- `<int32/>`: Signed Int of 32 bits.
- `<int64/>`: Signed Int of 64 bits.

### Types: Strings

ASCII strings are pretty simple to read: Again, the decoder keeps reading the
incoming data till you find a byte with the high order bit set (again, the stop
bit) and just convert to their respective ASCII character.

For example

```
0100_1000 0110_0101 0110_1100 0110_1100 1110_1111
```

Would generate the bytes 72, 101, 108, 108 and 111, which using the ASCII table
would result in "Hello". Note that the stop bit here represents "end of string"
and the bytes should not be grouped like in Ints.

{% note() %}
So far, I didn't find any UTF8 strings, so I'm not quite sure how to process
them yet. Surely there is documentation around on how to read those, but since
this is my personal experience with the protocol, I decided to not mention it
here.
{% end %}

Optional strings are Null when the first byte have a stop bit set and every
other bit is zero.

In the template, a string field appears as `<string>`.

### Types: Sequences

Sequences are basically arrays. The first field of a sequence is the "length"
(with the type "`<length>`" in the template) with the number of records
present. Inside the sequence, you have a list of field definitions, which may
even include more sequences.

Optional sequences affect the way the length is read: If optional, the length
should be treated as an optional Integer and thus the size is decremented by 1.

In the template, the sequence appears as `<sequence>`, with the length
following it. An example is

```xml
<sequence name="Sequence">
  <length name="NoSequence" id="123"/>
</sequence>
```

{% note() %}
I describe most of the length fields with a name starting with "No". That's
because the FIX spec defines the lengths with that prefix.
{% end %}

### Types: Decimals

Decimals are formed by two fields: Exponent and Mantissa. The way it works is
that if you have an Exponent of "-2" and a Mantissa of "1020", the resulting
value is  `1020 * 10 ^ -2` ("1020 times 10 to the power of -2"), or "10.20".

Both Exponent and Mantissa are read as Signed Ints.

An Optional Decimal means the Exponent is optional. The documentation says that
the Mantissa is always mandatory, but there is a catch: If the Exponent is
null, then the Mantissa is not present and the whole Decimal is Null;
otherwise, the decoder is expected to read the Mantissa and the formula above
should be applied.

Also, because Exponent and Mantissa are two fields, they can have different
operators. I'll show some examples after the Operator, mostly because I've seen
both with different operators and they make a mess to read.

In the template, the decimal field appears as `<decimal>`, with the exponent
and mantissa as internal fields.

```xml
<decimal name="ADecimal" id="123">
  <exponent/>
  <mantissa/>
</decimal>
```

### Type: Presence Map

Presence Maps are used in conjunction with operators. They are read like
unsigned Ints are read (read bytes till you find the one with the high order
bit, remove the high order bits and put all the bits in sequence) but do not
have any conversion in themselves. Every time the decoder need to check if a
field is present in the presence map, the bit is consumed and the line
moves on.

Presence Maps are not present in the template and their presence is implied if
there is at least one field that requires it. For example, if all the fields in
a sequence are mandatory, there will be no Presence Map in the incoming data.

The bits in the Presence Map are in the order of the fields in the template.
For example, if a template with:

1. A mandatory field;
2. A field with an operator that requires the presence map (I'll mention those
   later);
3. Another mandatory field;
4. And, finally, another field with operator.

... it is possible to have a Presence Map as `1110_0000`, in which:

1. The first bit is the stop bit, so the decoder assumes this is the last byte
   of the presence map.
2. The second bit indicates that the first field with operator is present. It
   does *not* represent the mandatory field 'cause, well, it is mandatory and,
   thus, is always present.
3. The second bit indicates the second field with an operator is present.

(Again, I'll mention which operators require the presence map.)

## Operators

Operators define a way to deal with some fields. I've seen 5 different types of
operators:

- No Operator;
- Constant;
- Default;
- Copy;
- Delta;
- Increment.

### Operator: No Operator

When there is no operator defined in the field definition in the template, then
the operator is the "no operator" operator. It means there is no special way of
dealing with the incoming value.

When a field have No Operator, there will be no bit in the Presence Map.

All the previous examples of the template have no operator.

### Operator: Constant

A field with the Constant operator will not appear in the incoming data and the
decoder should assume that its value is the value in the constant. Previously I
mentioned that a list of securities may have the field 22, "Source", and field
207, "Exchange", with constant values, so they would be defined as

```xml
<string name="Source" id="22">
    <constant value="123"/>
</string>
<string name="Exchange" id="207">
    <constant value="EXCHANGE"/>
</string>
```

There is a catch, though: When a Constant field can be Null
(`presence="optional"`), then the decoder needs to use the Presence Map bit; if
it is set, the constant value should be used; if it is not set, then the field
value is Null.

The Presence Map should be use only if there is a field with a constant value
that is optional.

### Operator: Default

The Default operator is similar to the Constant operator, but if the bit for
the field is set in the Presence Map, then the value for the field should be
read in the incoming data; otherwise, the Default value should be used.

{% note() %}
In a way, you can read this: Is the value present in the incoming data
(indicated in the Presence Map)? Then read the value in the incoming data;
otherwise, use the default value.
{% end %}

Example

```xml
<uInt32 name="Type" id="3">
  <default value="1"/>
</uInt32>
```

### Operator: Copy

The copy operator indicates that the value for this record have the same value
of the previous record; if it is the first record, then the value should be
used. If the Presence Map bit is set for the field, then the decoder must read
the value in the incoming data; if it is not set, then the previous value should
be used. 

{% note() %}
In the data I saw, every first record have the bit set.
{% end %}

An example: You can have a template like

```xml
<string name="MDReqID" id="262">
    <copy/>
</string>
```

... and the incoming data had the following records and their Presence Maps:

1. The first record have the bit set for this field in the Presence Map and the
   strings reads "first". The result for this field in this record will be
   the value "first".
2. The second record doesn't have the bit set in the Presence Map. So the
   decoder reuses the previous value and this record will have the field with
   the value "first" (again).
3. The third record have the bit set again, and the value "second". This is the
   value for the field in this record.
4. The fourth record doesn't have the bit set and the decoder reuses the value
   "second" for the field.

The Copy operator may have the initial value. For example

```xml
<string name="MDReqID" id="262">
    <copy value="string"/>
</string>
```

This means that you should use "string" as previous value, even in the first
record.

As pointed, fields with the Copy operator appear in the Presence Map.

### Operator: Delta

Delta is an operator similar to Copy, but instead of using the value of the
previous record in this field, the new value must be computed using the previous
value and the current one. Again, if there is no previous value, then there is
no operation to be done and the incoming value is the current one.

An example:

```xml
<uInt32 name="NumberOfOrders" id="346">
    <delta/>
</uInt32>
```

1. The first record comes with the value of "300". That's the value for the
   field.
2. The second record comes with the value "2". That should be added in the
   previous value and used, so the field for the second record is "302".
3. The third record comes with the value "3". Again, the previous value should
   be used and the current one should be added. So the field for the third
   record have the value "305".

Fields with the Delta operator do not appear in the Presence Map.

### Operator: Increment

Increment works like the Delta operator 'cause it always add a value to the
previous one, but the value to be added is always 1.

If the bit for the field is set in the Presence Map, the value for the field is
the one in the incoming data; otherwise, the value will be the previous value
added by 1.

Example:

```xml
<uInt32 name="RptSeq" id="83">
    <increment/>
</uInt32>
```

1. The first record have the bit set in the Presence Map, the decoder reads the
   value "100". That's the field value for the record.
2. The second have doesn't have the bit set, so nothing should be read from the
   incoming data, but the field value should be "101" for this record.

Fields with the Increment operator appear in the presence map.

## Presence Map Map

There is a simple map that indicates if a field appears or not in the Presence
Map, [according to JetTek](https://jettekfix.com/education/fix-fast-tutorial/):

<table>
    <tr>
        <th>Operator</th>
        <th>Appears for Mandatory Fields?</th>
        <th>Appears for Optional Fields?</th>
    </tr>
    <tr>
        <td>No Operator</td>
        <td>No.</td>
        <td>No.</td>
    </tr>
    <tr>
        <td>Constant</td>
        <td>No, the Constant value should always be used.</td>
        <td>Yes; if set, use the Constant value; otherwise the field value is Null.</td>
    </tr>
    <tr>
        <td>Copy</td>
        <td>Yes; if set, use the incoming value is the current value;
        otherwise, use the previous value.</td>
        <td>Yes; same as Mandatory fields, but the value can be Null (e.g., it
        was read as 0 for Ints or a single Null byte for Strings.</td>
    </tr>
    <tr>
        <td>Default</td>
        <td>Yes; if set, read the value from the incoming data; otherwise, use
        the default value.</td>
        <td>Yes; same as Mandatory fields.</td>
    </tr>
    <tr>
        <td>Delta</td>
        <td>No; the value in the incoming data should always be added to the
        previous one.</td>
        <td>No; same as Mandatory fields.</td>
    </tr>
    <tr>
        <td>Increment</td>
        <td>Yes; if set, read the value from the incoming data; otherwise, add
        1 to the previous value.</td>
        <td>Yes; same as Mandatory fields.</td>
    </tr>
</table>

# Template Versioning

I didn't mentioned this before, but now that I explained some things about the
types and some information about the template, I can point that the template
file allows multiple versions of the same message types.

For example

```xml
<?xml version="1.0" encoding="UTF-8"?>
<templates xmlns="http://www.fixprotocol.org/ns/fast/td/1.1">
  <template xmlns="http://www.fixprotocol.org/ns/fast/td/1.1" name="SomeRecordType" id="1">
    <string name="MsgType" id="35">
      <constant value="Z"/>
    </string>
    <string name="SomeField" id="1"/>
  </template>

  <template xmlns="http://www.fixprotocol.org/ns/fast/td/1.1" name="SomeRecordType" id="2">
    <string name="MsgType" id="35">
      <constant value="Z"/>
    </string>
    <string name="SomeField" id="1"/>
    <string name="SomeOtherField" id="2">
      <default value="A Value!"/>
    </string>
  </template>
</templates>
```

The first thing you may notice is that there are two templates defined, one
with ID "1" and another with ID "2". Both have the same name and the same
constant value in the same field ID, but the initial data in the incoming block
defines which one should be used.

The incoming data starts with a Presence Map. The first bit on this is the
"Template ID". With that Template ID, the decoder can find the list of fields
that should be processed. This Presence Map also contains the map for the
fields in the root sequence -- in our example, if the Template ID decodes to
"2", the other bit in the Presence Map is the indication of the
"SomeOtherField".

{% note() %}
So far, I didn't find any data that didn't had the bit set for the template ID,
so I'm not actually sure what would happen if the bit is unset.
{% end %}

# Anomalies

I call "anomaly" anything that I had to spent way too much time to understand.

## Decimals With Different Operators

This is one thing that made things pretty hard to grasp at first. For example:

```xml
<decimal name="MDEntryPX" id="270" presence="optional">
    <exponent>
        <default value="0"/>
    </exponent>
    <mantissa>
        <delta/>
    </mantissa>
</decimal>
```

That seems simple. But there are a lot of moving pieces here:

1. The `presence="optional"` in the decimal means that the `exponent` can be
   Null and only that.
2. The Default operator in the Exponent means the decoder must check if the
   Exponent have a value in the incoming data or should use the default value
   of "0".

   There is an issue here: If the Presence Map indicates that the value is
   present and the read value is 0, because the field is optional, the decoder
   should consider the Exponent Null and, thus, there is no Mantissa and
   everything is Null.
3. The Delta operator in the Mantissa should be used applying the incoming
   value to the previous one. But, if the Exponent is not in the presence map,
   because it has a default value, that's its value and it shouldn't be read in
   the incoming data and the read value is actually applied to the Mantissa.

Like this:

1. The first record have the field set in the Presence Map and it is read as
   "-2"; that's the Exponent. The next value is "1020", which is the Mantissa,
   so the whole decimal is "10.20";
2. The second record have the field set in the Presence Map and it is read as
   "0". Because the decimal is optional, the exponent is optional, and because
   0 is Null for optional fields, there is no Exponent, and the next value is
   *not* the Mantissa. The value for the field in this record is Null.
3. The third record have the field not set in the Presence Map. Because
   Exponent has a default value, it becomes "0", and the Mantissa should be read.
   If the incoming data have the value "10", the decimal becomes "10" (or
   "10.00", if we use the same decimal places everywhere).

A weird thing I saw was related to the way the exchange was ordering the
results. It had a sequence of sell and buy orders in which

1. The first record was the sell order, with an Exponent of "0" and a Mantissa
   of "5410". That meant the value is "5410" (pretty straight).
2. The second record was the buy order. It had an Exponent of "-2" and the
   Mantissa had an incoming value of "526604". With the Delta operador, that
   gives the value of "532014", but because the Exponent is "-2", the actual
   value is "5320.14".
3. The weird thing happened in the third record, which was again a sell order.
   The value should be exactly the same as the first, but the exchange sent an
   Exponent of "0" and a Mantissa of "−526604". With the delta, that would bring
   the value back to "5410".

I found it weird that they kept jumping between two different Exponents instead
of using a single one, and at the time I had some issues with the delta math in
my code, so...

## Null Length Sequences

Another strange thing I saw was the optional sequence: In practice there is no
difference between a sequence with 0 elements and one which the length is Null
-- specially if you think the protocol is, basically, a FIX generator. I have
no idea why it wasn't standardized that lengths are mandatory and a value of 0
means there is no values on it instead of doing a dance around optional and
mandatory sequences.

---

### Changelog:

- 2022-01-10: First release.
- 2022-01-10: Added information about the template versioning.
- 2022-01-13: Added examples of the tags in the template for the field types
  and examples for operators.
