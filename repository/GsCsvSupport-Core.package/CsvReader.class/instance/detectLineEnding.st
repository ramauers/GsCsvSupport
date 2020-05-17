private
detectLineEnding

	"Assume consistent line endings in file. Search for first occurence of crlf (Windows style) or lf (UNIX style) or cr (MAC style)"
	| cr lf |
	cr := Character cr.
	lf := Character lf.
	file rewind.

	[file atEnd] whileFalse:[
		file peek == lf
			ifTrue:
				[lineEnding := String with: lf.
				lineEndingSize := 1.
				^#lf].
		((file peek == cr) and:[file peek2 == lf])
			ifTrue:
				[lineEnding := String crlf.
				lineEndingSize := 2.
				^#crlf].
		file peek == cr
			ifTrue:
				[lineEnding := String with: cr.
				lineEndingSize := 1.
				^#cr].				
		file next
	].

	"If we reach the point, we are probably dealing with just one line without a line ending.
	However, we default to lf."
	lineEnding := String with: lf.
	lineEndingSize := 1.
	^#lf
