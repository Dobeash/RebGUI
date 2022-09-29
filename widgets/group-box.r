group-box: make baseface [
	options: {
		USAGE:
			group-box "Title" data [field field]

		DESCRIPTION:
			A static widget used to group widgets within a bounded container.
	}
	size: -1x-1
	text: ""
	effect: [draw [pen colors/outline/3 line-width 1 fill-pen none box 0x0 0x0 effects/radius]]
	font: make font-top [color: colors/outline/3]
	para: make default-para [origin: as-pair sizes/cell * 4 0]
	feel: make default-feel [
		redraw: make function! [face act pos] [
			if act = 'show [
				all [; handle color change
					face/color
					face/effect/draw/fill-pen: face/color
					poke face/effect/draw 12 face/color
					face/color: none
				]
				all [; handle text change
					clear skip face/effect/draw 10
					unless empty? face/text [
						insert tail face/effect/draw reduce [
							'pen colors/page 'line
							3x2 * sizes/cell
							as-pair sizes/cell * 5 + first size-text face sizes/cell * 2
						]
					]
				]
			]
		]
	]
	action: make default-action [
		on-resize: make function! [face] [
			poke face/effect/draw 9 face/size - 1x1
		]
	]
	group: none
	init: make function! [] [
		data: layout/only data
		group: pane: data/pane
		foreach face pane [face/offset: face/offset + as-pair 0 sizes/cell * sizes/gap]
		all [negative? size/x size/x: max 16 + first size-text self data/size/x]
		all [negative? size/y size/y: sizes/cell * sizes/gap + data/size/y]
		effect/draw/box/y: sizes/cell * 2
		data: none
		action/on-resize self
	]
]