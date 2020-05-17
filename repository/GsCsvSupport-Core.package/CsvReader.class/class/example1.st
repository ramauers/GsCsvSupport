Examples
example1

	| reader lines |
	lines := OrderedCollection new.
	reader := CsvReader newOnServerFile: 'csvTest-utf8.csv'.
	reader linesWithIndexDo: [:line :index | lines add: index -> line].
	reader read.
	^lines
