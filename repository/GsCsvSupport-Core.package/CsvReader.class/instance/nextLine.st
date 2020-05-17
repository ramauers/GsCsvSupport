private
nextLine

	| line byte inQuote |
	self atEnd ifTrue:[^nil].
	inQuote := false.
	line := String new.
	[self updateBuffer.
	self atEnd] whileFalse: 
			[byte := buffer next.
			byte == $"
				ifTrue: 
					[line add: byte.
					inQuote := inQuote not]
				ifFalse: 
					[(self atEnd or:[(lineEndingSize == 1 ifTrue:[String with: byte] ifFalse:[String with: byte with: buffer peek]) = lineEnding])
						ifTrue: 
							[inQuote
								ifTrue: [line add: byte]
								ifFalse: 
									[lineCount := lineCount +1.
									self atEnd ifFalse:[buffer skip: lineEndingSize-1].
									^self transcodeLine: line]]
						ifFalse: [line add: byte]]].
