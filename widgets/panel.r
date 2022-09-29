panel: make baseface [
	options: {
		USAGE:
			panel data [after 1 field field]

		DESCRIPTION:
			A static widget used to group widgets within a container.
	}
	size: -1x-1
	effect: [draw [pen colors/outline/3 line-width 1 fill-pen colors/edit box 0x0 0x0 effects/radius]]
	action: make default-action [
		on-resize: make function! [face] [
			poke face/effect/draw 9 face/size - 1x1
		]
	]
	group: pane
	init: make function! [] [
		data: layout/only data
		group: pane: data/pane
		all [negative? size/x size/x: data/size/x]
		all [negative? size/y size/y: data/size/y]
		poke effect/draw 9 size - 1x1
		data: none
	]
]