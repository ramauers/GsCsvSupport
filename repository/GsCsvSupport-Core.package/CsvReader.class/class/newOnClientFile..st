Instance Creation
newOnClientFile: aFilePath

	^self new
		onClient: true;
		filePath: aFilePath;
		yourself
