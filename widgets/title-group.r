title-group: make baseface [
	options: {
		USAGE:
			title-group %icons/setup.png data "Title" "Body"

		DESCRIPTION:
			A title and text with an optional image to the left.
			If an image is specified then height is set to image height.
	}
	font: font-top
	init: make function! [/local p indent] [
		indent: either image [size/y: image/size/y image/size/x + sizes/line] [sizes/line]
		p: self
		;	create title text
		pane: make baseface [
			offset: as-pair indent sizes/line
			size: as-pair p/size/x - indent - sizes/line 10000
			text: p/data
			font: font-heading
		]
		pane/size: 5x5 + size-text pane
		;	create body text
		para: make para-wrap compose [
			origin: (as-pair indent p/pane/size/y + sizes/line + sizes/line)
			margin: (as-pair sizes/line 0)
		]
		;	auto-height?
		all [not image negative? size/y size/y: 10000 size/y: para/origin/y + second size-text self]
		data: none
	]
]