slider: make gradface [
	options: {
		USAGE:
			slider []
			slider data .5 [print face/data]

		DESCRIPTION:
			A slider control. Its size determines whether it is vertical or horizontal.
			At runtime face/data ranges from 0 to 1 indicating percentage.

		OPTIONS:
			[ratio n] where n indicates the initial dragger size
	}
	size: 5x50
	pane: []
	data: 0
	feel: make feel-click [
		redraw: make function! [face act pos /local n] [
			if all [
				act = 'show
				n: face/axis
				face/state <> reduce [to integer! face/size/:n * face/ratio face/data face/ratio]
			][
				face/pane/1/size/:n: face/size/:n * face/ratio
				face/pane/1/offset/:n: face/size/:n * face/data - (face/pane/1/size/:n / 2)
				face/pane/1/offset/:n: face/size/:n - face/pane/1/size/:n * face/data - 1
				face/state: reduce [face/pane/1/size/:n face/data face/ratio]
				all [face/old-size face/action/on-click face] ; this line must appear last!!!
			]
		]
		engage: make function! [face act event] [
			switch act [
				down [face/feel/over/state face on 0x0 face/update-data event/offset]
				up [set-state face off]
				over [face/feel/over/state face on 0x0]
				away [face/feel/over/state face off 0x0]
			]
		]
	]
	set-data: make function! [new [integer! decimal! pair!]] [
		new: min 1 max 0 either pair? new [
			data + either negative? new/y [negate step] [step]
		] [new]
		all [data <> new data: new show self]
	]
	;	custom facets
	ratio: 0.1
	step: 0.05
	axis: 2
	state: none

	update-data: make function! [offset [pair!] /local new] [
		unless ratio = 1 [
			new: min 1 max 0 offset/:axis - (pane/1/size/:axis / 2) / (size/:axis - pane/1/size/:axis)
			all [data <> new data: new show self]
		]
	]

	init: make function! [/local p] [
		all [block? options find options 'ratio ratio: select options 'ratio]
		data: min 1 max 0 data
		ratio: min 1 max .1 ratio
		p: self
		insert tail pane make gradface [
			offset: -1x-1
			size: min p/size reverse p/size
			text: "="
			feel: make feel-click [
				over: make function! [face into pos /state] [
					all [state set-state/no-show face into]
					face/parent-face/feel/over/state face/parent-face off 0x0
					set-color face either into [colors/theme/1] [none]
				]
				engage: make function! [face act event] [
					switch act [
						down [set-state face on face/parent-face/update-data face/offset + event/offset]
						up [face/feel/over/state face off 0x0]
						over [face/parent-face/update-data face/offset + event/offset]
						away [face/parent-face/update-data face/offset + event/offset]
					]
				]
			]
		]
		axis: either size/y > size/x [
			effect/gradient: -1x0
			effect/4: colors/outline/2
			2
		] [
			effect/gradient: 0x-1
			effect/4: colors/outline/2
			pane/1/text: "+"
			1
		]
	]
]