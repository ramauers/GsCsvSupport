private
flush

	file nextPutAll:
		(isUtf8
			ifTrue:[ buffer contents encodeAsUTF8 ]
			ifFalse:[ buffer contents ]).
	buffer collection size: 0.
