spinner: make baseface [
	options: {
		USAGE:
			spinner
			spinner options [$1 $10 $1] data $5

		DESCRIPTION:
			Similar to a field, with arrows to increment/decrement a value by a nominated step amount.

		OPTIONS:
			[min max step] block of minimum, maximum and step amounts
	}
	size: 20x5
	color: colors/edit
	text: ""
	edge: default-edge
	font: font-right
	para: make default-para []
	feel: edit/feel
	pane: copy []
	action: make default-action [
		on-resize: make function! [face] [
			face/pane/1/offset/x: face/size/x - sizes/line + sizes/cell - 1
			face/pane/2/offset/x: face/size/x - sizes/line + sizes/cell - 1
		]
		on-scroll: make function! [face scroll /page] [
			face/text: either any [none? face/data page] [
				form data: either negative? scroll/y [second face/options] [first face/options]
			] [
				form face/data + either negative? scroll/y [last face/options] [negate last face/options]
			]
			face/action/on-unfocus face
		]
		on-unfocus: make function! [face] [
			either empty? face/text [
				face/data: none
			] [
				face/data: any [attempt [to type? first face/options face/text] face/data]
				face/text: either face/data [form face/data: min max face/data first face/options second face/options] [copy ""]
				show face
			]
			face/action/on-click face
			true
		]
	]
	init: make function! [/local p] [
		unless options [options: copy []]
		all [empty? options options: copy [1 10 1]] ; min, max, increment
		all [data text: form data]
		all [not empty? text data: to type? first options text]
		para/margin/x: size/y - sizes/cell
		;	make up & down button
		p: self
		insert pane make arrow [
			offset: as-pair p/size/x - sizes/line + sizes/cell - 1 0
			size: as-pair p/size/y - sizes/cell p/size/y / 2 - 1
			data: 'up
			edge: make default-edge [size: 1x0]
			rate: 10
			action: make default-action [
				on-click: make function! [face /local p] [
					p: face/parent-face
					p/data: any [attempt [to type? first p/options p/text] p/data first p/options]
					p/data: p/data + third p/options
					if p/data > second p/options [p/data: second p/options]
					p/text: form p/data
					edit/unlight-text
					view*/caret: none
					show p
					p/action/on-click p
				]
			]
		]
		pane/1/init
		insert tail pane make arrow [
			offset: as-pair p/size/x - sizes/line + sizes/cell - 1 p/size/y / 2 - 1
			size: as-pair p/size/y - sizes/cell p/size/y / 2 - 1
			edge: make default-edge [size: 1x0]
			rate: 10
			action: make default-action [
				on-click: make function! [face /local p] [
					p: face/parent-face
					p/data: any [attempt [to type? first p/options p/text] p/data first p/options]
					p/data: p/data - third p/options
					if p/data < first p/options [p/data: first p/options]
					p/text: form p/data
					edit/unlight-text
					view*/caret: none
					show p
					p/action/on-click p
				]
			]
		]
		pane/2/init
		pane/2/effect/gradient: 0x1
	]
	esc: none
	caret: none
	undo: copy []
]