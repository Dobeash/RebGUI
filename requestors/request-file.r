request-file: make function! [
	"Requests a file."
	/title text [string!] "Title text"
	/path dir [file!] "Set starting directory"
	/save "Request file for saving, otherwise loading"
	/filter mask [file! block!] "Coerce suffix if file!"
	/default file [file!]
	/local result
] [
	if any [none? dir not exists? dir] [dir: what-dir]
	dir: dirize dir
	result: none
	display/dialog any [text either save ["Save"] ["Open"]] compose [
		after 1
		image images/help
		field (all [default as-string file])
		(
			unless save [
				sort filter: remove-each f read dir [
					any [
						#"." = first f
						#"/" = last f
						all [file? mask mask <> suffix? f]
						all [block? mask not find mask suffix? f]
					]
				]
				[
					text-list data filter [
						set-text first in-widget face/parent-face/parent-face 'field face/selected
					] on-dbl-click [
						var: first in-widget face/parent-face/parent-face 'field
						unless empty? trim var/text [result: to-rebol-file var/text]
						hide-popup
					]
				]
			]
		)
		reverse
		button "Cancel" [hide-popup]
		button "OK" [
			var: first in-widget face/parent-face 'field
			unless empty? trim var/text [result: to-rebol-file var/text]
			hide-popup
		]
		do [set-focus first in-widget face 'field]
	]
	either result [
		;	apply singleton filter
		all [
			file? mask
			mask <> suffix? result
			result: join result mask
		]
		join dir result
	] [result]
]