private
updateBuffer

	| bytesLeft |
	
	lastChunk ifFalse:
		[buffer contents isEmpty
			ifTrue:[^self nextChunk].

	(bytesLeft := buffer size - buffer position) < 2
			ifTrue:
				[file seekFromCurrent: (bytesLeft + 1) negated.
				self nextChunk]]
