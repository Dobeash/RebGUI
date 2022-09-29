arrow: make gradface [
	options: {
		USAGE:
			arrow
			arrow 10
			arrow data 'up
			arrow data 'down
			arrow data 'left
			arrow data 'right

		DESCRIPTION:
			An arrow (default down) on a square button face with height set to width.
	}
	size: 5x-1
	text: none
	data: 'down
	font: none
	feel: make feel-click [
		engage: make function! [face act event] [
			switch act [
				time [all [over? face event face/data face/action/on-click face]]
				down [set-state face face/data: on]
				up [all [over? face event face/action/on-click face] set-state face face/data: off]
				over [face/feel/over/state face face/data: on 0x0]
				away [face/feel/over/state face face/data: off 0x0]
			]
		]
	]
	action: default-action
	old-color: none
	init: make function! [] [
		all [color set-color/no-show self color]
		insert tail effect reduce ['arrow colors/text 'rotate select [up 0 right 90 down 180 left 270] data]
		effect/gradient: select [up 0x1 right 1x0 down 0x-1 left -1x0] data
		all [negative? size/y size/y: size/x] ; required by spinner
		data: off
	]
]