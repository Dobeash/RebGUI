enable: make function! [
	"Enable a widget."
	face [object! block!]
] [
	foreach f reduce either object? face [[face]] [face] [
		if 'disable = f/parent-face/type [
			f: f/parent-face
			f/pane/1/offset: f/offset
			f/pane/1/span: f/data
			change find f/parent-face/pane f f/pane/1
			show f/parent-face
		]
	]
]