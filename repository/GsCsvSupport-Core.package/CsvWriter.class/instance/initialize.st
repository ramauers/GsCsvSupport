private
initialize

	buffer := AppendStream on: String new.
	minChunkSize :=   1048576. "1MB"
	isUtf8 := false.
	onClient := false.
	hasBom := false.
	delimiter := $,.
	lineEnding := Character lf asString.
	nilString := ''.
	appendMode := false.
