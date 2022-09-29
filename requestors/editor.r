editor: make function! [
	"Displays text in an editable area with option to save."
	file [file! string!]
	/title text [string!] "Title text"
	/size cells [pair!] "Size of edit area in cells"
	/local string txt chk save?
] [
	chk: checksum string: either file? file [
		either exists? file [read file] [copy ""]
	] [
		txt: file
		file: none
		txt
	]

	chk: checksum string

	save?: make function! [] [
		if chk <> checksum txt/text [
			all [
				either file [confirm "Save changes?"] [file: request-file/save]
				write file txt/text
			]
		]
	]

	display/dialog/close any [text either file [reform ["Edit -" to-local-file file]] ["Edit"]] [
		space 0x0
		tool-bar #LW data [
			button "New" [
				save?
				file: none
				clear-text/focus txt
				chk: checksum txt/text
			]
			button "Open" [
				save?
				if var: request-file [
					file: var
					set-title face reform ["Edit -" to-local-file file]
					set-text/focus read file
				]
				all [file chk: checksum txt/text]
			]
			button "Save" [
				save?
				all [file chk: checksum txt/text]
			]
			button "Close" [
				save?
				hide-popup
			]
		]
		return
		pad 0x-1
		txt: area 80x120 #HW string
		do [set-focus last face/pane]
	] [
		save?
		true
	]
	file
]