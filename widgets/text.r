text: make baseface [
	options: {
		USAGE:
			text "A text string."
			text "Blue text" text-color blue
			text "Bold text" bold
			text "Italic text" italic
			text "Underline text" underline

		DESCRIPTION:
			Normal text.
	}
	size: -1x5
	text: ""
	font: default-font
	para: para-wrap
	init: make function! [] [
		all [find text "^/" size/y = sizes/line size/y: -1]
		all [negative? size/x negative? size/y size: 10000x10000 size: 4x4 + size-text self]
		all [negative? size/x size/x: 10000 size/x: 4 + first size-text self]
		all [positive? size/y size/x < first text-size? text size/y: -1]
		all [negative? size/y size/y: 10000 size/y: 4 + second size-text self]
		either size/y > sizes/line [font: make font [valign: 'top]] [para: none]
		size/y: max size/y sizes/line
	]
]