Examples
example1

	| csvWriter |
	csvWriter := CsvWriter newOnServerFile: '~/CsvWriterTest-exampeUUIDs.csv'.
	csvWriter openFile.

	1 to: 100000 do:[ :idx | csvWriter addLineArray: {idx. UUID new asString}].

	csvWriter closeFile
