password: make field [
	options: {
		USAGE:
			password
			password "Secret"

		DESCRIPTION:
			Editable password field with text displayed as a progress bar.
	}
	font: make default-font [color: colors/theme/2]
	para: make default-para [origin: 0x2]
	effect: [draw [pen colors/theme/2 fill-pen colors/theme/2]]
	action: make default-action [
		on-edit: make function! [face /local xy1 xy2] [
			xy1: 1x1
			xy2: as-pair sizes/font sizes/line - 4
			clear skip face/effect/draw 4
			loop length? face/text [
				insert tail face/effect/draw reduce ['box xy1 xy2]
				xy1/x: xy1/x + sizes/font
				xy2/x: xy2/x + sizes/font
			]
			show face
		]
	]
	init: make function! [] [
		action/on-edit self
	]
]