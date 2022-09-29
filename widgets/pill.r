pill: make baseface [
	options: {
		USAGE:
			pill red

		DESCRIPTION:
			A rectangular area with rounded corners.
	}
	size: 10x10
	effect: [
		draw [
			pen colors/outline/3
			line-width 1
			fill-pen linear 0x0 0 0 90 1 1 colors/outline/1 white colors/outline/1
			box 0x0 0x0 effects/radius
		]
	]
	action: make default-action [
		on-resize: make function! [face] [
			either face/size/x >= face/size/y [
				poke face/effect/draw 8 to integer! face/size/y * .10
				poke face/effect/draw 9 to integer! face/size/y * .90
				poke face/effect/draw 10 90
			] [
				poke face/effect/draw 8 to integer! face/size/x * .10
				poke face/effect/draw 9 to integer! face/size/x * .90
				poke face/effect/draw 10 0
			]
			poke face/effect/draw 18 face/size - 1x1
		]
	]
	init: make function! [] [
		all [color set-color/no-show self color]
		all [font size/x: text-width?/pad self]
		action/on-resize self
	]
]