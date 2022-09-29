sheet: make baseface [
	options: {
		USAGE:
			sheet
			sheet options [size 3x3 width 2]
			sheet options [size 3x3 widths [2 3 4]]
			sheet data [A1 1 A2 2 A3 "=A1 + A2"]

		DESCRIPTION:
			Simple spreadsheet, based on rebocalc.r, with formulas calculated left to right, top to bottom.
			A cell is either a scalar value, string, or a formula starting with "=".
			Scalar values are automatically right-justified, series values left-justified.
			Remember to put spaces between each item in a formula and use () where needed.

		OPTIONS:
			'size specifies number of columns and rows
			'width specifies cell width in relation to cell height
			'widths specifies n cell widths
	}
	size: -1x-1
	color: colors/outline/1
	pane: []
	data: []

	group: none

	load-data: make function! [dat /local v] [
		insert clear data dat
		foreach cell group [
			cell/text: either v: select data cell/data [form v] [copy ""]
			enter cell
		]
		compute
		show group
	]

	save-data: make function! [] [
		clear data
		foreach cell group [
			unless empty? cell/text [
				insert tail data either cell/options [
					reduce [cell/data join "=" form cell/options]
				] [
					reduce [cell/data get cell/data]
				]
			]
		]
	]

	enter: make function! [face /local v] [
		face/color: colors/edit
		face/font/align: 'left
		error? try [unset face/data]
		face/options: none
		all [empty? trim face/text exit]
		v: attempt [load either #"=" = first face/text [next face/text] [face/text]]
		either any [series? v word? v] [
			either #"=" = first face/text [face/color: colors/theme/1 face/options: :v] [set face/data face/text]
		] [
			face/font/align: 'right
			set face/data v
		]
	]

	compute: make function! [/local v] [
		foreach cell group [
			if cell/options [
				either all [word? cell/options string? get cell/options] [v: get cell/options] [
					unless v: attempt [do cell/options] [cell/text: "ERROR!"]
				]
				cell/font/align: either series? v ['left] ['right]
				cell/text: form v
				set cell/data cell/text
				show cell
			]
		]
	]

	init: make function! [/local cols rows p pos char v widths row-size] [
		unless options [options: copy []]
		either pair? v: select options 'size [cols: v/x rows: v/y] [
			either empty? data [cols: 6 rows: 12] [
				cols: #"A"
				rows: 1
				foreach [cell val] data [
					cols: max cols uppercase first form cell
					rows: max rows to integer! next form cell
				]
				cols: to integer! cols - 64
			]
		]
		widths: copy []
		case [
			v: select options 'widths [insert widths v]
			v: select options 'width [insert/dup widths v cols]
			true [insert/dup widths 4 cols]
		]
		row-size: as-pair sizes/line * 2 sizes/line
		if negative? size/x [
			size/x: row-size/x + cols + 1
			foreach w widths [size/x: w * sizes/line + size/x]
		]
		all [negative? size/y size/y: rows * sizes/line + rows + row-size/y + 1]
		;	column labels
		char: #"A"
		pos: as-pair row-size/x + 1 0
		repeat x cols [
			insert tail pane make gradface [
				offset: pos
				size: as-pair sizes/line * pick widths x sizes/line
				text: form char
			]
			char: char + 1
			pos/x: sizes/line * (pick widths x) + pos/x + 1
		]
		;	row labels
		pos: as-pair 0 sizes/line + 1
		repeat y rows [
			insert tail pane make gradface [
				offset: pos
				size: row-size
				text: form y
			]
			pos/y: pos/y + sizes/line + 1
		]
		;	group
		p: self
		group: tail pane
		pos: row-size + 1x1
		repeat y rows [
			pos/x: row-size/x + 1
			char: #"A"
			repeat x cols [
				v: to word! join char y
				insert tail pane make baseface [
					type: 'field
					offset: pos
					size: as-pair sizes/line * pick widths x sizes/line
					text: form any [select p/data v ""]
					color: colors/edit
					font: make default-font []
					para: make default-para []
					feel: edit/feel
					data: v
					options: none
					action: make default-action [
						on-focus: make function! [face] [
							all [face/options face/text: join "=" form face/options]
							face/font/align: 'left
							select-face face
							true
						]
						on-unfocus: make function! [face] [
							;face/color: colors/edit
							;show face
							deselect-face face
							enter face compute face/para/scroll: 0x0
							true
						]
					]
				]
				char: char + 1
				pos/x: sizes/line * (pick widths x) + pos/x + 1
			]
			pos/y: pos/y + sizes/line + 1
		]
		;	load data
		unless empty? data [
			foreach cell group [
				unless empty? cell/text [enter cell]
			]
			compute
		]
	]
]