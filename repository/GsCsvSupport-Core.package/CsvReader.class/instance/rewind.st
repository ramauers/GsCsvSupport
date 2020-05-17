private
rewind

	lineCount := 0.
	hasBom
		ifTrue:[file position: 3]
		ifFalse:[file position: 0].
	self nextChunk
