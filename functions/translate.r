translate: make function! [
	"Dynamically translate a string or block of strings."
	text "String (or block of strings) to translate"
	/local match
] [
	;	Note that if text is not a string! or block! then no error will be raised.
	;	This is an optimization so code that calls translate does not have to be
	;	wrapped in an "if string? text ..." type construct.
	if all [series? text locale*/words] [
		text: copy/deep text
		all [
			string? text
			match: select/skip locale*/words text 2
			insert clear text match
		]
		if block? text [
			foreach word text [
				all [
					string? word
					match: select/skip locale*/words word 2
					insert clear word match
				]
			]
		]
	]
	text
]