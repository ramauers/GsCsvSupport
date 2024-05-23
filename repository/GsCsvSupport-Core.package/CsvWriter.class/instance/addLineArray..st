public
addLineArray: aLineArray

	| quotationChars |
	quotationChars := self quotationChars.

	aLineArray
		do: 
			[:each | 
			| cellString needsQuotation |
			cellString := each
								ifNotNilDo: [:e | e asString]
								ifNil: [ nilString ].

			(needsQuotation := cellString anySatisfy:[ :c | quotationChars includesIdentical: c ])
				ifTrue: 
					[buffer nextPut: $".
					cellString
						do: 
							[:c | 
							c == $" ifTrue: [buffer nextPut: $"].
							buffer nextPut: c]]
				ifFalse:
					[buffer nextPutAll: cellString asString].
			needsQuotation ifTrue: [buffer nextPut: $"]]
		separatedBy: [buffer nextPut: delimiter].
	buffer nextPutAll: lineEnding.

	buffer size > minChunkSize ifTrue:[ self flush ].
