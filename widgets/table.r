table: make baseface [
	options: {
		USAGE:
			table options ["Name" left .5 "Age" right .5] data ["Bob" 32 "Pete" 45 "Jack" 29]

		DESCRIPTION:
			Columns and rows of values formatted according to a header definition block.

		OPTIONS:
			'multi allows multiple rows to be selected at once
			'no-sort disables column sorting
			'no-resize disables column resizing
			'fixed-sort limits sorting to first column only
	}
	size: 50x25
	color: colors/edit
	pane: []
	data: []
	edge: default-edge
	action: make default-action [
		on-resize: make function! [face /local v] [
			v: second-last face/pane
			v/pane/2/offset/x: face/size/x - sizes/slider - 1
			v: face/pane/(face/cols)
			v/size/x: face/size/x - v/offset/x - 1
		]
	]
	;	widget facets
	redraw: make function! [] [] ; place-holder for examine
	selected: make function! [] [] ; place-holder for examine
	picked: []
	widths: []
	aligns: []
	cols: none
	rows: make function! [] [pane/(cols + 1)/rows]

	add-row: make function! [
		row [block!]
		/position
		pos [integer!]
	] [
		either pos [
			pos: (pos - 1) * cols
		] [
			pos: 1 + length? data
		]
		insert at data pos row
		redraw
	]

	remove-row: make function! [
		row [integer! block!]
		/local rows removed
	] [
		if integer? row [row: to-block row]
		rows: sort/reverse copy row
		repeat n length? rows [
			row: max 1 min rows/:n (length? data) / cols
			remove/part skip data (row - 1) * cols cols
		]
		redraw
	]

	alter-row: make function! [
		row [integer! block!]
		values [block!]
		/local rows last-picked
	] [
		last-picked: copy picked
		if integer? row [row: to-block row]
		rows: row
		if (length? rows) <> (length? values) [
			values: reduce [values]
		]
		if (length? rows) = (length? values) [
			repeat n length? rows [
				row: max 1 min rows/:n (length? data) / cols
				change skip data (row - 1) * cols copy/part values/:n cols
			]
		]
		redraw
		unless empty? last-picked [select-row/no-action last-picked]
	]

	select-row: make function! [
		row [integer! none! block!]
		/no-action
		/local rows lines
	] [
		clear picked
		if row [
			row: either integer? row [to block! row] [sort copy row]
			rows: pane/(cols + 1)/rows
			lines: pane/(cols + 1)/lines
			foreach r row [
				r: max 1 min rows r
				insert picked r
			]
			if any [
				row/1 < (pane/(cols + 1)/scroll + 1)
				row/1 > (pane/(cols + 1)/scroll + pane/(cols + 1)/lines)
			] [
				pane/(cols + 1)/pane/2/data: 1 / (rows - lines) * ((min (rows - lines + 1) row/1) - 1)
			]
			unless no-action [action/on-click self]
		]
		view*/caret: pane/(cols + 1)/pane/1/text
		view*/focal-face: pane/(cols + 1)/pane/1
		show self
	]

	init: make function! [/local p opts col-offset last-col] [
		unless options [options: copy []]
		;	default options
		opts: [table]
		all [remove find options 'multi insert tail opts 'multi]
		all [remove find options 'no-sort insert tail opts 'no-sort]
		all [remove find options 'no-resize insert tail opts 'no-resize]
		all [remove find options 'fixed-sort insert tail opts 'fixed-sort]
		;	basic options and data validation
		unless integer? cols: divide length? options 3 [
			request-error "table has an invalid options block"
		]
		if all [not empty? data decimal? divide length? data cols] [
			request-error "table has an invalid data block"
		]
		;
		;	Columns
		;
		p: self
		col-offset: -1
		foreach [column halign width] options [
			unless any [string? column word? column] [
				request-error "table column name must be a string or word"]
			unless find [left center right] halign [
				request-error "table column align must be one of left, center or right"
			]
			unless number? width [
				request-error "table column width must be a decimal"
			]
			insert tail aligns halign
			insert tail widths width: to integer! size/x * width
			insert tail pane make gradface [
				offset: as-pair col-offset -1
				size: as-pair width + 1 sizes/line + 1
				text: form column
				options: opts
				col: length? widths
				feel: make default-feel [
					engage: make function! [face act event /local delta arrow] [
						switch/default act [
							down [
								;face/effect/colorize: colors/theme/2
								unless find face/options 'no-sort [
									unless all [face/col > 1 find face/options 'fixed-sort] [
										arrow: last face/parent-face/pane
										unless arrow/col = face/col [
											arrow/col: face/col
											arrow/asc: none
											arrow/offset/x: offset/x + size/x + sizes/cell - sizes/line
										]
										arrow/action arrow
									]
								]
								data: event/offset/x
							]
							up [
								data: none
								;face/effect/colorize: colors/theme/1
							]
							;away [face/effect/colorize: none]
						] [
							if all [
								not find face/options 'no-resize
								col <> 1
								data
								event/type = 'move
								event/offset/x <> data
							] [
								delta: event/offset/x - data
								delta: either positive? delta [
									min delta parent-face/pane/:col/size/x - (sizes/line * 2)
								] [
									max delta negate parent-face/pane/(col - 1)/size/x - (sizes/line * 2)
								]
								delta
								unless zero? delta [
									all [
										col = 2
										find face/options 'fixed-sort
										arrow: last face/parent-face/pane
										arrow/col = 1
										arrow/offset/x: arrow/offset/x + delta
									]
									;	adjust column widths
									widths/:col: widths/:col - delta
									widths/(col - 1): widths/(col - 1) + delta
									;	adjust heading widths and offset
									parent-face/pane/:col/size/x: widths/:col + 1
									parent-face/pane/:col/offset/x: parent-face/pane/:col/offset/x + delta
									parent-face/pane/(col - 1)/size/x: widths/(col - 1) + 1
									;	show changes
									show parent-face
								]
							]
						]
						show face
					]
				]
			]
			col-offset: col-offset + width
		]
		;
		;	Face Iterator
		;
		insert tail pane make face-iterator [
			offset: as-pair 0 sizes/line
			size: p/size - as-pair 0 sizes/line
			span: either p/span [copy p/span] [none]
			data: p/data
			cols: p/cols
			widths: p/widths
			aligns: p/aligns
			options: opts
			picked: p/picked
			action: p/action
		]
		;
		;	Sort Arrow
		;
		insert tail pane make baseface [
			offset: as-pair negate sizes/line sizes/cell
			size: as-pair sizes/cell * 3 sizes/cell * 3
			effect: [arrow colors/text rotate 0]
			cols: p/cols
			col: none
			asc: true
			feel: make default-feel [
				engage: make function! [face act event] [
					all [act = 'down face/action face]
				]
			]
			action: make function! [face /local last-selected] [
				asc: either none? asc [true] [complement asc]
				effect/rotate: either asc [0] [180]
				last-selected: selected
				either asc [
					sort/skip/compare parent-face/data cols col
				] [
					sort/skip/compare/reverse parent-face/data cols col
				]
				all [
					last-selected
					select-row/no-action (((index? find parent-face/data last-selected) - 1) / cols) + 1
				]
				show parent-face
			]
		]
		;	column headings
		pane/(cols + 1)/cols: cols
		pane/(cols + 1)/data: data
		;	reassign options
		options: pane/(cols + 1)/options
		;	is total width OK
		last-col: first back back back tail pane
		last-col/size/x: size/x - last-col/offset/x - 1
		all [negative? last-col/size/x request-error "table column widths are too large"]
		widths/:cols: last-col/size/x - 1
		;	init iterator *after* we know align
		pane/(cols + 1)/init
		;	accessors
		redraw: get in pane/(cols + 1) 'redraw
		selected: get in pane/(cols + 1) 'selected
	]
]