private
openFile

	file := (GsFile open: self filePath mode: 'rb' onClient: onClient).
	^file
