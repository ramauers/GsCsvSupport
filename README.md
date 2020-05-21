# GsCsvSupport
Handling of csv-files for GemStone/S

This package currently contains the class CsvReader. A corresponding class CsvWriter may be added in future.

## CsvReader

CsvReader is a self-contained class with no dependencies other than GemStone/S kernel classes.
It allows performant reading of very large amount of csv-data from a file stream.

CsvReader will auto-detect the used line-ending from either lf (Unix style), cr (Classic Mac style) or crlf (Windows style). However, consitent line-endings within a single file are expected.

The used delimiter can optionally be specified with useDelimiter:, otherwise an auto-detection is tried from the commonly used separators tab, comma, semicolon, pipe, tilde or colon.

CsvReader auto-detects the encoding of the file. UTF-8 and ANSI encoding is supported. If the file starts with an [UTF-8 BOM](https://en.wikipedia.org/wiki/Byte_order_mark), the file is clearly detected as UTF-8 encoded. If no UTF-8 BOM is given, auto-detection will be done based on the file's content, paying special attention to german umlauts and the Euro sign €. In case of an ANSI file, Windows-1252 is assumed rather than ISO-8859-1, therefore octet 0x80 will be interpreted as Euro sign € and automatically transcoded to its unicode.

CsvReader respects [RFC 4180](https://tools.ietf.org/html/rfc4180) and can handle properly escaped files, hence double-quotes, the used separator and line breaks can be part of the file's content without harming the file's structue.

Usage of CsvReader is very straightforward and illustrated by the following example:

```smalltalk
	| reader lines headerArray |
	lines := OrderedCollection new.

	reader := CsvReader newOnServerFile: '/path/to/file.csv'.

	"optional: Set the delimiter to omit auto-detection."
	reader useDelimiter: $;.

	"optional: Read a single (header) line, e.g. to verify existence of expected column headers."
	headerArray := reader readHeaderFromLine: 1.

	"optional: Specify the first line to read. Default is 1."
	reader firstLineToRead: 2.

	"Specify a two-argument-block, which will be evaluated for each read line.
	First argument is an array holding the cells of the line; second argument is the line number."
	reader linesWithIndexDo: [:lineArray :index | lines add: index -> lineArray].

	"Start reading the file."
	reader read.

	^lines
```
