field: make baseface [
	options: {
		USAGE:
			field
			field -1 "String"

		DESCRIPTION:
			Editable text field with no text wrapping.
	}
	size: 50x5
	text: ""
	color: colors/edit
	edge: default-edge
	font: default-font
	para: default-para
	feel: edit/feel
	action: default-action
	init: make function! [] [
		para: make para [] ; avoid shared para object for scrollable input widget
		all [negative? size/x size/x: 10000 size/x: 4 + first size-text self]
	]
	esc: none
	caret: none
	undo: copy []
]