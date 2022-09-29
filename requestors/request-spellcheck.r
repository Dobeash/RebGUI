request-spellcheck: make function! [
	"Requests spellcheck on a widget's text."
	face [object!]
	/title text [string!] "Title text"
	/anagram "Anagram option"
	/local ignore new next-word word start end txt fld lst a
] [
	;	do we have a non-empty string
	if any [not string? face/text empty? face/text] [exit]
	;	ignore and new word blocks
	ignore: copy []
	new: copy []
	;	create dictionary dir if not present
	unless exists? %dictionary [make-dir %dictionary]
	unless locale*/dict [locale*/dict: make hash! 1000]
	;	get next word in text
	next-word: make function! [/init] [
		while [any [init start <> end]] [
			;	find start of word
			either init [
				start: end: head face/text
				unless find edit/letter first start [
					while [all [not tail? start: next start find edit/other first start]] []
				]
				init: false
			] [
				start: end
				while [all [not tail? start: next start find edit/other first start]] []
			]
			;	find end of word
			end: start
			while [all [not tail? end: next end find edit/letter first end]] []
			;	do we have a valid word to check?
			word: copy/part start end
			unless any [
				empty? word
				find ignore word
				find new word
				find locale*/dict word
			] [break]
			word: none
		]
		if all [none? init word] [
			;	update dialog
			txt/text: fld/text: word
			show [txt fld]
			insert clear lst/data edit/lookup-word word lst/redraw
			;	hilight word
			view*/focal-face: face
			view*/caret: none
			edit/hilight-text start end
			show face
		]
		string? word
	]
	if next-word/init [
		;	hilight first word
		view*/caret: none
		edit/hilight-text start end
		show face
		;	display modal dialog
		display/dialog any [text rejoin ["Spellcheck (" locale*/language ")"]] [
			image images/help
			after 2
			label "Original" txt: text 75 word
			label "Word" fld: field 75 word
			label "Suggestions" lst: text-list data (edit/lookup-word word) 75x50 [set-text fld face/selected]
			bar
			reverse
			button "Close" [
				hide-popup
			]
			button "Add" [
				insert tail new fld/text
				unless next-word [hide-popup]
			]
			button "Replace" [
				change/part start fld/text end
				end: skip start length? fld/text
				unless next-word [hide-popup]
			]
			button "Ignore" [
				insert tail ignore word
				unless next-word [hide-popup]
			]
			a: button "Anagram" false [
				either 2 < var: length? fld/text [
					face/data: lowercase sort copy fld/text
					clear lst/data
					foreach word locale*/dict [
						all [var = length? word face/data = sort copy word insert tail lst/data word]
					]
					lst/redraw
				] [alert "Requires a word with at least 3 characters."]
			]
			do [all [anagram a/show?: true]]
		]
		;	restore focal-face and caret
		set-focus face
		;	add new words to dictionary
		unless empty? new [
			insert tail locale*/dict new
			write locale*/dictionary form locale*/dict ; sort screws up the hash!
		]
	]
]