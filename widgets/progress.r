progress: make baseface [
	options: {
		USAGE:
			progress
			progress data .5

		DESCRIPTION:
			A horizontal progress indicator.
			At runtime face/data ranges from 0 to 1 indicating percentage.
	}
	size: 50x5
	effect: [draw [pen colors/theme/2 fill-pen colors/theme/2 box 1x1 1x1]]
	data: 0
	edge: default-edge
	feel: make default-feel [
		redraw: make function! [face act pos] [
			all [
				act = 'show
				face/effect/draw/7/x: max 1 face/size/x - 4 * face/data: min 1 max 0 face/data
			]
		]
	]
	action: make default-action [
		on-resize: make function! [face] [face/effect/draw/6/y: face/size/y - 4]
	]
	init: make function! [] [action/on-resize self]
]