scroll-panel: make baseface [
	options: {
		USAGE:
			scroll-panel data [sheet]

		DESCRIPTION:
			A panel used to group widgets within a scrollable container.

		OPTIONS:
			'offset keeps the original offset
	}
	size: 50x50
	pane: []
	edge: default-edge

	action: make default-action [
		on-click: make function! [face] [view*/focal-face: face]
		on-scroll: make function! [face scroll /page] [
			either page [
				all [face/pane/3/show? face/pane/3/set-data scroll]
			] [
				all [face/pane/2/show? face/pane/2/set-data scroll]
			]
		]
		on-resize: make function! [face /child /local p1 p2 p3 p4] [
			p1: face/pane/1
			p2: face/pane/2
			p3: face/pane/3
			p4: face/pane/4
			p2/show?: either p1/size/y <= face/size/y [face/sld-offset/x: 0 false] [face/sld-offset/x: sizes/slider true]
			p3/show?: either p1/size/x <= face/size/x [face/sld-offset/y: 0 false] [face/sld-offset/y: sizes/slider true]
			p4/show?: either any [p2/show? p3/show?] [true] [false]
			p2/ratio: min 1 face/size/y - face/sld-offset/y / p1/size/y
			p3/ratio: min 1 face/size/x - face/sld-offset/x / p1/size/x
			if child [
				all [p2/ratio = 1 p2/data: p1/offset/y: 0]
				all [p3/ratio = 1 p3/data: p1/offset/x: 0]
				show face
			]
		]
	]
	;	widget facets
	p1: p2: p3: p4: none
	sld-offset: 0x0

	init: make function! [/local p] [
		unless options [options: copy []]
		p: self
		;	insert layout
		data: layout/only data
		insert pane either 1 = length? data/pane [first data/pane] [data]
		all [negative? size/x size/x: data/size/x]
		all [negative? size/y size/y: data/size/y]
		data: none
		p1: first pane
		color: p1/color
		unless find options 'offset [p1/offset: 0x0]
		p1/edge: none
		if span [
			all [find span #H p1/span: #H]
			all [find span #W p1/span: #W]
			all [find span #H find span #W p1/span: #HW]
		]
		;	vertical scroller
		insert tail pane make slider [
			offset: as-pair p/size/x - sizes/slider - 1 -1
			size: as-pair sizes/slider p/size/y - sizes/slider + 1
			span: case [
				none? p/span [none]
				all [find p/span #H find p/span #W] [#XH]
				find p/span #H [#H]
				find p/span #W [#X]
			]
			action: make default-action [
				on-click: make function! [face] [
					p1/offset/y: negate p1/size/y + sld-offset/y - p/size/y * face/data
					show p1
				]
			]
		]
		p2: second pane
		p2/init
		;	horizontal scroller
		insert tail pane make slider [
			offset: as-pair -1 p/size/y - sizes/slider - 1
			size: as-pair p/size/x - sizes/slider + 1 sizes/slider
			span: case [
				none? p/span [none]
				all [find p/span #H find p/span #W] [#YW]
				find p/span #H [#Y]
				find p/span #W [#W]
			]
			action: make default-action [
				on-click: make function! [face] [
					p1/offset/x: negate p1/size/x + sld-offset/x - p/size/x * face/data
					show p1
				]
			]
		]
		p3: third pane
		p3/init
		;	corner
		insert tail pane make btn [
			offset: p/size - 1x1 - as-pair sizes/slider sizes/slider
			size: as-pair sizes/slider sizes/slider
			span: case [
				none? p/span [none]
				all [find p/span #H find p/span #W] [#XY]
				find p/span #H [#Y]
				find p/span #W [#X]
			]
		]
		p4: fourth pane
		p4/action: make default-action [
			on-click: make function! [face /local p] [
				p: face/parent-face
				p2/data: p3/data: either p1/offset = 0x0 [1] [0]
				all [p2/show? show p2]
				all [p3/show? show p3]
			]
		]
		p4/init

		action/on-resize self
	]
]