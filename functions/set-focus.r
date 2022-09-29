set-focus: make function! [
	"Set and show widget focus."
	face [object!]
	/caret
] [
	unless edit/unfocus [exit]
	if face/show? [
		if all [
			face/action
			get in face/action 'on-focus
		] [
			unless face/action/on-focus face [return false]
		]
		view*/focal-face: face
		view*/caret: case [
			all [caret in face 'caret face/caret] [at face/text face/caret]
			find behaviors/caret-on-focus face/type [either none? edit/caret [tail face/text] [edit/caret]]
			find behaviors/hilight-on-focus face/type [edit/hilight-all face face/text]
		]
		edit/caret: none
		all [in face 'esc face/esc: copy face/text]
		switch/default face/type [
			button [face/feel/over face on 0x0]
			drop-list [face/feel/over face on 0x0]
			table [face/select-row 1]
			text-list [face/select-row 1]
			tree [face/select-row 1]
		] [show face]
	]
]