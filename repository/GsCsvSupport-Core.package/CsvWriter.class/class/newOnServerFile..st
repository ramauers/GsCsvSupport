Instance Creation
newOnServerFile: aFilePath

	^self new
		onClient: false;
		filePath: aFilePath;
		yourself
