private
detectEncodingOf: aString

	| stream codePointsOfGermanUmlauts utf8SecondByteOfGermanUmlauts |

	"Strategy according to table:
	ä: 228 Hex: e4 Utf8: C3A4
	ö: 246 Hex: f6 Utf8: C3B6
	ü: 252 Hex: fc Utf8: C3BC
	Ä: 196 Hex: c4 Utf8: C384
	Ö: 214 Hex: d6 Utf8: C396
	Ü: 220 Hex: dc Utf8: C39C
	ß: 223 Hex: df Utf8: C39F
	€: 8364 Hex: 20ac Utf8: E282AC Windows-1252: 16r80

	CodePoints of german umlauts indicate ANSI-encoding since they are not valid in UTF-8-encoding.
	Further more: Assume, that 16rC3 and 16rE2 indicate UTF-8, since the corresponing ANSI-characters are very uncommon in german language."

	codePointsOfGermanUmlauts := #(16rE4 16rF6 16rFC 16rC4 16rD6 16rDC 16rDF).
	utf8SecondByteOfGermanUmlauts := #(16rA4 16rB6 16rBC 16r84 16r96 16r9C 16r9F).

	stream := ReadStream on: aString.

	[stream atEnd] whileFalse:[
		| char char2 |
		char := stream peek.
		char2 := stream peek2.
		((codePointsOfGermanUmlauts includesIdentical: char codePoint) or:[char codePoint == 16r80])
			ifTrue:
				[isUtf8 := false.
				isAnsi := true.
				^#ansi].
		((char codePoint == 16rC3) and:[utf8SecondByteOfGermanUmlauts includesIdentical: char2 codePoint])
			ifTrue:
				[isUtf8 := true.
				isAnsi := false.
				^#utf8].
		((char codePoint == 16rE2) and:[char2 codePoint== 16r82])
			ifTrue:
				[isUtf8 := true.
				isAnsi := false.
				^#utf8].
		
		stream next].

	"If we reach this point, we did not find any special characters and are probably dealing with a 7-bit stream."
	^#ascii7
