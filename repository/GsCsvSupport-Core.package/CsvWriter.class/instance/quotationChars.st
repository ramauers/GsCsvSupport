private
quotationChars

	^ Array
			with: self delimiter
			with: $"
			with: Character lf
			with: Character cr
