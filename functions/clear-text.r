clear-text: make function! [
	"Clear text attribute of a widget or block of widgets."
	face [object! block!]
	/no-show "Don't show"
	/focus
] [
	foreach f reduce either object? face [[face]] [face] [
		unless f/parent-face/type = 'disable [
			if string? f/text [
				clear f/text
				all [f/type = 'area f/para/scroll: 0x0 f/pane/data: 0]
				f/line-list: none
			]
		]
	]
	unless no-show [
		either all [focus object? face] [set-focus face] [show face]
	]
]