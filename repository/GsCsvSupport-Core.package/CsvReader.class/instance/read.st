public
read

	self openFile.
	self detectUtf8Bom.
	lineEnding ifNil:[self detectLineEnding].
	delimiter ifNil:[self detectDelimiter].
	self parseLines.
	self closeFile.
