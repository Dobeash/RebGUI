tree: make baseface [
	options: {
		USAGE:
			tree data ["Pets" ["Cat" "Dog"] "Numbers" [1 2 3]]

		DESCRIPTION:
			Values arranged in a collapsible hierarchy.

		OPTIONS:
			'only returns item not full path
	}
	size: 50x25
	color: colors/edit
	pane: []
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

	build-tree: make function! [
		string [string!]
		items [block!]
	] [
		foreach item items [
			either block? item [
				build-tree join last .data-path "/" item
			][
				insert tail .data-path join string item
			]
		]
	]

	;	private attributes
	.data: [] ; original data
	.tabs: []
	.data-path: [] ; data is path form
	.data-list: [] ; data in tabbed form

	init: make function! [/local p blk levels] [
		unless options [options: copy []]
		;	convert block into path
		either find data block! [build-tree "" data] [.data-path: copy data]
		;	build tree
		levels: 1
		foreach item sort .data-path [
			blk: remove-each i parse/all form item "/\" [empty? i]
			levels: max levels length? blk
			insert tail .data-list head insert/dup last blk "^-" -1 + length? blk
		]
		repeat n levels [insert tail .tabs n * sizes/line]
		p: self
		pane: make face-iterator [
			size: p/size
			span: either p/span [copy p/span] [none]
			data: p/.data-list
			options: p/options
			picked: p/picked
			action: p/action
			tab-levels: p/.tabs ; share tabs block
		]
		pane/init
		;	accessors
		redraw: get in pane 'redraw
		selected: get in pane 'selected
	]
]