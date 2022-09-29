radio-group: make baseface [
	options: {
		USAGE:
			radio-group data ["Option A" "Option B"]
			radio-group data [2 "On" "Off"]

		DESCRIPTION:
			Group of mutually exclusive radio buttons.
			Alignment is vertical unless height is specified as line height.
			An integer provided as the first entry in the block indicates the default selection.
	}
	size: -1x-1
	pane: []
	action: default-action
	picked: none
	selected: make function! [] [
		all [picked pick data picked]
	]
	select-item: make function! [item [integer! none!]] [
		either any [none? item zero? item] [
			item: either picked = 1 [2] [1]
			pane/:item/feel/engage/reset pane/:item 'down none
		] [
			all [item <> picked pane/:item/feel/engage pane/:item 'down none]
		]
	]
	init: make function! [/local off siz pos index] [
		;	picked?
		unless string? first data: reduce data [
			picked: first data
			remove data
		]
		all [negative? size/x foreach label data [size/x: max size/x sizes/line + first text-size? label]]
		all [negative? size/y size/y: sizes/line * length? data]
		;	vertical or horizontal?
		off: either size/y > sizes/line [
			siz: as-pair size/x sizes/line
			as-pair 0 sizes/line
		] [
			siz: as-pair size/x / length? data sizes/line
			as-pair siz/x 0
		]
		;	insert labels
		pos: 0x0
		index: 1
		foreach label data [
			insert tail pane make baseface [
				offset: pos
				size: siz
				text: label
				effect: compose/deep [draw [pen (colors/outline/3) fill-pen (colors/edit) circle (sizes/cell * 2x2) (sizes/cell * 1.5)]]
				data: index
				font: default-font
				para: para-indent
				feel: make default-feel [
					over: make function! [face act pos] [
						face/effect/draw/pen: either act [colors/theme/1] [colors/outline/3]
						show face
					]
					engage: make function! [face act event /reset /local pf] [
						switch act [
							down [
								if all [pf: face/parent-face pf/picked <> face/data] [
									;	deflag old
									all [
										pf/picked
										clear skip pf/pane/(pf/picked)/effect/draw 7
										show pf/pane/(pf/picked)
									]
									either reset [pf/picked: none] [
										;	flag new
										pf/picked: face/data
										insert tail face/effect/draw reduce [
											'pen colors/true 'fill-pen colors/true 'circle sizes/cell * 2x2 sizes/cell * .75
										]
										show face
										pf/action/on-click pf
									]
								]
							]
							away [face/feel/over face false 0x0]
						]
					]
				]
			]
			pos: pos + off
			index: index + 1
		]
		;	initial selection
		all [
			integer? picked
			insert tail pane/:picked/effect/draw reduce [
				'pen colors/true 'fill-pen colors/true 'circle sizes/cell * 2x2 sizes/cell * .75
			]
		]
	]
]