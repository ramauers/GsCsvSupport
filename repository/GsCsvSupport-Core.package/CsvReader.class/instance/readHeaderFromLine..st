public
readHeaderFromLine: aLineNumber

	| line |
	self openFile.
	self detectUtf8Bom.
	lineEnding ifNil:[self detectLineEnding].
	delimiter ifNil:[self detectDelimiter].
	self rewind.
	aLineNumber timesRepeat:[line := self nextLine]. 
	self closeFile.
	^self lineArrayFromCsvString: line withDelimiter: delimiter
