icon: make arrow [
	options: {
		USAGE:
			icon %actions/go-up.png

		DESCRIPTION:
			An icon.
	}
	size: 5x5
	pane: []
	init: make function! [/local v p] [
		all [color set-color/no-show self color]
		size: max size 18x18
		size/y: size/x
		v: case [32 < size/x [32x32] 22 < size/x [22x22] true [16x16]]
		p: self
		insert pane make baseface [
			offset: p/size - v / 2 - 1x1
			size: v
			image: load-icon v p/image
		]
		image: none
		data: off
	]
]