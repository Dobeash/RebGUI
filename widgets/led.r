led: make baseface [
	options: {
		USAGE:
			led "Option"
			led "Option" data true
			led "Option" data false
			led "Option" data none

		DESCRIPTION:
			Tristate indicator box with colors representing Yes & No, and empty being Unknown.
	}
	size: -1x5
	effect: compose/deep [draw [pen (colors/outline/3) fill-pen (colors/page) circle (sizes/cell * 2x2) (sizes/cell * 1.5)]]
	font: default-font
	para: para-indent
	feel: make default-feel [
		redraw: make function! [face act pos] [
			all [
				act = 'show
				face/effect/draw/fill-pen: select reduce [true colors/true false colors/false] face/data
			]
		]
	]
	init: make function! [] [
		if negative? size/x [size/x: 10000 size/x: 4 + para/origin/x + first size-text self]
	]
]