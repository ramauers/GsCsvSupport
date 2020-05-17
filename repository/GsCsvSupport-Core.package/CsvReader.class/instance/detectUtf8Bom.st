private
detectUtf8Bom

	| bomString |

	"Check if file begins with UTF-8 BOM"
	file rewind.
	bomString := file next: 3.
	^((bomString notNil and: [bomString size == 3])
		and: [bomString = #(16rEF 16rBB 16rBF) asByteArray])
			ifTrue: 
				[isUtf8 := true.
				hasBom := true.
				true]
			ifFalse:
				[hasBom := false.
				false].
