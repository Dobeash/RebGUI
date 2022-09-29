request-dir: make function! [
	"Requests a directory."
	/title text [string!] "Title text"
	/path dir [file!] "Set starting directory"
	/only "Only allow new folder at root"
	/local result txt
] [
	if any [none? dir not exists? dir] [dir: what-dir]
	dir: dirize dir
	result: none
	display/dialog any [text "Folder"] compose/only/deep [
		after 1
		image images/help
		txt: text 100 (to-local-file dir)
		tree #HW 100x50 data (read-dir dir) [
			set-text txt to-local-file join dir face/selected
		] on-dbl-click [result: dirize to-rebol-file txt/text hide-popup]
		reverse
		button #XY "Cancel" [hide-popup]
		button #XY "New" [
			if var: request-value/type "New Folder" file! [
				var: to-rebol-file either only [dirize var] [join dirize txt/text dirize var]
				either exists? var [
					alert "Folder already exists."
				] [
					make-dir result: var
					hide-popup
				]
			]
		]
		button #XY "Open" [result: dirize to-rebol-file txt/text hide-popup]
	]
	result
]