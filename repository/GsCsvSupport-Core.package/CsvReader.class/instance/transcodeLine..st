private
transcodeLine: aString

	| line |	

	(isUtf8 not and:[isAnsi not])
		ifTrue:
			["Still not sure about the encoding. Continue with auto-detection"
			self detectEncodingOf: aString].

	line := isUtf8
		ifTrue:
			[aString decodeFromUTF8]
		ifFalse:
			["Replace Windows-1252 encoded € by unicode"
			aString copyReplaceAll: 16r80 asCharacter asString with: '€'].

	lineEnding ~= Character lf asString
		ifTrue:[^line copyReplaceAll: lineEnding with: Character lf asString].

	^line
