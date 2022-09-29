request-char: make function! [
	"Requests a character."
	/title text [string!] "Title text"
	/font name [string!] "Font to use"
	/local result char-spec size
] [
	get-fonts
	name: any [name effects/font]
	char-spec: compose/only [
		text-list 50x120 data (fonts) [
			foreach f face/parent-face/parent-face/pane/2/pane [
				f/font/name: face/selected
			]
			show face/parent-face/parent-face
		]
		panel data [space 0x0 text-size 8x8]
	]
	repeat i 256 [
		if i > 32 [
			insert tail last char-spec compose/deep [
				text (colors/edit) (form to char! i - 1) font [
					name: (name)
					size: (to integer! sizes/font * 2)
					valign: 'middle
					align: 'center
				] [result: to char! face/text hide-popup] on [
					over [select-face face]
					away [deselect-face face]
				]
			]
			if zero? remainder i 16 [insert tail last char-spec 'return]
		]
	]
	insert tail char-spec compose [do [face/color: colors/edit]]
	result: none
	display/dialog any [text "Character Map"] char-spec
	result
]