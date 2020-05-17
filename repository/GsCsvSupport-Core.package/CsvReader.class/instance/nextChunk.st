private
nextChunk

	| chunkSize readCount |
	chunkSize := 32768.

	readCount := file next: chunkSize into: buffer contents.
	(readCount isNil or:[readCount < chunkSize])
		ifTrue:[lastChunk := true].
	buffer reset.
	^readCount
