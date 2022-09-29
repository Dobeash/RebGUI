text-list: make baseface [
	options: {
		USAGE:
			text-list data ["One" "Two"]
			text-list data ctx-rebgui/locale*/colors
			text-list data [1 2] [print face/selected]

		DESCRIPTION:
			A single column list with a scroller.

		OPTIONS:
			'multi allows multiple rows to be selected at once
	}
	size: 50x25
	color: colors/edit
	data: []
	edge: default-edge
	action: make default-action [
		on-resize: make function! [face] [
			face/pane/pane/2/offset/x: face/size/x - sizes/slider - 1
		]
	]
	;	widget facets
	redraw: make function! [] [] ; place-holder for examine
	selected: make function! [] [] ; place-holder for examine
	picked: []
	rows: make function! [] [pane/rows]

	select-row: make function! [
		row [integer! none! block!]
		/no-action
		/local rows lines
	] [
		clear picked
		if row [
			row: either integer? row [to block! row] [sort copy row]
			rows: pane/rows
			lines: pane/lines
			foreach r row [
				r: max 1 min rows r
				insert picked r
			]
			unless no-action [action/on-click self]
		]
		view*/caret: pane/pane/1/text
		view*/focal-face: pane/pane/1
		show self
	]
	init: make function! [/local p] [
		unless options [options: copy []]
		p: self
		pane: make face-iterator [
			size: p/size
			span: either p/span [copy p/span] [none]
			data: p/data
			options: p/options
			picked: p/picked
			action: p/action
		]
		pane/init
		;	accessors
		redraw: get in pane 'redraw
		selected: get in pane 'selected
	]
]