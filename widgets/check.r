check: make baseface [
	options: {
		USAGE:
			check "Option"
			check "Option" data true
			check "Option" data false

		DESCRIPTION:
			Bistate check-box with a tick for Yes and empty for No.
	}
	size: -1x5
	text: ""
	effect: [draw [pen colors/outline/3 fill-pen colors/edit box 0x0 0x0]]
	font: default-font
	para: para-indent
	feel: make default-feel [
		over: make function! [face act pos] [
			face/effect/draw/pen: either act [colors/theme/1] [colors/outline/3]
			show face
		]
		engage: make function! [face act event] [
			switch act [
				down [
					face/data: either none? face/data [true] [none]
					clear skip face/effect/draw 7
					unless none? face/data [
						insert tail face/effect/draw reduce [
							'pen colors/true
							'line-width sizes/cell / 3
							'line as-pair 2 sizes/cell * 3 as-pair sizes/cell * 1.5 p2/y as-pair p2/x p1/y
						]
					]
					show face
					face/action/on-click face
				]
				away [face/feel/over face false 0x0]
			]
		]
	]
	action: default-action
	p1: as-pair 2 sizes/cell + 2
	p2: -4x-4 + p1 + as-pair sizes/cell * 3 sizes/cell * 3
	init: make function! [] [
		all [negative? size/x size/x: 10000 size/x: 4 + para/origin/x + first size-text self]
		effect/draw/6/y: sizes/cell
		effect/draw/7: as-pair sizes/cell * 3 sizes/cell * 4
		all [
			data
			insert tail effect/draw reduce [
				'pen colors/true
				'line-width sizes/cell / 3
				'line as-pair 2 sizes/cell * 3 as-pair sizes/cell * 1.5 p2/y as-pair p2/x p1/y
			]
		]
	]
]