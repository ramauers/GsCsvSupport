private
lineArrayFromCsvString: aString withDelimiter: aChar
	"Parse a single csv-line in a collection of strings"

	| result stream |
	stream :=  ReadStream on: aString.
	result := Array new.
	[stream atEnd] whileFalse: 
			[stream peek == $"
				ifTrue: 
					[| string |
					string := String new.
					stream next.
					
					[stream atEnd
						or: [(stream position < (stream size -1)) and: [stream nextMatchAll: '"' , aChar]]]
							whileFalse: 
								[((stream position < (stream size -1)) and: [stream nextMatchAll: '""'])
									ifTrue: [string add: $"]
									ifFalse: 
										[stream atEnd
											ifFalse: 
												[| c |
												c := stream next.
												stream atEnd ifFalse: [string add: c]]]].
					result add: string]
				ifFalse:
					[result add: (stream upTo: aChar) asString.
					(stream atEnd and:[stream last == aChar])
						ifTrue:[result add: String new]]].
	^result
