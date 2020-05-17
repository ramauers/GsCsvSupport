private
detectDelimiter

	"Common csv-delimiter are tabulator, comma, semicolon, pipe, tilde or colon.
	Strategy: Check for the first two lines if they break down in the same number of parts using one of them."

	| firstLine secondLine |
	self rewind.
	firstLine := self nextLine.
	secondLine := self nextLine.

	(firstLine notNil and:[secondLine notNil])
		ifTrue:
			[ | firstLineArray secondLineArray |
			{Character tab. $,. $;. $|. $~. $:}
				do:
					[:eachCandidate |
					"Try delimiter candidate"
					firstLineArray := self lineArrayFromCsvString: firstLine withDelimiter: eachCandidate.
					secondLineArray := self lineArrayFromCsvString: secondLine withDelimiter: eachCandidate.
					((firstLineArray size > 1) and:[firstLineArray size == secondLineArray size])
						ifTrue:
							[delimiter := eachCandidate.
							^eachCandidate]]].

	"If we reach this point, we did not find a commonly used separator.
	However, default to comma as the acronym csv implies."	
	delimiter := $,.
	^$,
