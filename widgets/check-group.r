check-group: make baseface [
	options: {
		USAGE:
			check-group data ["Option-1" true "Option-2" false "Option-3" none]

		DESCRIPTION:
			Group of check boxes.
			Alignment is vertical unless height is specified as line height.
			At runtime face/data is a block of logic (or none) indicating state of each check box.
	}
	size: 50x-1
	pane: []
	init: make function! [/local off siz pos last-pane] [
		data: reduce data
		all [negative? size/y size/y: .5 * sizes/line * length? data]
		off: either size/y > sizes/line [
			siz: as-pair size/x sizes/line
			as-pair 0 sizes/line
		] [
			siz: as-pair 2 * size/x / length? data sizes/line
			as-pair siz/x 0
		]
		pos: 0x0
		foreach [label state] data [
			insert tail pane make check [
				offset: pos
				size: siz
				text: label
				data: state
			]
			pos: pos + off
			last-pane: last pane
			last-pane/options: options
			last-pane/init
			last-pane/init: none
		]
		data: make function! [/local states] [
			states: copy []
			foreach check pane [insert tail states check/data]
			states
		]
	]
]