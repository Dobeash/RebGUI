toggle: make btn [
	options: {
		USAGE:
			toggle data ["A" "B"]

		DESCRIPTION:
			Toggles state when clicked.

		OPTIONS:
			'on starts selected
	}
	size: 15x5
	text: ""
	font: font-button
	feel: make object! [
		redraw:
		detect: none
		over: make function! [face into pos /state] [
			all [state set-state/no-show face into]
			set-color face either into [colors/theme/1] [none]
		]
		engage: make function! [face act event] [
			switch act [
				down [face/feel/over/state face on 0x0]
				up [
					if over? face event [
						face/data: complement face/data
						face/text: pick face/texts face/data
						face/effect/gradient: pick [0x-1 0x1] face/data
						face/edge/size: pick [2x2 1x1] face/data
						face/action/on-click face
					]
					set-state face off
				]
				over [face/feel/over/state face on 0x0]
				away [face/feel/over/state face off 0x0]
			]
		]
	]
	action: default-action
	old-color: none
	texts: none
	init: make function! [] [
		edge: make default-edge []
		texts: reverse data
		data: either all [options find options 'on] [true] [false]
		text: pick texts data
		effect/gradient: pick [0x-1 0x1] data
		edge/size: pick [2x2 1x1] data
		all [color set-color/no-show self color]
		all [font size/x: text-width?/pad self]
	]
]