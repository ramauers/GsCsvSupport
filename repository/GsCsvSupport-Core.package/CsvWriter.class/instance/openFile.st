public
openFile

	file := appendMode
		ifTrue: [ GsFile open: self filePath mode: 'a' onClient: onClient ]
		ifFalse: [ GsFile open: self filePath mode: 'w' onClient: onClient ].
	 
	^file
