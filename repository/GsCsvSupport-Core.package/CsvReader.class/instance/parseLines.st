private
parseLines

	| line |
	self rewind.
	(firstLineToRead -1) timesRepeat:[self nextLine]. 
	[self atEnd] whileFalse: 
		[line := self nextLine.
		line notNil
			ifTrue: 
				[lineWithIndexBlock
					value: (self lineArrayFromCsvString: line withDelimiter: delimiter)
					value: lineCount]]
