private
initialize

	buffer := ReadStream on: String new.
	lastChunk := false.
	isUtf8 := false.
	isAnsi := false.
	firstLineToRead := 1.
